part of drift_db;

/// xxx.reset 专用。
typedef FutureFunction = Future<void> Function();

/// TODO: 所有 reset 不再使用这样的函数，而是直接使用 [RefXXX]，例如直接使用 [RefFragments]。
@DriftAccessor(
  tables: tableClasses,
)
class UpdateDAO extends DatabaseAccessor<DriftDb> with _$UpdateDAOMixin {
  UpdateDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<void> resetClientSyncInfo({
    required ClientSyncInfo entity,
  }) async {
    await update(clientSyncInfos).write(entity);
  }

  Future<void> resetMemoryGroupAutoSyncVersion({
    required MemoryGroup entity,
  }) async {
    entity.sync_version += 1;
    await update(memoryGroups).replace(entity);
  }
}
