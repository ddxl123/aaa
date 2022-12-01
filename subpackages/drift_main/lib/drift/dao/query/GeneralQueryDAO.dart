part of drift_db;

/// TODO: 所有curd函数体都要包裹上事务。
@DriftAccessor(
  tables: tableClasses,
)
class GeneralQueryDAO extends DatabaseAccessor<DriftDb> with _$GeneralQueryDAOMixin {
  GeneralQueryDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<User?> queryUserOrNull() async {
    final manyUsers = await select(users).get();
    if (manyUsers.length > 1) {
      throw '暂时不能登录多个用户！';
    }
    return manyUsers.isEmpty ? null : manyUsers.first;
  }

  /// 查询已同步的、查询未同步的、查询未下载的
  Future<List<FragmentGroup>> queryFragmentGroups(String? fatherFragmentGroupId) async {
    // return await (select(fragmentGroups)
    //       ..where((tbl) => fatherFragmentGroupId == null ? tbl.fatherFragmentGroupId.isNull() : tbl.fatherFragmentGroupId.equals(fatherFragmentGroupId)))
    //     .get();
    return [];
  }

  Future<List<Fragment>> queryFragmentsByFragmentGroupId(String? fragmentGroupId) async {
    // final j = innerJoin(rFragment2FragmentGroups, rFragment2FragmentGroups.sonId.equalsExp(fragments.id));
    // final w = fragmentGroupId == null ? rFragment2FragmentGroups.fatherId.isNull() : rFragment2FragmentGroups.fatherId.equals(fragmentGroupId);
    // final List<TypedResult> result = await (select(fragments).join([j])..where(w)).get();
    // return result.map((e) => e.readTable(fragments)).toList();
    return [];
  }

  /// 只查询了未同步的。
  Future<List<Fragment>> queryFragmentsByIds(List<String> ids) async {
    return await (select(fragments)..where((tbl) => tbl.id.isIn(ids))).get();
  }

  /// 输入的 [ids] 与返回的对象是同一个对象。
  Future<List<String>> queryFragmentsForAllSubgroup(String fragmentGroupId, List<String> ids) async {
    // final fIds = (await queryFragmentsByFragmentGroupId(fragmentGroupId)).map((e) => e.id);
    // ids.addAll(fIds);
    // final fgIds = (await queryFragmentGroups(fragmentGroupId)).map((e) => e.id);
    // await Future.forEach<String>(
    //   fgIds,
    //   (fgId) async {
    //     await queryFragmentsForAllSubgroup(fgId, ids);
    //   },
    // );
    // return ids;
    return [];
  }

  Future<List<MemoryGroup>> queryAllMemoryGroups() async {
    return await select(memoryGroups).get();
  }

  Future<List<MemoryModel>> queryAllMemoryModels() async {
    return await select(memoryModels).get();
  }

  Future<List<Fragment>> queryAllFragmentsInMemoryGroup(String memoryGroupId) async {
    // final j = select(fragments).join(
    //   [
    //     innerJoin(rFragment2MemoryGroups, rFragment2MemoryGroups.sonId.equalsExp(fragments.id)),
    //   ],
    // )..where(rFragment2MemoryGroups.fatherId.equals(memoryGroupId));
    // final result = await j.get();
    // return result.map((e) => e.readTable(fragments)).toList();
    return [];
  }

  Future<MemoryModel?> queryMemoryModelById({required String? memoryModelId}) async {
    if (memoryModelId == null) return null;
    return await (select(memoryModels)..where((tbl) => tbl.id.equals(memoryModelId))).getSingleOrNull();
  }

  /// 获取 [mg] 内全部碎片数量。
  Future<int> getFragmentsCount({required MemoryGroup mg}) async {
    // final countExpr = fragments.id.count();
    // final lJoin = selectOnly(fragments).join([innerJoin(rFragment2MemoryGroups, rFragment2MemoryGroups.sonId.equalsExp(fragments.id))]);
    // lJoin.where(rFragment2MemoryGroups.fatherId.equals(mg.id));
    // final result = await lJoin.getSingle();
    // return result.read(countExpr)!;
    return 0;
  }

  /// 获取 [mg] 内已经学习过至少一次的碎片数量。
  Future<int> getLearnedFragmentsCount({required MemoryGroup mg}) async {
    // final countExpr = fragments.id.count();
    // final lSelect = selectOnly(fragments);
    // final lJoin = [
    //   innerJoin(fragmentMemoryInfos, fragmentMemoryInfos.fragmentId.equalsExp(fragments.id), useColumns: false),
    // ];
    // final lWhere = fragmentMemoryInfos.memoryGroupId.equals(mg.id) & fragmentMemoryInfos.isLatestRecord.equals(true);
    //
    // final doJoin = lSelect.join(lJoin);
    // doJoin.addColumns([countExpr]);
    // doJoin.where(lWhere);
    //
    // final result = await doJoin.getSingle();
    // return result.read(countExpr)!;
    return 0;
  }

  /// 获取 [mg] 内从未学习过的碎片数量。
  ///
  /// 用 [mg] 内全部碎片数量，减去已学习过的碎片数量。
  Future<int> getNewFragmentsCount({required MemoryGroup mg}) async {
    // final allCountExpr = fragments.id.count();
    // final allCountSelect = selectOnly(fragments).join([
    //   innerJoin(rFragment2MemoryGroups, rFragment2MemoryGroups.sonId.equalsExp(fragments.id), useColumns: false),
    // ])
    //   ..where(rFragment2MemoryGroups.fatherId.equals(mg.id))
    //   ..addColumns([allCountExpr]);
    // final allCountResult = (await allCountSelect.getSingle()).read(allCountExpr)!;
    //
    // final learnedCountExpr = fragmentMemoryInfos.isLatestRecord.count();
    // final learnedCountSelect = selectOnly(fragmentMemoryInfos)
    //   ..where(fragmentMemoryInfos.memoryGroupId.equals(mg.id) & fragmentMemoryInfos.isLatestRecord.equals(true))
    //   ..addColumns([learnedCountExpr]);
    // final learnedCountResult = (await learnedCountSelect.getSingle()).read(learnedCountExpr)!;
    //
    // final diff = allCountResult - learnedCountResult;
    // if (diff < 0) {
    //   throw '查找出的数量小于0！';
    // }
    // return diff;
    return 0;
  }
}