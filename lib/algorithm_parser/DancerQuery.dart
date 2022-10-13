part of algorithm_parser;

class DancerQuery {
  final DriftDb driftDb = DriftDb.instance;

  /// 返回的 [FragmentMemoryInfo] 是当前碎片的最近一次实例。
  ///
  /// 相似：[GeneralQueryDAO.getLearnedFragmentsCount]
  Future<Tuple2<Fragment, FragmentMemoryInfo>?> getEarliestLearnedFragment({required MemoryGroup mg}) async {
    final lSelect = driftDb.select(driftDb.fragments);
    final lJoin = [
      innerJoin(driftDb.fragmentMemoryInfos, driftDb.fragmentMemoryInfos.fragmentId.equalsExp(driftDb.fragments.id)),
    ];
    final lWhere = driftDb.fragmentMemoryInfos.memoryGroupId.equals(mg.id) &
    driftDb.fragmentMemoryInfos.isLatestRecord.equals(true) &
    driftDb.fragmentMemoryInfos.planedShowTime.isSmallerOrEqualValue(mg.reviewInterval);

    final doJoin = lSelect.join(lJoin);
    doJoin.where(lWhere);
    doJoin.orderBy([OrderingTerm.asc(driftDb.fragmentMemoryInfos.planedShowTime)]);
    doJoin.limit(1);

    final result = await doJoin.getSingleOrNull();
    if (result == null) return null;
    return Tuple2(t1: result.readTable(driftDb.fragments), t2: result.readTable(driftDb.fragmentMemoryInfos));
  }

  /// 相似：[GeneralQueryDAO.getNewFragmentsCount]
  Future<Fragment?> getNewFragment({required MemoryGroup mg}) async {
    final lSelect = driftDb.select(driftDb.fragments);
    final lJoin = [
      innerJoin(driftDb.rFragment2MemoryGroups, driftDb.rFragment2MemoryGroups.sonId.equalsExp(driftDb.fragments.id)),
      leftOuterJoin(driftDb.fragmentMemoryInfos, driftDb.fragmentMemoryInfos.fragmentId.equalsExp(driftDb.fragments.id)),
    ];
    final lWhere = driftDb.rFragment2MemoryGroups.fatherId.equals(mg.id) & driftDb.fragmentMemoryInfos.id.isNull();

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
    return result.readTable(driftDb.fragments);
  }

  /// 获取当前需要展示的碎片，已经当前碎片的上一次展示信息。
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

  /// ========================================================================================

  int getStartTimeStamp({required MemoryGroup mg}) {
    if (mg.startTime == null) throw '启动时间为 null！';
    return mg.startTime!.millisecondsSinceEpoch ~/ 1000;
  }

  int differenceFromStartTimeStamp({required MemoryGroup mg, required DateTime dateTime}) {
    return dateTime.millisecondsSinceEpoch ~/ 1000 - getStartTimeStamp(mg: mg);
  }

  /// [InternalVariabler.ivgCountAllConst]
  Future<int> getCountAll({required MemoryGroup mg}) async {
    return await DriftDb.instance.generalQueryDAO.getFragmentsCount(mg: mg);
  }

  /// [InternalVariabler.ivsCountNewConst]
  Future<int> getCountNew({required MemoryGroup mg}) async {
    return await DriftDb.instance.generalQueryDAO.getNewFragmentsCount(mg: mg);
  }

  /// [InternalVariabler.ivsTimesConst]
  Future<int?> getTimes({required MemoryGroup mg, required Tuple2<Fragment, FragmentMemoryInfo?> tuple}) async {
    if (tuple.t2 == null) return 1;
    final countExpr = driftDb.fragmentMemoryInfos.id.count();
    final lSelect = driftDb.selectOnly(driftDb.fragmentMemoryInfos);
    lSelect.where(driftDb.fragmentMemoryInfos.memoryGroupId.equals(mg.id) & driftDb.fragmentMemoryInfos.fragmentId.equals(tuple.t1.id));
    lSelect.addColumns([countExpr]);
    final result = await lSelect.getSingle();
    return result.read(countExpr)! + 1;
  }

  /// [InternalVariabler.ivsActualShowTimeConst]
  Future<int?> getActualShowTime({required NTypeNumber? nTypeNumber, required MemoryGroup mg, required Tuple2<Fragment, FragmentMemoryInfo?> tuple}) async {
    final current = differenceFromStartTimeStamp(mg: mg, dateTime: DateTime.now());
    if (nTypeNumber == null) return current;
    if (nTypeNumber.nType == NType.times) {
      driftDb.select(frag)
    }
  }

  /// [InternalVariabler.ivsPlanedShowTimeConst]
  Future<int?> getPlanedShowTime({required NTypeNumber? nTypeNumber, required MemoryGroup mg, required Tuple2<Fragment, FragmentMemoryInfo?> tuple}) async {
    if (tuple.t2 == null) return null;
    return differenceFromStartTimeStamp(mg: mg, dateTime: tuple.t2!.planedShowTime);
  }

  /// [InternalVariabler.ivsShowFamiliarConst]
  Future<double?> getShowFamiliar({required NTypeNumber? nTypeNumber, required MemoryGroup mg, required MemoryModel mm}) async {}
}
