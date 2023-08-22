part of drift_db;

enum QueryFragmentWhereType {
  /// 查询全部碎片。
  all,

  /// 查询 [Fragment.isSelected] 为 true 的碎片。
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

  // Future<Fragment> queryFragmentById({required int id}) async {
  //   return await (select(fragments)..where((tbl) => tbl.id.equals(id))).getSingle();
  // }

  /// 查询全部游离态的 [Fragment]，即没有对应的 [RFragment2FragmentGroup] 的 [Fragment]
  Future<List<Fragment>> queryAllFreeFragment() async {
    throw "TODO";
    final j = select(fragments).join(
      [leftOuterJoin(rFragment2FragmentGroups, fragments.id.equalsExp(rFragment2FragmentGroups.fragment_id))],
    );
    j.where(rFragment2FragmentGroups.id.isNull());
    return (await j.get()).map((e) => e.readTable(fragments)).toList();
  }

  /// 查询封面需要上传图片的碎片组
  ///
  /// [count] - 要获取的的数量，为 null 的话获取全部
  Future<List<FragmentGroup>> queryManyFragmentGroupForCoverImageNeedUpload({required int? count}) async {
    throw "TODO";
    // final sel = select(fragmentGroups);
    // sel.where((tbl) => tbl.client_be_cloud_path_upload.equals(true));
    // if (count != null) {
    //   sel.limit(10);
    // }
    // return await sel.get();
  }
}
