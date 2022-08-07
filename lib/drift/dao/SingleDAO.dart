part of drift_db;

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

  /// 只查询了未同步的。
  Future<List<Fragment>> queryFragments(String? fatherFragmentGroupId) async {
    final j = innerJoin(rFragment2FragmentGroups, rFragment2FragmentGroups.sonId.equalsExp(fragments.id));
    final w =
        fatherFragmentGroupId == null ? rFragment2FragmentGroups.fatherId.isNull() : rFragment2FragmentGroups.fatherId.equals(fatherFragmentGroupId);
    final List<TypedResult> result = await (select(fragments).join([j])..where(w)).get();
    return result.map((e) => e.readTable(fragments)).toList();
  }

  /// 只查询了未同步的。
  Future<List<Fragment>> queryFragmentsByIds(List<String> ids) async {
    return await (select(fragments)..where((tbl) => tbl.id.isIn(ids))).get();
  }

  /// 输入的 [ids] 与返回的对象是同一个对象。
  Future<List<String>> queryFragmentsForAllSubgroup(String fragmentGroupId, List<String> ids) async {
    final fIds = (await queryFragments(fragmentGroupId)).map((e) => e.id);
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
        await WithRefs.fragmentGroups(
          (table) async {
            returnFragmentGroup = await insertReturningWith(table, entity: willEntity, syncTag: await SyncTag.create());
          },
          child_fragmentGroups: null,
          rFragment2FragmentGroups: null,
        );
        return returnFragmentGroup;
      },
    );
  }

  /// 向当前 [Fragments] 表中插入一条数据, 返回新插入的 [Fragment]。
  Future<Fragment> insertFragment(FragmentGroup? fatherEntity, FragmentsCompanion willEntity) async {
    return await transaction(
      () async {
        final st = await SyncTag.create();
        late Fragment newFragment;
        await WithRefs.fragments(
          (table) async {
            newFragment = await insertReturningWith(table, entity: willEntity, syncTag: st);
          },
          rFragment2FragmentGroups: (_) async => await WithRefs.rFragment2FragmentGroups(
            (table) async {
              await insertReturningWith(
                table,
                entity: RFragment2FragmentGroupsCompanion(
                  sonId: newFragment.id.toDriftValue(),
                  fatherId: (fatherEntity?.id).toDriftValue(),
                ),
                syncTag: st,
              );
            },
          ),
          child_fragments: null,
          rFragment2MemoryGroups: null,
          fragmentPermanentMemoryInfos: null,
          rAssistedMemoryFragment2Fragment_1: null,
          rAssistedMemoryFragment2Fragment_2: null,
        );
        return newFragment;
      },
    );
  }

  /// 插入一个带有 [willFragments] 和 [willMemoryModel] 的新的 [willMemoryGroup]。
  Future<void> insertMemoryGroupWithOther(MemoryGroupsCompanion willMemoryGroup, List<Fragment> willFragments, MemoryModel? willMemoryModel) async {
    return await transaction(
      () async {
        final syncTag = await SyncTag.create();
        late MemoryGroup newMemoryGroup;
        await WithRefs.memoryGroups(
          (table) async {
            newMemoryGroup = await insertReturningWith(table, entity: willMemoryGroup, syncTag: syncTag);
          },
          rFragment2MemoryGroups: (_) async => await WithRefs.rFragment2MemoryGroups(
            (table) async {
              await Future.forEach<Fragment>(
                willFragments,
                (element) async {
                  await insertReturningWith(
                    table,
                    entity: RFragment2MemoryGroupsCompanion(
                      sonId: element.id.toDriftValue(),
                      fatherId: newMemoryGroup.id.toDriftValue(),
                    ),
                    syncTag: syncTag,
                  );
                },
              );
            },
          ),
          rMemoryModel2MemoryGroups: (_) async => await WithRefs.rMemoryModel2MemoryGroups(
            (table) async {
              if (willMemoryModel != null) {
                await insertReturningWith(
                  table,
                  entity: RMemoryModel2MemoryGroupsCompanion(
                    sonId: willMemoryModel.id.toDriftValue(),
                    fatherId: newMemoryGroup.id.toDriftValue(),
                  ),
                  syncTag: syncTag,
                );
              }
            },
          ),
          fragmentPermanentMemoryInfos: null,
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
        await WithRefs.memoryModels(
          (table) async {
            newMemoryModel = await insertReturningWith(table, entity: willEntry, syncTag: syncTag);
          },
          rMemoryModel2MemoryGroups: null,
          fragmentPermanentMemoryInfos: null,
        );
        return newMemoryModel;
      },
    );
  }

  Future<List<MemoryModel>> queryMemoryRules() async {
    return await select(memoryModels).get();
  }

  Future<List<Fragment>> queryFragmentInMemoryGroup(String memoryGroupId) async {
    final j = select(fragments).join([innerJoin(rFragment2MemoryGroups, rFragment2MemoryGroups.sonId.equalsExp(fragments.id))]);
    j.where(rFragment2MemoryGroups.fatherId.equals(memoryGroupId));
    final gets = await j.get();
    return gets.map((e) => e.readTable(fragments)).toList();
  }

  Future<MemoryModel?> queryMemoryRuleInMemoryGroup(String memoryGroupId) async {
    final j = select(memoryModels).join([innerJoin(rMemoryModel2MemoryGroups, rMemoryModel2MemoryGroups.sonId.equalsExp(memoryModels.id))]);
    j.where(rMemoryModel2MemoryGroups.fatherId.equals(memoryGroupId));
    return (await j.getSingleOrNull())?.readTable(memoryModels);
  }
}
