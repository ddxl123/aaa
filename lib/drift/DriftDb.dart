import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'table/Cloud.dart';

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
      return NativeDatabase(File(join(dbFolder.path, dbFileName)));
    },
  );
}

@DriftDatabase(
  tables: [Users],
  daos: [],
  views: [],
)
class DriftDb extends _$DriftDb {
  DriftDb._() : super(_openConnection());

  static DriftDb? _instance;

  static DriftDb get instance {
    if (_instance == null) {
      _instance = DriftDb._();
      return _instance!;
    } else {
      return _instance!;
    }
  }

  /// table 的版本号。
  ///
  /// 每次对 table 修改，都要加1。
  @override
  int get schemaVersion => 1;

  /// 每次 table 被修改，都要把变化的内容写到 [MigrationStrategy.onUpgrade] 里。
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) => m.createAll(),
        onUpgrade: (Migrator m, int from, int to) async {},
      );
}
