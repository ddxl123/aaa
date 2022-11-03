part of algorithm_parser;

class PerformerQuery {
  final DriftDb dft = DriftDb.instance;

  /// 获取新的表演者。
  ///
  /// [Fragment] 表示当前新展示的碎片。
  ///
  /// [FragmentMemoryInfo]s 为当前记忆组当前碎片的全部记忆信息（不包含当前新展示的信息，因为当前新展示的信息未被创建）。
  /// 按照时间顺序排序，last 为 [FragmentMemoryInfo.isLatestRecord] 为 true 的记录。
  ///
  /// 若 [FragmentMemoryInfo]s 数组为空，则当前碎片是新碎片。
  ///
  /// 为 null 时表示没有下一个了，即已完成学习。
  Future<Tuple2<Fragment, List<FragmentMemoryInfo>>?> getNewPerformer({required MemoryGroup mg}) async {
    final newFragment = await getOneNewFragment(mg: mg);
    final learnedFragment = await getOneLearnedFragment(mg: mg);
    logger.d('newFragment:$newFragment');

    logger.d('learnedFragment:$learnedFragment');
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

  /// 获取要复习的碎片。
  ///
  /// 相似：[GeneralQueryDAO.getLearnedFragmentsCount]
  Future<Tuple2<Fragment, List<FragmentMemoryInfo>>?> getOneLearnedFragment({required MemoryGroup mg}) async {
    final lSelect = dft.select(dft.fragments);
    final lJoin = [
      innerJoin(dft.fragmentMemoryInfos, dft.fragmentMemoryInfos.fragmentId.equalsExp(dft.fragments.id)),
    ];

    // 获取每个碎片的最近的一次碎片记忆信息
    final lWhere = dft.fragmentMemoryInfos.memoryGroupId.equals(mg.id) &
        dft.fragmentMemoryInfos.isLatestRecord.equals(true) &
        dft.fragmentMemoryInfos.nextPlanShowTime.isSmallerOrEqualValue(timeDifference(target: mg.reviewInterval, start: mg.startTime!));

    final doJoin = lSelect.join(lJoin);
    doJoin.where(lWhere);
    doJoin.orderBy([OrderingTerm.asc(dft.fragmentMemoryInfos.nextPlanShowTime)]);
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
    if (mg.willNewLearnCount < 0) {
      throw 'willNewLearnCount 不能小于 0！';
    }
    // 识别是否还需要学习新碎片。
    if (mg.willNewLearnCount == 0) {
      return null;
    }

    final lSelect = dft.select(dft.rFragment2MemoryGroups);
    final lJoin = [
      leftOuterJoin(
        dft.fragmentMemoryInfos,
        dft.fragmentMemoryInfos.fragmentId.equalsExp(dft.rFragment2MemoryGroups.sonId) & dft.fragmentMemoryInfos.memoryGroupId.equalsExp(dft.rFragment2MemoryGroups.fatherId),
      ),
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

    final fragmentSelect = dft.select(dft.fragments)..where((tbl) => tbl.id.equals(result.readTable(dft.rFragment2MemoryGroups).sonId));
    return await fragmentSelect.getSingle();
  }

  /// ========================================================================================

  /// 结束当前表演，并开始下一个表演。
  ///
  /// [lastFragmentMemoryInfo] - 点击按钮前的最近一个碎片信息，即当前 [FragmentMemoryInfo.isLatestRecord] 为 true 的碎片信息。
  ///
  /// [newFragmentMemoryInfo] - 点击按钮后产生的新碎片信息。
  ///
  /// [isOldIsNew] - 将产生碎片信息的碎片是否为 新碎片（非复习碎片），
  /// 若为新的，则需要将 [MemoryGroup.willNewLearnCount] 减去 1。
  Future<void> finishAndStartNextPerform({
    required FragmentMemoryInfo? lastFragmentMemoryInfo,
    required FragmentMemoryInfosCompanion newFragmentMemoryInfo,
    required Ab<MemoryGroup> memoryGroupAb,
    required bool isOldIsNew,
  }) async {
    await dft.transaction(
      () async {
        final st = await SyncTag.create();
        // 修改旧的
        if (lastFragmentMemoryInfo != null) {
          await withRefs(
            syncTag: st,
            ref: (SyncTag syncTag) async {
              return RefFragmentMemoryInfos(
                self: ($FragmentMemoryInfosTable table) async {
                  await lastFragmentMemoryInfo.reset(
                    fragmentId: toAbsent(),
                    memoryGroupId: toAbsent(),
                    isLatestRecord: false.toValue(),
                    nextPlanShowTime: toAbsent(),
                    currentActualShowTime: toAbsent(),
                    showFamiliarity: toAbsent(),
                    clickTime: toAbsent(),
                    clickValue: toAbsent(),
                    writeSyncTag: syncTag,
                  );
                },
              );
            },
          );
        }
        // 生成新的
        await withRefs(
          syncTag: st,
          ref: (SyncTag syncTag) async {
            return RefFragmentMemoryInfos(
              self: ($FragmentMemoryInfosTable table) async {
                await dft.insertReturningWith(
                  dft.fragmentMemoryInfos,
                  entity: newFragmentMemoryInfo,
                  syncTag: syncTag,
                );
              },
            );
          },
        );

        if (isOldIsNew) {
          await DriftDb.instance.updateDAO.resetMemoryGroup(
            syncTag: st,
            oldMemoryGroupReset: (SyncTag resetSyncTag) async {
              await memoryGroupAb().reset(
                memoryModelId: toAbsent(),
                title: toAbsent(),
                willNewLearnCount: (memoryGroupAb().willNewLearnCount - 1).toValue(),
                reviewInterval: toAbsent(),
                isEnableFilterOutAlgorithm: toAbsent(),
                filterOutAlgorithm: toAbsent(),
                newReviewDisplayOrder: toAbsent(),
                newDisplayOrder: toAbsent(),
                startTime: toAbsent(),
                isEnableFloatingAlgorithm: toAbsent(),
                floatingAlgorithm: toAbsent(),
                writeSyncTag: resetSyncTag,
              );
            },
          );
        }
      },
    );
  }

  /// ========================================================================================

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
    required int currentShowTime,
  }) async {
    return tuple.t2.map<int>((e) => e.currentActualShowTime).toList()..add(currentShowTime);
  }

  /// [InternalVariableConstant.nextPlanedShowTimeConst]
  ///
  /// 这里与其他的不同，实际上的 [FragmentMemoryInfos.nextPlanShowTime] 是从上一次展示信息中获取的，
  /// 但是该函数将会获取本次原本计划展示时间，即上一次的 [nextPlanShowTime] 来充当当前的原本计划展示时间。
  /// 也就是说，返回值的 first 必然为 null。
  Future<List<int?>> getCurrentPlanedShowTime({
    required MemoryGroup mg,
    required Tuple2<Fragment, List<FragmentMemoryInfo>> tuple,
  }) async {
    return <int?>[null, ...tuple.t2.map((e) => e.nextPlanShowTime)];
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
    return tuple.t2.map<int?>((e) => e.clickTime).toList()..add(isCreateNow ? timeDifference(target: DateTime.now(), start: mg.startTime!) : null);
  }

  Future<List<double?>> getClickValue({
    required Tuple2<Fragment, List<FragmentMemoryInfo>> tuple,
    required double? clickValue,
  }) async {
    final f = tuple.t2.map<double?>((e) => e.clickValue).toList()..add(clickValue);
    return f;
  }
}
