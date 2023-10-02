part of drift_db;

const bool isLogStatements = true;

/// 执行：flutter packages pub run build_runner build --delete-conflicting-outputs
///
///
///
/// 惰性启动。每次启动app后，在第一次对数据库操作时，才会调用一次，且只会调用一次，不能动态修改。
LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      // 要创建/启动的数据库名称。
      const String dbFileName = 'db.sqlite';
      // 获取数据库所在的文件夹路径
      final dbFolder = await getApplicationDocumentsDirectory();
      DriftDb.instance.path = join(dbFolder.path, dbFileName);
      return NativeDatabase(File(DriftDb.instance.path), logStatements: isLogStatements);
    },
  );
}

@DriftDatabase(
  tables: [...tableClasses],
  daos: [
    InsertDAO,
    RawDAO,
    RegisterOrLoginDAO,
    UpdateDAO,
    DeleteDAO,
    GeneralQueryDAO,
  ],
)
class DriftDb extends _$DriftDb {
  DriftDb._() : super(_openConnection());

  static final DriftDb instance = DriftDb._();

  /// 数据库 path
  String path = '';

  /// 'Users' to [TableInfo].
  final Map<String, TableInfo> _dataClassName2TableInfoMap = {};

  /// 'users' to [TableInfo].
  final Map<String, TableInfo> _tableActualName2TableInfoMap = {};

  /// table 的版本号。
  ///
  /// 每次对 table 修改，都要加1。
  @override
  int get schemaVersion => 1;

  /// 每次 table 被修改，都要把变化的内容写到 [MigrationStrategy.onUpgrade] 里。
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          // 这里只有在用户第一次下载并打开本应用时才会执行。
        },
        onUpgrade: (Migrator m, int from, int to) async {},
        beforeOpen: (OpeningDetails details) async {
          transform();
          await _insertInitTestData();
          if (isLogStatements) {
            final result = await customSelect('SELECT sql FROM sqlite_master WHERE type = \'table\'').get();
            logger.outNormal(print: result.map((e) => e.data["sql"]).toList().join("\n"));
          }
        },
      );

  /// 插入初始化测试数据。
  Future<void> _insertInitTestData() async {
    // if ((await select(users).getSingleOrNull()) == null) {
    //   Crt.usersCompanion(age: 999, email: email, password: password, token: token, username: username).insert(syncTag: syncTag)
    //   await into(users).insert(
    //     UsersCompanion(
    //       id: 1.toValue(),
    //       createdAt: DateTime.now().toValue(),
    //       updatedAt: DateTime.now().toValue(),
    //       username: '测试username'.toValue(),
    //       password: '测试password'.toValue(),
    //       email: '测试email'.toValue(),
    //       age: 999.toValue(),
    //     ),
    //   );
    // }
  }

  /// Convert to [TableInfo] using [entity] or type [E].
  ///
  /// If [entity] is empty, you can use [E] to convert.
  void transform() {
    if (_dataClassName2TableInfoMap.isEmpty) {
      for (var element in DriftDb.instance.allTables) {
        // '$UsersTable'
        final String tableInfoClassName = element.runtimeType.toString();
        // Users
        final String dataClassName = tableInfoClassName.substring(1, tableInfoClassName.length - 5);
        // {'Users':users}
        _dataClassName2TableInfoMap.addAll({dataClassName: element});
        // {'users':users}
        _tableActualName2TableInfoMap.addAll({element.actualTableName: element});
      }
    }
  }

  TableInfo getTableInfoFromE<E extends Insertable, TableDsl extends Table, D>([E? entity]) {
    // 'User' or 'UsersCompanion'
    final String eName = E.toString();
    // Convert to 'Users'
    final TableInfo? tableInfo = (eName.length <= 9 || eName.substring(eName.length - 9, eName.length) != 'Companion')
        ? _dataClassName2TableInfoMap['${eName}s']
        : _dataClassName2TableInfoMap[eName.substring(0, eName.length - 9)];
    return tableInfo ?? (throw 'TableInfo not found: ${E.toString()}');
  }

  TableInfo getTableInfoFromTableActualName({required String tableActualName}) {
    return _tableActualName2TableInfoMap[tableActualName] ?? (throw 'TableInfo not found: $tableActualName');
  }
}

DriftDb get driftDb => DriftDb.instance;
