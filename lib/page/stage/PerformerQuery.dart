part of algorithm_parser;

class PerformerQuery {
  final DriftDb dft = DriftDb.instance;

  /// 获取新的舞者。
  ///
  /// [Fragment] 表示当前新展示的碎片。
  ///
  /// [FragmentMemoryInfo]s 为当前记忆组当前碎片的全部记忆信息（不包含当前新展示的信息，因为当前新展示的信息未被创建）。
  /// 按照时间顺序排序。
  ///
  /// 若 [FragmentMemoryInfo]s 数组为空，则当前碎片是新碎片。
  ///
  /// 为 null 时表示没有下一个了，即已完成学习。
  Future<Tuple2<Fragment, List<FragmentMemoryInfo>>?> getNewPerformer({required MemoryGroup mg}) async {
    final newFragment = await getOneNewFragment(mg: mg);
    final learnedFragment = await getOneLearnedFragment(mg: mg);
    if (newFragment == null && learnedFragment == null) return null;

    final newFragmentOrNull = newFragment == null ? null : Tuple2(t1: newFragment, t2: <FragmentMemoryInfo>[]);
    final learnedFragmentOrNull = learnedFragment == null ? null : Tuple2(t1: learnedFragment.t1, t2: learnedFragment.t2);

    return filter(
      from: mg.newReviewDisplayOrder,
      targets: {
        [NewReviewDisplayOrder.mix]: () => math.Random().nextInt(2) == 0 ? (newFragmentOrNull ?? learnedFragmentOrNull) : (learnedFragmentOrNull ?? newFragmentOrNull),
        [NewReviewDisplayOrder.newReview]: () => newFragmentOrNull ?? learnedFragmentOrNull,
        [NewReviewDisplayOrder.reviewNew]: () => learnedFragmentOrNull ?? newFragmentOrNull,
      },
      orElse: null,
    );
  }

  /// 相似：[GeneralQueryDAO.getLearnedFragmentsCount]
  ///
  /// 获取要复习的碎片。
  Future<Tuple2<Fragment, List<FragmentMemoryInfo>>?> getOneLearnedFragment({required MemoryGroup mg}) async {
    final lSelect = dft.select(dft.fragments);
    final lJoin = [
      innerJoin(dft.fragmentMemoryInfos, dft.fragmentMemoryInfos.fragmentId.equalsExp(dft.fragments.id)),
    ];

    // 获取每个碎片的最近的一次碎片记忆信息
    final lWhere = dft.fragmentMemoryInfos.memoryGroupId.equals(mg.id) &
        dft.fragmentMemoryInfos.isLatestRecord.equals(true) &
        dft.fragmentMemoryInfos.nextPlanedShowTime.isSmallerOrEqualValue(mg.reviewInterval);

    final doJoin = lSelect.join(lJoin);
    doJoin.where(lWhere);
    doJoin.orderBy([OrderingTerm.asc(dft.fragmentMemoryInfos.nextPlanedShowTime)]);
    doJoin.limit(1);

    // 获取碎片
    final fragmentsResult = await doJoin.getSingleOrNull();
    if (fragmentsResult == null) return null;

    // 获取碎片对应的碎片记忆信息。
    final fragmentMemoryInfosSelect = dft.select(dft.fragmentMemoryInfos);
    final recentInfo = fragmentsResult.readTable(dft.fragmentMemoryInfos);
    fragmentMemoryInfosSelect.where((tbl) => tbl.memoryGroupId.equals(recentInfo.memoryGroupId) & tbl.fragmentId.equals(recentInfo.fragmentId));
    fragmentMemoryInfosSelect.orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    final fragmentMemoryInfosResult = await fragmentMemoryInfosSelect.get();

    return Tuple2(t1: fragmentsResult.readTable(dft.fragments), t2: fragmentMemoryInfosResult);
  }

