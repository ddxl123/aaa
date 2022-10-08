part of drift_db;

/// TODO: 所有curd函数体都要包裹上事务。
@DriftAccessor(
  tables: [
    ...cloudTableClass,
    ...rTableClass,
  ],
)
class DancerQueryDAO extends DatabaseAccessor<DriftDb> with _$DancerQueryDAOMixin {
  DancerQueryDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  /// 相似：[GeneralQueryDAO.getLearnedFragmentsCount]
  Future<Tuple2<Fragment, FragmentMemoryInfo>?> getEarliestLearnedFragment({required MemoryGroup mg}) async {
    final lSelect = select(fragments);
    final lJoin = [
      innerJoin(fragmentMemoryInfos, fragmentMemoryInfos.fragmentId.equalsExp(fragments.id)),
    ];
    final lWhere = fragmentMemoryInfos.memoryGroupId.equals(mg.id) &
        fragmentMemoryInfos.isLatestRecord.equals(true) &
        fragmentMemoryInfos.planedShowTime.isSmallerOrEqualValue(mg.reviewInterval);

    final doJoin = lSelect.join(lJoin);
    doJoin.where(lWhere);
    doJoin.orderBy([OrderingTerm.asc(fragmentMemoryInfos.planedShowTime)]);
    doJoin.limit(1);

    final result = await doJoin.getSingleOrNull();
    if (result == null) return null;
    return Tuple2(t1: result.readTable(fragments), t2: result.readTable(fragmentMemoryInfos));
  }

  /// 相似：[GeneralQueryDAO.getNewFragmentsCount]
  Future<Fragment?> getNewFragment({required MemoryGroup mg}) async {
    final lSelect = select(fragments);
    final lJoin = [
      innerJoin(rFragment2MemoryGroups, rFragment2MemoryGroups.sonId.equalsExp(fragments.id)),
      leftOuterJoin(fragmentMemoryInfos, fragmentMemoryInfos.fragmentId.equalsExp(fragments.id)),
    ];
    final lWhere = rFragment2MemoryGroups.fatherId.equals(mg.id) & fragmentMemoryInfos.id.isNull();

    final doJoin = lSelect.join(lJoin);
    doJoin.where(lWhere);
    if (mg.newDisplayOrder == NewDisplayOrder.random) {
      doJoin.orderBy([OrderingTerm.random()]);
    } else {
      throw '未处理 ${mg.newDisplayOrder}';
    }
    doJoin.limit(1);

    final result = await doJoin.getSingleOrNull();
    if (result == null) return null;
    return result.readTable(fragments);
  }

  Future<Tuple2<Fragment, FragmentMemoryInfo?>?> getDancer({required MemoryGroup mg}) async {
    final newFragment = await getNewFragment(mg: mg);
    final learnedFragment = await getEarliestLearnedFragment(mg: mg);

    if (newFragment == null && learnedFragment == null) return null;

    final newFragmentOrNull = newFragment == null ? null : Tuple2(t1: newFragment, t2: null);
    final learnedFragmentOrNull = learnedFragment == null ? null : Tuple2(t1: learnedFragment.t1, t2: learnedFragment.t2);

    return filter(
      from: mg.newReviewDisplayOrder,
      targets: {
        [NewReviewDisplayOrder.mix]: () => Random().nextInt(1) == 0 ? (newFragmentOrNull ?? learnedFragmentOrNull) : (learnedFragmentOrNull ?? newFragmentOrNull),
        [NewReviewDisplayOrder.newReview]: () => newFragmentOrNull ?? learnedFragmentOrNull,
        [NewReviewDisplayOrder.reviewNew]: () => learnedFragmentOrNull ?? newFragmentOrNull,
      },
      orElse: null,
    );
  }

  int getStartTimeStamp({required MemoryGroup mg}) {
    if (mg.startTime == null) throw '启动时间为 null！';
    return mg.startTime!.millisecondsSinceEpoch ~/ 1000;
  }

  Future<int> getCountAll({required MemoryGroup mg}) async {
    return await DriftDb.instance.generalQueryDAO.getFragmentsCount(mg: mg);
  }

  Future<int> getCountNew({required MemoryGroup mg}) async {
    return await DriftDb.instance.generalQueryDAO.getNewFragmentsCount(mg: mg);
  }

  Future<int> getTimes({required MemoryGroup mg, required Tuple2<Fragment, FragmentMemoryInfo?> tuple}) async {
    if (tuple.t2 == null) return 1;
    final countExpr = fragmentMemoryInfos.id.count();
    final lSelect = selectOnly(fragmentMemoryInfos);
    lSelect.where(fragmentMemoryInfos.memoryGroupId.equals(mg.id) & fragmentMemoryInfos.fragmentId.equals(tuple.t1.id));
    lSelect.addColumns([countExpr]);
    final result = await lSelect.getSingle();
    return result.read(countExpr)! + 1;
  }

  int getActualShowTime({required MemoryGroup mg}) {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000 - getStartTimeStamp(mg: mg);
  }

  int getPlanedShowTime(){

  }
}
