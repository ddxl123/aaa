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

  Future<void> deleteSelected({required int userId}) async {
    final fgs = await db.generalQueryDAO.querySelectedFragmentGroups();
    final fTags = await db.generalQueryDAO.queryFragmentGroupTagsByFragmentGroupIds(fragmentGroupIds: fgs.map((e) => e.id).toList());

    final fs = await db.generalQueryDAO.querySelectedFragments();
    final rFs = await db.generalQueryDAO.queryRFragment2FragmentGroups(fragmentIds: fs.map((e) => e.id).toList());

    final st = await SyncTag.create();
    await RefFragmentGroups(
      self: () async {
        for (var element in fgs) {
          await element.delete(syncTag: st, isCloudTableWithSync: SyncTag.parseToUserId(element.id) == userId);
        }
      },
      fragmentGroupTags: RefFragmentGroupTags(
        self: () async {
          for (var fTag in fTags) {
            await fTag.delete(syncTag: st, isCloudTableWithSync: SyncTag.parseToUserId(fTag.id) == userId);
          }
        },
        order: 0,
      ),
      rFragment2FragmentGroups: RefRFragment2FragmentGroups(
        self: () async {
          for (var element in fs) {
            await element.delete(
              syncTag: st,
              isCloudTableWithSync: SyncTag.parseToUserId(element.id) == userId,
            );
          }
          for (var element in rFs) {
            await element.delete(
              syncTag: st,
              isCloudTableWithSync: SyncTag.parseToUserId(element.id) == userId,
            );
          }
        },
        order: 1,
      ),
      child_fragmentGroups: null,
      userComments: null,
      userLikes: null,
      order: 0,
    ).run();
  }
}
