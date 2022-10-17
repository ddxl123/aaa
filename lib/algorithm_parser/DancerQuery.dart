part of algorithm_parser;

class DancerQuery {
  final DriftDb driftDb = DriftDb.instance;

  /// 相似：[GeneralQueryDAO.getLearnedFragmentsCount]
  Future<Tuple2<Fragment, List<FragmentMemoryInfo>>?> getOneLearnedFragment({required MemoryGroup mg}) async {
    final lSelect = driftDb.select(driftDb.fragments);
    final lJoin = [
      innerJoin(driftDb.fragmentMemoryInfos, driftDb.fragmentMemoryInfos.fragmentId.equalsExp(driftDb.fragments.id)),
    ];
    final lWhere = driftDb.fragmentMemoryInfos.memoryGroupId.equals(mg.id) &
        driftDb.fragmentMemoryInfos.isLatestRecord.equals(true) &
        driftDb.fragmentMemoryInfos.nextPlanedShowTime.isSmallerOrEqualValue(mg.reviewInterval);

    final doJoin = lSelect.join(lJoin);
    doJoin.where(lWhere);
    doJoin.orderBy([OrderingTerm.asc(driftDb.fragmentMemoryInfos.nextPlanedShowTime)]);
    doJoin.limit(1);

    final result = await doJoin.getSingleOrNull();
    if (result == null) return null;

    final recentInfo = result.readTable(driftDb.fragmentMemoryInfos);

    final nSelect = driftDb.select(driftDb.fragmentMemoryInfos);
    nSelect.where((tbl) => tbl.memoryGroupId.equals(recentInfo.memoryGroupId) & tbl.fragmentId.equals(recentInfo.fragmentId));
    nSelect.orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    final nResult = await nSelect.get();
    return Tuple2(t1: result.readTable(driftDb.fragments), t2: nResult);
  }

  /// 相似：[GeneralQueryDAO.getNewFragmentsCount]
  Future<Fragment?> getOneNewFragment({required MemoryGroup mg}) async {
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

  /// [Fragment] 表示当前新展示的碎片。
  ///
  /// [FragmentMemoryInfo]s 为当前记忆组当前碎片的全部记忆信息（不包含当前新展示的信息，因为当前新展示的信息未被创建）。
  /// 按照时间顺序排序。
  ///
  /// 若 [FragmentMemoryInfo]s 数组为空，则当前碎片是新碎片。
  ///
  /// 为 null 时表示没有下一个了，即已完成学习。
  Future<Tuple2<Fragment, List<FragmentMemoryInfo>>?> getNewDancer({required MemoryGroup mg}) async {
    final newFragment = await getOneNewFragment(mg: mg);
    final learnedFragment = await getOneLearnedFragment(mg: mg);

    if (newFragment == null && learnedFragment == null) return null;

    final newFragmentOrNull = newFragment == null ? null : Tuple2(t1: newFragment, t2: <FragmentMemoryInfo>[]);
    final learnedFragmentOrNull = learnedFragment == null ? null : Tuple2(t1: learnedFragment.t1, t2: learnedFragment.t2);

    return filter(
      from: mg.newReviewDisplayOrder,
      targets: {
        [NewReviewDisplayOrder.mix]: () => math.Random().nextInt(1) == 0 ? (newFragmentOrNull ?? learnedFragmentOrNull) : (learnedFragmentOrNull ?? newFragmentOrNull),
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

  /// [InternalVariableConstant.countAllConst]
  Future<List<int>> getCountAll({required MemoryGroup mg}) async {
    return [await DriftDb.instance.generalQueryDAO.getFragmentsCount(mg: mg)];
  }

  /// [InternalVariableConstant.countNewConst]
  Future<List<int>> getCountNew({required MemoryGroup mg}) async {
    return [await DriftDb.instance.generalQueryDAO.getNewFragmentsCount(mg: mg)];
  }

  /// [InternalVariableConstant.timesConst]
  Future<List<int>> getTimes({required Tuple2<Fragment, List<FragmentMemoryInfo>> tuple}) async {
    return tuple.t2.isEmpty ? [1] : [tuple.t2.length];
  }

  /// [InternalVariableConstant.currentActualShowTimeConst]
  Future<List<int>> getCurrentActualShowTime({required MemoryGroup mg, required Tuple2<Fragment, List<FragmentMemoryInfo>> tuple}) async {
    return tuple.t2.map<int>((e) => differenceFromStartTimeStamp(mg: mg, dateTime: e.currentActualShowTime)).toList()
      ..add(differenceFromStartTimeStamp(mg: mg, dateTime: DateTime.now()));
  }

  /// [InternalVariableConstant.nextPlanedShowTimeConst]
  ///
  /// 这里与其他的不同，实际上的 [FragmentMemoryInfos.nextPlanedShowTime] 是从上一次展示信息中获取的，
  /// 但是该函数将会获取本次原本计划展示时间，即上一次的 [nextPlanedShowTime] 来充当当前的原本计划展示时间。
  /// 也就是说，返回值的 first 必然为 null。
  Future<List<int?>> getCurrentPlanedShowTime({required MemoryGroup mg, required Tuple2<Fragment, List<FragmentMemoryInfo>> tuple}) async {
    return <int?>[null, ...tuple.t2.map((e) => differenceFromStartTimeStamp(mg: mg, dateTime: e.nextPlanedShowTime))];
  }

  /// [InternalVariableConstant.showFamiliarConst]
  Future<List<double?>> getShowFamiliar({
    required Tuple2<Fragment, List<FragmentMemoryInfo>> tuple,
    required double? currentShowFamiliar,
  }) async {
    return tuple.t2.map<double?>((e) => e.showFamiliarity).toList()..add(currentShowFamiliar);
  }

  Future<List<int?>> getClickTime({required MemoryGroup mg, required Tuple2<Fragment, List<FragmentMemoryInfo>> tuple, required bool isCreateNow}) async {
    return tuple.t2.map<int?>((e) => differenceFromStartTimeStamp(mg: mg, dateTime: e.clickTime)).toList()
      ..add(isCreateNow ? differenceFromStartTimeStamp(mg: mg, dateTime: DateTime.now()) : null);
  }

  Future<List<double?>> getClickValue({required Tuple2<Fragment, List<FragmentMemoryInfo>> tuple, required double? clickValue}) async {
    return tuple.t2.map<double?>((e) => e.clickValue).toList()..add(clickValue);
  }
}
