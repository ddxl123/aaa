part of drift_db;

/// TODO: 所有curd函数体都要包裹上事务。
@DriftAccessor(
  tables: [
    ...cloudTableClass,
    ...rTableClass,
  ],
)
class SingleDAO extends DatabaseAccessor<DriftDb> with _$SingleDAOMixin {
  SingleDAO(DriftDb attachedDatabase) : super(attachedDatabase);

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

  /// [preCount] - 预加载数量。
  Future<Tuple2<Fragment, FragmentPermanentMemoryInfo?>?> queryFragmentsForDancer({required MemoryGroup mg}) async {
    // 查询记忆组内全部的碎片。
    Future<List<Fragment>> getFs() async => await queryFragmentsInMemoryGroup(mg.id);

    // 查询当前记忆组内的全部最新的记忆信息，及其对应的碎片。
    Future<List<TypedResult>> getAllLatestReviews() async =>
        await (select(fragmentPermanentMemoryInfos).join([innerJoin(fragments, fragmentPermanentMemoryInfos.fragmentId.equalsExp(fragments.id))])
              ..where(fragmentPermanentMemoryInfos.memoryGroupId.equals(mg.id) &
                  fragmentPermanentMemoryInfos.isLatestRecord.equals(true) &
                  fragmentPermanentMemoryInfos.planedNextShowTime.isSmallerOrEqualValue(mg.reviewInterval)))
            .get();

    // 在复习区间内将可展示的全部复习碎片信息，及其对应的碎片。
    // 基于 getAllLatestReviews，查询[下一次展示时间]小于等于[复习区间]，并早前晚后排序。
    Future<List<TypedResult>> getLatestReviewsIntervalAndSort() async => ((await getAllLatestReviews())
        .where((element) => element.readTable(fragmentPermanentMemoryInfos).planedNextShowTime.isBefore(mg.reviewInterval))
        .toList()
      ..sort(
        (a, b) =>
            a.readTable(fragmentPermanentMemoryInfos).planedNextShowTime.compareTo(b.readTable(fragmentPermanentMemoryInfos).planedNextShowTime),
      ));

    // 基于 getLatestReviewsIntervalAndSort 获取最早的复习碎片信息，及其对应的碎片。
    Future<TypedResult?> getLatestReview() async {
      final glrias = await getLatestReviewsIntervalAndSort();
      return glrias.isEmpty ? null : glrias.first;
    }

    // 基于 getAllLatestReviews 筛选出新碎片，即在当前碎片组中没有记录的碎片。
    Future<List<Fragment>> getNewFs() async {
      final galr = await getAllLatestReviews();
      return (await getFs()).where((element) => !galr.map((e) => e.readTable(fragmentPermanentMemoryInfos).fragmentId).contains(element.id)).toList();
    }

    // 基于 getNewFs，随机获取一个碎片。
    Future<Fragment?> getRandomF() async {
      final rfs = await getNewFs();
      return rfs.isEmpty ? null : rfs[Random().nextInt(rfs.length)];
    }

    return await filterFuture<NewReviewDisplayOrder, Tuple2<Fragment, FragmentPermanentMemoryInfo?>>(
      from: mg.newReviewDisplayOrder,
      targets: {
        [NewReviewDisplayOrder.mix]: () async => await filterFuture<NewDisplayOrder, Tuple2<Fragment, FragmentPermanentMemoryInfo?>>(
              from: mg.newDisplayOrder,
              targets: {
                [NewDisplayOrder.random]: () async => null,
                [NewDisplayOrder.createEarly2Late]: () async => null,
                [NewDisplayOrder.titleA2Z]: () async => null,
              },
              orElse: null,
            ),
        [NewReviewDisplayOrder.newReview]: () async => await filterFuture<NewDisplayOrder, Tuple2<Fragment, FragmentPermanentMemoryInfo?>>(
              from: mg.newDisplayOrder,
              targets: {
                [NewDisplayOrder.random]: () async => null,
                [NewDisplayOrder.createEarly2Late]: () async => null,
                [NewDisplayOrder.titleA2Z]: () async => null,
              },
              orElse: null,
            ),
        [NewReviewDisplayOrder.reviewNew]: () async => await filterFuture<NewDisplayOrder, Tuple2<Fragment, FragmentPermanentMemoryInfo?>>(
              from: mg.newDisplayOrder,
              targets: {
                [NewDisplayOrder.random]: () async => null,
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

  /// 向当前 [FragmentGroups] 表中插入一条数据, 返回新插入的 [FragmentGroup]。
  Future<FragmentGroup> insertFragmentGroup(FragmentGroupsCompanion willEntity) async {
    return await transaction(
      () async {
        late FragmentGroup returnFragmentGroup;
        await withRefs(
          () => RefFragmentGroups(
            self: (table) async {
              returnFragmentGroup = await insertReturningWith(table, entity: willEntity, syncTag: await SyncTag.create());
            },
            child_fragmentGroups: null,
            rFragment2FragmentGroups: null,
          ),
        );
        return returnFragmentGroup;
      },
    );
  }

  /// 向当前 [Fragments] 表中插入一条数据, 返回新插入的 [Fragment]。
  Future<Fragment> insertFragment({required FragmentsCompanion willFragment}) async {
    return await transaction(
      () async {
        final st = await SyncTag.create();
        late Fragment newFragment;
        await withRefs(
          () => RefFragments(
            self: (table) async {
              newFragment = await insertReturningWith(table, entity: willFragment, syncTag: st);
            },
            rFragment2FragmentGroups: RefRFragment2FragmentGroups(
              self: (table) async {
                await insertReturningWith(
                  table,
                  entity: WithCrts.rFragment2FragmentGroupsCompanion(
                    fatherId: willFragment.fatherFragmentId,
                    sonId: newFragment.id,
                    id: absent(),
                    createdAt: absent(),
                    updatedAt: absent(),
                  ),
                  syncTag: st,
                );
              },
            ),
            child_fragments: null,
            rFragment2MemoryGroups: null,
            fragmentPermanentMemoryInfos: null,
            rAssistedMemory2Fragments_1: null,
            rAssistedMemory2Fragments_2: null,
          ),
        );
        return newFragment;
      },
    );
  }

  /// 创建一个记忆
  Future<void> insertMemoryGroupWithOther({required MemoryGroupsCompanion willMemoryGroup, required List<Fragment> willFragments}) async {
    return await transaction(
      () async {
        final syncTag = await SyncTag.create();
        late MemoryGroup newMemoryGroup;

        await withRefs(
          () => RefMemoryGroups(
            self: (table) async {
              newMemoryGroup = await insertReturningWith(table, entity: willMemoryGroup, syncTag: syncTag);
            },
            rFragment2MemoryGroups: RefRFragment2MemoryGroups(
              self: (table) async {
                await Future.forEach<Fragment>(
                  willFragments,
                  (element) async {
                    await insertReturningWith(
                      table,
                      entity: WithCrts.rFragment2MemoryGroupsCompanion(
                        fatherId: newMemoryGroup.id.value(),
                        sonId: element.id,
                        id: absent(),
                        createdAt: absent(),
                        updatedAt: absent(),
                      ),
                      syncTag: syncTag,
                    );
                  },
                );
              },
            ),
            fragmentPermanentMemoryInfos: null,
          ),
        );
      },
    );
  }

  Future<List<MemoryGroup>> queryMemoryGroups() async {
    return await select(memoryGroups).get();
  }

  Future<MemoryModel> insertMemoryModel(MemoryModelsCompanion willEntry) async {
    return await transaction(
      () async {
        final syncTag = await SyncTag.create();
        late MemoryModel newMemoryModel;
        await withRefs(
          () => RefMemoryModels(
            self: (table) async {
              newMemoryModel = await insertReturningWith(table, entity: willEntry, syncTag: syncTag);
            },
            memoryGroups: null,
          ),
        );
        return newMemoryModel;
      },
    );
  }

  /// 未开始记忆前修改。
  Future<void> modifyMemoryGroup(MemoryGroup memoryGroup) async {
    // await transaction(
    //   () async {
    //     final st = await SyncTag.create();
    //     await WithRefs.memoryGroups(
    //       (table) async {
    //         await updateReturningWith(table, entity: memoryGroup, syncTag: st);
    //       },
    //       fragmentPermanentMemoryInfos: fragmentPermanentMemoryInfos,
    //       rFragment2MemoryGroups: rFragment2MemoryGroups,
    //       rMemoryModel2MemoryGroups: rMemoryModel2MemoryGroups,
    //     );
    //   },
    // );
  }

  Future<List<MemoryModel>> queryMemoryModels() async {
    return await select(memoryModels).get();
  }

  Future<List<Fragment>> queryFragmentsInMemoryGroup(String memoryGroupId) async {
    final j = select(fragments).join([innerJoin(rFragment2MemoryGroups, rFragment2MemoryGroups.sonId.equalsExp(fragments.id))]);
    j.where(rFragment2MemoryGroups.fatherId.equals(memoryGroupId));
    final gets = await j.get();
    return gets.map((e) => e.readTable(fragments)).toList();
  }

  Future<MemoryModel?> queryMemoryModelById({required String? memoryModelId}) async {
    return await (select(memoryModels)..where((tbl) => tbl.id.equals(memoryModelId))).getSingleOrNull();
  }

  Future<void> updateMemoryModelInsideMemoryGroup() async {}
}
