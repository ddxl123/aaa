library drift_db;

import 'dart:developer';
import 'dart:io';

import 'package:aaa/tool/Extensioner.dart';
import 'package:aaa/tool/Helper.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part './dao/MultiDAO.dart';

part './dao/SingleDAO.dart';

part './table/Base.dart';

part 'table/cloud/Cloud.dart';

part 'table/cloud/R.dart';

part 'table/local/Local.dart';

part 'table/Custom.dart';

part 'table/local/Sync.dart';

part './tool/Extensioner.dart';

/// 这个 part 让程序生成 DriftDb.g.dart 文件，并包含到当前文件中。
part 'DriftDb.g.dart';

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
    SingleDAO,
    MultiDAO,
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
      );

  /// Convert to [TableInfo] using [entity] or type [E].
  ///
  /// If [entity] is empty, you can use [E] to convert.
  TableInfo toTableInfo<E extends Insertable>([E? entity]) {
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
        ? _tableInfoMap[eName + 's']
        : _tableInfoMap[eName.substring(0, eName.length - 9)];
    return tableInfo ?? (throw 'TableInfo not found.');
  }
}
