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

  // 批量删除已同步的 sync
  // TODO: 是否需要 [SyncTag]
  Future<void> rowDeleteUploadedSync({required List<Sync> syncs}) async {
    if (syncs.isEmpty) return;
    await transaction(
      () async {
        await db.batch(
          (batch) {
            // TODO: 是 delete 还是 deleteAll
            batch.delete(db.syncs, syncs.first);
          },
        );
      },
    );
  }

  // 删除一条 sync
  // TODO: 是否需要 [SyncTag]
  Future<void> deleteSingleSync({required Sync sync}) async {
    await sync.delete(syncTag: await SyncTag.create());
  }

  /// 删除游离态的 [Fragment]
  Future<void> deleteAllFreeFragment({required SyncTag syncTag, required int userId}) async {
    await RefFragments(
      self: () async {
        final fs = await db.generalQueryDAO.queryAllFreeFragment();
        for (var v in fs) {
          await v.delete(
            syncTag: syncTag,
            isCloudTableWithSync: SyncTag.parseToUserId(v.id) == userId,
          );
        }
      },
      fragmentMemoryInfos: null,
      rFragment2FragmentGroups: null,
      fragments_father_fragment_id: null,
      memoryModels: null,
      userComments: null,
      userLikes: null,
      order: 0,
    ).run();
  }
}
