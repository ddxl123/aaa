part of drift_db;

@DriftAccessor(
  tables: tableClasses,
)
class InsertDAO extends DatabaseAccessor<DriftDb> with _$InsertDAOMixin {
  InsertDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<void> insertClientSyncInfo({
    required String deviceInfo,
    required String token,
  }) async {
    final find = await driftDb.generalQueryDAO.queryClientSyncInfoOrNull();
    if (find != null) throw "本地已存在客户端同步信息！";
    await driftDb.into(clientSyncInfos).insert(
          ClientSyncInfosCompanion.insert(
            device_info: deviceInfo,
            token: Value(token),
            created_at: DateTime.now(),
            updated_at: DateTime.now(),
          ),
        );
  }

  Future<void> insertFragment({required Fragment f}) async {
    await driftDb.into(fragments).insert(f, mode: InsertMode.insertOrReplace);
  }

  Future<void> insertMemoryGroup({
    required MemoryGroup memoryGroup,
  }) async {
    memoryGroup.be_synced = true;
    await driftDb.into(memoryGroups).insert(memoryGroup, mode: InsertMode.insertOrReplace);
  }

  Future<void> insertManyMemoryGroups({
    required List<MemoryGroup> mgs,
  }) async {
    await batch(
      (batch) async {
        for (var e in mgs) {
          e.be_synced = true;
        }
        batch.insertAll(memoryGroups, mgs, mode: InsertMode.insertOrReplace);
      },
    );
  }

  Future<void> insertMemoryModel({
    required MemoryModel memoryModel,
  }) async {
    await driftDb.into(memoryModels).insert(memoryModel, mode: InsertMode.insertOrReplace);
  }

  Future<void> insertManyMemoryModels({
    required List<MemoryModel> mms,
  }) async {
    await batch(
      (batch) async {
        batch.insertAll(memoryModels, mms, mode: InsertMode.insertOrReplace);
      },
    );
  }

  /// 注意：要先在云端中插入，后才能插入带有 id 的行。
  Future<void> insertManyFragmentAndMemoryInfos({
    required List<FragmentAndMemoryInfo> fragmentAndMemoryInfos,
  }) async {
    await driftDb.batch(
      (batch) async {
        final fs = <Fragment>[];
        final mis = <FragmentMemoryInfo>[];
        for (var element in fragmentAndMemoryInfos) {
          fs.add(element.fragment);
          mis.add(element.memory_info);
        }

        /// 如果存在相同，则覆盖。
        batch.insertAll(fragments, fs, mode: InsertMode.insertOrReplace);

        /// 如果存在相同，则覆盖。
        batch.insertAll(fragmentMemoryInfos, mis, mode: InsertMode.insertOrReplace);
      },
    );
  }
}