  /// 相似：[GeneralQueryDAO.getNewFragmentsCount]
  ///
  /// 获取新碎片。
  Future<Fragment?> getOneNewFragment({required MemoryGroup mg}) async {
    final lSelect = dft.select(dft.fragments);
    final lJoin = [
      innerJoin(dft.rFragment2MemoryGroups, dft.rFragment2MemoryGroups.sonId.equalsExp(dft.fragments.id)),
      leftOuterJoin(dft.fragmentMemoryInfos, dft.fragmentMemoryInfos.fragmentId.equalsExp(dft.fragments.id)),
    ];

    // 获取在当前记忆组内的没有创建过碎片记忆信息的碎片。（获取新碎片）
    final lWhere = dft.rFragment2MemoryGroups.fatherId.equals(mg.id) & dft.fragmentMemoryInfos.id.isNull();

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
    return result.readTable(dft.fragments);
  }

  /// ========================================================================================

  /// 结束当前表演，并开始下一个表演。
  ///
  /// [fragmentMemoryInfo] - 当前表演者的上一次碎片记忆信息([FragmentMemoryInfo.isLatestRecord] 为 true 的)。
  Future<void> finishAndStartNextPerform({
    required FragmentMemoryInfo fragmentMemoryInfo,
  }) async {
    await withRefs(
      syncTag: null,
      ref: (SyncTag syncTag) async {
        return RefFragmentMemoryInfos(
          self: ($FragmentMemoryInfosTable table) async {
            await fragmentMemoryInfo.reset(
              createdAt: toAbsent(),
              updatedAt: DateTime.now().toValue(),
              fragmentId: toAbsent(),
              memoryGroupId: toAbsent(),
              isLatestRecord: false.toValue(),
              nextPlanedShowTime: ,
              currentActualShowTime: currentActualShowTime,
              showFamiliarity: showFamiliarity,
              clickTime: clickTime,
              clickValue: clickValue,
              writeSyncTag: syncTag,
            );
          },
        );
      },
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
  Future<List<int>> getCurrentActualShowTime({
    required MemoryGroup mg,
    required Tuple2<Fragment, List<FragmentMemoryInfo>> tuple,
  }) async {
    return tuple.t2.map<int>((e) => differenceFromStartTimeStamp(mg: mg, dateTime: e.currentActualShowTime)).toList()
      ..add(differenceFromStartTimeStamp(mg: mg, dateTime: DateTime.now()));
  }

  /// [InternalVariableConstant.nextPlanedShowTimeConst]
  ///
  /// 这里与其他的不同，实际上的 [FragmentMemoryInfos.nextPlanedShowTime] 是从上一次展示信息中获取的，
  /// 但是该函数将会获取本次原本计划展示时间，即上一次的 [nextPlanedShowTime] 来充当当前的原本计划展示时间。
  /// 也就是说，返回值的 first 必然为 null。
  Future<List<int?>> getCurrentPlanedShowTime({
    required MemoryGroup mg,
    required Tuple2<Fragment, List<FragmentMemoryInfo>> tuple,
  }) async {
    return <int?>[null, ...tuple.t2.map((e) => differenceFromStartTimeStamp(mg: mg, dateTime: e.nextPlanedShowTime))];
  }

  /// [InternalVariableConstant.showFamiliarConst]
  Future<List<double?>> getShowFamiliar({
    required Tuple2<Fragment, List<FragmentMemoryInfo>> tuple,
    required double? currentShowFamiliar,
  }) async {
    return tuple.t2.map<double?>((e) => e.showFamiliarity).toList()..add(currentShowFamiliar);
  }

  Future<List<int?>> getClickTime({
    required MemoryGroup mg,
    required Tuple2<Fragment, List<FragmentMemoryInfo>> tuple,
    required bool isCreateNow,
  }) async {
    return tuple.t2.map<int?>((e) => differenceFromStartTimeStamp(mg: mg, dateTime: e.clickTime)).toList()
      ..add(isCreateNow ? differenceFromStartTimeStamp(mg: mg, dateTime: DateTime.now()) : null);
  }

  Future<List<double?>> getClickValue({
    required Tuple2<Fragment, List<FragmentMemoryInfo>> tuple,
    required double? clickValue,
  }) async {
    final f = tuple.t2.map<double?>((e) => e.clickValue).toList()..add(clickValue);
    return f;
  }
}
