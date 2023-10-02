part of drift_db;

enum QueryFragmentWhereType {
  /// 查询全部碎片。
  all,

  /// 查询 [Fragment.isSelectedUnit] 为 true 的碎片。
  selected,
}

/// TODO: 所有curd函数体都要包裹上事务。
@DriftAccessor(
  tables: tableClasses,
)
class GeneralQueryDAO extends DatabaseAccessor<DriftDb> with _$GeneralQueryDAOMixin {
  GeneralQueryDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<User?> queryUserOrNull() async {
    final manyUsers = await select(users).get();
    if (manyUsers.length > 1) {
      throw "本地存在多个用户！";
    }
    return manyUsers.isEmpty ? null : manyUsers.first;
  }

  /// 在查询前，必须已插入过，否则抛出异常
  ///
  /// 如果 [deviceInfo] 与本地查询到的不一致，则抛出异常
  Future<ClientSyncInfo> queryClientSyncInfo([String? deviceInfo]) async {
    final result = await queryClientSyncInfoOrNull();
    if (result == null) throw "ClientSyncInfo 不应该为空";
    if (deviceInfo != null && result.device_info != deviceInfo) throw "响应的 deviceInfo 与本地查询到的不一致！";
    return result;
  }

  Future<ClientSyncInfo?> queryClientSyncInfoOrNull() async {
    final sel = await select(clientSyncInfos).get();
    if (sel.length > 1) throw "本地存在多个客户端同步信息！";
    return sel.isEmpty ? null : sel.first;
  }

  Future<MemoryGroup?> queryOrNullMemoryGroup({required int memoryGroupId}) async {
    return await (select(memoryGroups)..where((tbl) => tbl.id.equals(memoryGroupId))).getSingleOrNull();
  }

  Future<MemoryModel?> queryOrNullMemoryModel({required int memoryGroupId}) async {
    return await (select(memoryModels)..where((tbl) => tbl.id.equals(memoryGroupId))).getSingleOrNull();
  }

  Future<int> queryFragmentInMemoryGroupCount({required int memoryGroupId}) async {
    final result = await (select(fragmentMemoryInfos)..where((tbl) => tbl.memory_group_id.equals(memoryGroupId))).get();
    return result.length;
  }

  Future<List<FragmentMemoryInfo>> queryManyMemoryInfoByStudyStatus({
    required int memoryGroupId,
    required StudyStatus studyStatus,
  }) async {
    return await (select(fragmentMemoryInfos)..where((tbl) => tbl.memory_group_id.equals(memoryGroupId) & tbl.study_status.equalsValue(studyStatus))).get();
  }
}
