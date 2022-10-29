part of drift_db;

/// TODO: 所有curd函数体都要包裹上事务。
@DriftAccessor(
  tables: [
    ...cloudTableClass,
    ...rTableClass,
  ],
)
class GeneralQueryDAO extends DatabaseAccessor<DriftDb> with _$GeneralQueryDAOMixin {
  GeneralQueryDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<User> queryUser() async {
    return await select(users).getSingle();
  }

  /// 查询已同步的、查询未同步的、查询未下载的
  Future<List<FragmentGroup>> queryFragmentGroups(String? fatherFragmentGroupId) async {
    return await (select(fragmentGroups)
          ..where((tbl) => fatherFragmentGroupId == null ? tbl.fatherFragmentGroupId.isNull() : tbl.fatherFragmentGroupId.equals(fatherFragmentGroupId)))
        .get();
  }

  Future<List<Fragment>> queryFragmentsByFragmentGroupId(String? fragmentGroupId) async {
    final j = innerJoin(rFragment2FragmentGroups, rFragment2FragmentGroups.sonId.equalsExp(fragments.id));
    final w = fragmentGroupId == null ? rFragment2FragmentGroups.fatherId.isNull() : rFragment2FragmentGroups.fatherId.equals(fragmentGroupId);
    final List<TypedResult> result = await (select(fragments).join([j])..where(w)).get();
    return result.map((e) => e.readTable(fragments)).toList();
  }

  /// 只查询了未同步的。
  Future<List<Fragment>> queryFragmentsByIds(List<String> ids) async {
    return await (select(fragments)..where((tbl) => tbl.id.isIn(ids))).get();
  }

  /// 输入的 [ids] 与返回的对象是同一个对象。
  Future<List<String>> queryFragmentsForAllSubgroup(String fragmentGroupId, List<String> ids) async {
    final fIds = (await queryFragmentsByFragmentGroupId(fragmentGroupId)).map((e) => e.id);
    ids.addAll(fIds);
    final fgIds = (await queryFragmentGroups(fragmentGroupId)).map((e) => e.id);
    await Future.forEach<String>(
      fgIds,
      (fgId) async {
        await queryFragmentsForAllSubgroup(fgId, ids);
      },
    );
    return ids;
  }

  Future<List<MemoryGroup>> queryAllMemoryGroups() async {
    return await select(memoryGroups).get();
  }

  Future<List<MemoryModel>> queryAllMemoryModels() async {
    return await select(memoryModels).get();
  }

  Future<List<Fragment>> queryAllFragmentsInMemoryGroup(String memoryGroupId) async {
    final j = select(fragments).join(
      [
        innerJoin(rFragment2MemoryGroups, rFragment2MemoryGroups.sonId.equalsExp(fragments.id)),
      ],
    )..where(rFragment2MemoryGroups.fatherId.equals(memoryGroupId));
    final result = await j.get();
    return result.map((e) => e.readTable(fragments)).toList();
  }

  Future<MemoryModel?> queryMemoryModelById({required String? memoryModelId}) async {
    if (memoryModelId == null) return null;
    return await (select(memoryModels)..where((tbl) => tbl.id.equals(memoryModelId))).getSingleOrNull();
  }

  /// 获取 [mg] 内全部碎片数量。
  Future<int> getFragmentsCount({required MemoryGroup mg}) async {
    final countExpr = fragments.id.count();
    final lJoin = selectOnly(fragments).join([innerJoin(rFragment2MemoryGroups, rFragment2MemoryGroups.sonId.equalsExp(fragments.id))]);
    lJoin.where(rFragment2MemoryGroups.fatherId.equals(mg.id));
    final result = await lJoin.getSingle();
    return result.read(countExpr)!;
  }

  /// 获取 [mg] 内已经学习过至少一次的碎片数量。
  Future<int> getLearnedFragmentsCount({required MemoryGroup mg}) async {
    final countExpr = fragments.id.count();
    final lSelect = selectOnly(fragments);
    final lJoin = [
      innerJoin(fragmentMemoryInfos, fragmentMemoryInfos.fragmentId.equalsExp(fragments.id), useColumns: false),
    ];
    final lWhere = fragmentMemoryInfos.memoryGroupId.equals(mg.id) & fragmentMemoryInfos.isLatestRecord.equals(true);

    final doJoin = lSelect.join(lJoin);
    doJoin.addColumns([countExpr]);
    doJoin.where(lWhere);

    final result = await doJoin.getSingle();
    return result.read(countExpr)!;
  }

  /// 获取 [mg] 内从未学习过的碎片数量。
  ///
  /// 相似：[DancerQueryDAO.getOneNewFragment]
  Future<int> getNewFragmentsCount({required MemoryGroup mg}) async {
    final countExpr = fragments.id.count();
    final lSelect = select(fragments);
    final lJoin = [
      innerJoin(rFragment2MemoryGroups, rFragment2MemoryGroups.sonId.equalsExp(fragments.id), useColumns: true),
      leftOuterJoin(fragmentMemoryInfos, fragmentMemoryInfos.fragmentId.equalsExp(fragments.id), useColumns: true),
    ];
    // final lWhere = rFragment2MemoryGroups.fatherId.equals(mg.id) & fragmentMemoryInfos.id.isNull();

    final doJoin = lSelect.join(lJoin);
    // doJoin.where(lWhere);
    // doJoin.addColumns([countExpr]);

    final result = await doJoin.get();
    logger.d(JsonEncoder.withIndent(' ').convert(result.map((e) => e.rawData.data).toList()));
    return 1;
  }
}
