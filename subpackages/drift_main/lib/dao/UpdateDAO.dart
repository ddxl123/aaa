part of drift_db;

/// xxx.reset 专用。
typedef ResetFutureFunction = Future<void> Function(SyncTag resetSyncTag);

/// TODO: 所有curd函数体都要包裹上事务, withRefs 内部自带事务。
///
///
@DriftAccessor(
  tables: [
    ...cloudTableClass,
    ...rTableClass,
  ],
)
class UpdateDAO extends DatabaseAccessor<DriftDb> with _$UpdateDAOMixin {
  UpdateDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<void> resetMemoryGroup({required ResetFutureFunction oldMemoryGroupReset}) async {
    await withRefs(
      () async {
        final resetSyncTag = await SyncTag.create();
        return RefMemoryGroups(
          self: (table) async {
            await oldMemoryGroupReset(resetSyncTag);
          },
          // TODO:
          fragmentMemoryInfos: null,
          // TODO:
          rFragment2MemoryGroups: null,
        );
      },
    );
  }

  Future<void> resetMemoryModel({required ResetFutureFunction oldMemoryModelReset}) async {
    await withRefs(
      () async {
        final resetSyncTag = await SyncTag.create();
        return RefMemoryModels(
          self: (table) async {
            await oldMemoryModelReset(resetSyncTag);
          },
          // TODO: 需要检测。
          memoryGroups: null,
        );
      },
    );
  }
}
