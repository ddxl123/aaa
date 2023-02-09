part of drift_db;

/// TODO: 所有curd函数体都要包裹上事务。
@DriftAccessor(
  tables: tableClasses,
)
class DeleteDAO extends DatabaseAccessor<DriftDb> with _$DeleteDAOMixin {
  DeleteDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  /// 清空数据库，自增列归零。
  Future<void> clearDb() async {
    await transaction(
      () async {
        await Future.forEach<TableInfo>(
          db.allTables,
          (element) async {
            await delete(element).go();
            await db.customStatement("DELETE FROM sqlite_sequence");
          },
        );
      },
    );
  }

  Future<void> rowDeleteUploadedSync({required List<Sync> syncs}) async {
    if (syncs.isEmpty) return;
    await transaction(
      () async {
        await db.batch(
          (batch) {
            batch.delete(db.syncs, syncs.first);
          },
        );
      },
    );
  }
}
