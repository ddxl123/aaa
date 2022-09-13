part of drift_db;

/// TODO: 所有curd函数体都要包裹上事务。
@DriftAccessor(
  tables: [
    ...cloudTableClass,
    ...rTableClass,
  ],
)
class QueryDAO extends DatabaseAccessor<DriftDb> with _$QueryDAOMixin {
  QueryDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<User> queryUser() async {
    return await select(users).getSingle();
  }

  /// 查询已同步的、查询未同步的、查询未下载的
  Future<List<FragmentGroup>> queryFragmentGroups(String? fatherFragmentGroupId) async {
    return await (select(fragmentGroups)
          ..where(
              (tbl) => fatherFragmentGroupId == null ? tbl.fatherFragmentGroupId.isNull() : tbl.fatherFragmentGroupId.equals(fatherFragmentGroupId)))
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

  Future<Tuple2<Fragment, FragmentMemoryInfo?>?> queryFragmentsForDancer({required MemoryGroup mg}) async {
    // 查询记忆组内全部的碎片。
    Future<List<Fragment>> getFs() async => await queryFragmentsInMemoryGroup(mg.id);

    // 查询当前记忆组内的全部最新的记忆信息，及其对应的碎片。
    Future<List<TypedResult>> getAllEarliestReviews() async =>
        await (select(fragmentMemoryInfos).join([innerJoin(fragments, fragmentMemoryInfos.fragmentId.equalsExp(fragments.id))])
              ..where(fragmentMemoryInfos.memoryGroupId.equals(mg.id) &
                  fragmentMemoryInfos.isLatestRecord.equals(true) &
                  fragmentMemoryInfos.planedShowTime.isSmallerOrEqualValue(mg.reviewInterval)))
            .get();

    // 在复习区间内将可展示的全部复习碎片信息，及其对应的碎片。
    // 基于 getAllEarliestReviews，查询[下一次展示时间]小于等于[复习区间]，并早前晚后排序。
    Future<List<TypedResult>> getEarliestReviewsIntervalAndSort() async => ((await getAllEarliestReviews())
        .where((element) => element.readTable(fragmentMemoryInfos).planedShowTime.isBefore(mg.reviewInterval))
        .toList()
      ..sort(
        (a, b) => a.readTable(fragmentMemoryInfos).planedShowTime.compareTo(b.readTable(fragmentMemoryInfos).planedShowTime),
      ));

    // 基于 getEarliestReviewsIntervalAndSort 获取最早的复习碎片信息，及其对应的碎片。
    Future<TypedResult?> getEarliestReview() async {
      final glrias = await getEarliestReviewsIntervalAndSort();
      return glrias.isEmpty ? null : glrias.first;
    }

    // 基于 getAllEarliestReviews 筛选出新碎片，即在当前碎片组中没有记录的碎片。
    Future<List<Fragment>> getNewFs() async {
      final galr = await getAllEarliestReviews();
      return (await getFs()).where((element) => !galr.map((e) => e.readTable(fragmentMemoryInfos).fragmentId).contains(element.id)).toList();
    }

    // 基于 getNewFs，随机获取一个碎片。
    Future<Fragment?> getRandomNewF() async {
      final rfs = await getNewFs();
      return rfs.isEmpty ? null : rfs[Random().nextInt(rfs.length)];
    }

    final f = await getRandomNewF();
    final r = await getEarliestReview();
    if (f == null && r == null) return null;
    final ft = f == null ? null : Tuple2(t1: f, t2: null);
    final rt = r == null ? null : Tuple2(t1: r.readTable(fragments), t2: r.readTable(fragmentMemoryInfos));

    return await filterFuture<NewReviewDisplayOrder, Tuple2<Fragment, FragmentMemoryInfo?>?>(
      from: mg.newReviewDisplayOrder,
      targets: {
        [NewReviewDisplayOrder.mix]: () async => await filterFuture<NewDisplayOrder, Tuple2<Fragment, FragmentMemoryInfo?>?>(
              from: mg.newDisplayOrder,
              targets: {
                [NewDisplayOrder.random]: () async {
                  return Random().nextInt(1) == 0 ? (ft ?? rt) : (rt ?? ft);
                },
                [NewDisplayOrder.createEarly2Late]: null,
                [NewDisplayOrder.titleA2Z]: null,
              },
              orElse: null,
            ),
        [NewReviewDisplayOrder.newReview]: () async => await filterFuture<NewDisplayOrder, Tuple2<Fragment, FragmentMemoryInfo?>?>(
              from: mg.newDisplayOrder,
              targets: {
                [NewDisplayOrder.random]: () async {
                  return ft ?? rt;
                },
                [NewDisplayOrder.createEarly2Late]: () async => null,
                [NewDisplayOrder.titleA2Z]: () async => null,
              },
              orElse: null,
            ),
        [NewReviewDisplayOrder.reviewNew]: () async => await filterFuture<NewDisplayOrder, Tuple2<Fragment, FragmentMemoryInfo?>?>(
              from: mg.newDisplayOrder,
              targets: {
                [NewDisplayOrder.random]: () async {
                  return rt ?? ft;
                },
                [NewDisplayOrder.createEarly2Late]: () async => null,
                [NewDisplayOrder.titleA2Z]: () async => null,
              },
              orElse: null,
            ),
      },
      orElse: null,
    );
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

  Future<List<MemoryGroup>> queryMemoryGroups() async {
    return await select(memoryGroups).get();
  }

  Future<List<MemoryModel>> queryMemoryModels() async {
    return await select(memoryModels).get();
  }

  Future<List<Fragment>> queryFragmentsInMemoryGroup(String memoryGroupId) async {
    final j = select(fragments)
      ..join(
        [
          innerJoin(rFragment2MemoryGroups, rFragment2MemoryGroups.sonId.equalsExp(fragments.id)),
        ],
      )
      ..where((tbl) => rFragment2MemoryGroups.fatherId.equals(memoryGroupId));
    return await j.get();
  }

  Future<int> queryFragmentsInMemoryGroupForNotLearnCount(String memoryGroupId) async {
    final count = fragments.id.count();
    final exp = selectOnly(fragments)
      ..join([
        innerJoin(rFragment2MemoryGroups, rFragment2MemoryGroups.sonId.equalsExp(fragments.id), useColumns: false),
        innerJoin(memoryGroups, memoryGroups.id.equalsExp(rFragment2MemoryGroups.fatherId), useColumns: false),
      ])
      ..where(rFragment2MemoryGroups.fatherId.equals(memoryGroupId))
      ..addColumns([count]);

    final results = await exp.get();
    return results.map((e) => e.read(count)).first!;
  }

  Future<MemoryModel?> queryMemoryModelById({required String? memoryModelId}) async {
    if (memoryModelId == null) return null;
    return await (select(memoryModels)..where((tbl) => tbl.id.equals(memoryModelId))).getSingleOrNull();
  }
}
