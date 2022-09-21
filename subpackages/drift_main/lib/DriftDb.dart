library drift_db;

import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_custom/ReferenceTo.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tools/tools.dart';
import 'dart:math';

part 'dao/query/GeneralQueryDAO.dart';

part 'dao/InsertDAO.dart';

part 'dao/UpdateDAO.dart';

part 'dao/DeleteDAO.dart';

part 'table/Base.dart';

part 'table/cloud/Cloud.dart';

part 'table/cloud/R.dart';

part 'table/local/Local.dart';

part 'custom/sync_tag.dart';

part 'custom/memory_group_enum.dart';

part 'custom/sync_curd.dart';

part 'custom/drift_value.dart';

part 'table/local/Sync.dart';

part 'DriftDb.drift.dart';

part 'DriftDb.ref.dart';

part 'DriftDb.ctr.dart';

part 'DriftDb.reset.dart';

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
      return NativeDatabase(File(DriftDb.instance.path));
    },
  );
}

@DriftDatabase(
  tables: [
    ...cloudTableClass,
    ...rTableClass,
    ...localTableClass,
    ...syncTableClass,
  ],
  daos: [
    InsertDAO,
    UpdateDAO,
    GeneralQueryDAO,
    DeleteDAO,
  ],
)
class DriftDb extends _$DriftDb {
  DriftDb._() : super(_openConnection());

  static final DriftDb instance = DriftDb._();

  /// 数据库 path
  String path = '';

  /// 'Users' to [TableInfo].
  final Map<String, TableInfo> _tableInfoMap = {};

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
          await _insertInitTestData();
        },
      );

  /// 插入初始化测试数据。
  Future<void> _insertInitTestData() async {
    if ((await select(users).getSingleOrNull()) == null) {
      await into(users).insert(
        UsersCompanion(
          id: '1'.value(),
          createdAt: DateTime.now().value(),
          updatedAt: DateTime.now().value(),
          username: '测试username'.value(),
          password: '测试password'.value(),
          email: '测试email'.value(),
          age: 999.value(),
        ),
      );
    }
  }

  /// Convert to [TableInfo] using [entity] or type [E].
  ///
  /// If [entity] is empty, you can use [E] to convert.
  TableInfo toTableInfo<E extends Insertable, TableDsl extends Table, D>([E? entity]) {
    if (_tableInfoMap.isEmpty) {
      for (var element in DriftDb.instance.allTables) {
        // '$UsersTable'
        final String tableInfoClassName = element.runtimeType.toString();
        // Users
        final String dataClassName = tableInfoClassName.substring(1, tableInfoClassName.length - 5);
        // {'Users':users}
        _tableInfoMap.addAll({dataClassName: element});
      }
    }
    // 'User' or 'UsersCompanion'
    final String eName = E.toString();
    // Convert to 'Users'
    final TableInfo? tableInfo = (eName.length <= 9 || eName.substring(eName.length - 9, eName.length) != 'Companion')
        ? _tableInfoMap['${eName}s']
        : _tableInfoMap[eName.substring(0, eName.length - 9)];
    return tableInfo ?? (throw 'TableInfo not found.');
  }
}
