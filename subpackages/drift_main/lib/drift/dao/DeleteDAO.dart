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
          driftDb.allTables,
          (element) async {
            await delete(element).go();
            await driftDb.customStatement("DELETE FROM sqlite_sequence");
          },
        );
      },
    );
  }

  Future<void> deleteManyMemoryGroups({required Set<int> mgIds}) async {
    await batch(
      (batch) async {
        batch.deleteWhere(memoryGroups, (tbl) => tbl.id.isIn(mgIds));
      },
    );
  }

  Future<void> deleteAllMemoryModels() async {
    await delete(memoryModels).go();
  }
}
