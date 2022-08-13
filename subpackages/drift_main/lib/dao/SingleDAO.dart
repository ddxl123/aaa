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
  Future<List<Fragment>> queryFragmentsByFragmentGroupId(String? fragmentGroupId) async {
    final j = innerJoin(rFragment2FragmentGroups, rFragment2FragmentGroups.sonId.equalsExp(fragments.id));
    final w = fragmentGroupId == null ? rFragment2FragmentGroups.fatherId.isNull() : rFragment2FragmentGroups.fatherId.equals(fragmentGroupId);
    final List<TypedResult> result = await (select(fragments).join([j])..where(w)).get();
    print(result);
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

  /// 向当前 [FragmentGroups] 表中插入一条数据, 返回新插入的 [FragmentGroup]。
  Future<FragmentGroup> insertFragmentGroup(FragmentGroupsCompanion willEntity) async {
    return await transaction(
      () async {
        late FragmentGroup returnFragmentGroup;
        await withRefs(
          RefFragmentGroups(
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
  Future<Fragment> insertFragment(FragmentGroup? fatherEntity, FragmentsCompanion willEntity) async {
    return await transaction(
      () async {
        final st = await SyncTag.create();
        late Fragment newFragment;
        await withRefs(
          RefFragments(
            self: (table) async {
              newFragment = await insertReturningWith(table, entity: willEntity, syncTag: st);
            },
            rFragment2FragmentGroups: RefRFragment2FragmentGroups(
              self: (table) async {
                await insertReturningWith(
                  table,
                  entity: WithCrts.rFragment2FragmentGroupsCompanion(
                    fatherId: (fatherEntity?.id).value(),
                    sonId: newFragment.id.value(),
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
  Future<void> insertMemoryGroupWithOther(MemoryGroupsCompanion willMemoryGroup, List<Fragment> willFragments) async {
    return await transaction(
      () async {
        final syncTag = await SyncTag.create();
        late MemoryGroup newMemoryGroup;

        await withRefs(
          RefMemoryGroups(
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
                        sonId: element.id.value(),
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
          RefMemoryModels(
            self: (table) async {
              newMemoryModel = await insertReturningWith(table, entity: willEntry, syncTag: syncTag);
            },
            memoryGroups: null,
            fragmentPermanentMemoryInfos: null,
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

  Future<List<Fragment>> queryFragmentInMemoryGroup(String memoryGroupId) async {
    final j = select(fragments).join([innerJoin(rFragment2MemoryGroups, rFragment2MemoryGroups.sonId.equalsExp(fragments.id))]);
    j.where(rFragment2MemoryGroups.fatherId.equals(memoryGroupId));
    final gets = await j.get();
    return gets.map((e) => e.readTable(fragments)).toList();
  }

  Future<MemoryModel?> queryMemoryModelInsideMemoryGroup({required String? memoryModelId}) async {
    return await (select(memoryModels)..where((tbl) => tbl.id.equals(memoryModelId))).getSingleOrNull();
  }

  Future<void> updateMemoryModelInsideMemoryGroup() async {}
}
