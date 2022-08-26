part of drift_db;

/// TODO: 所有curd函数体都要包裹上事务。
@DriftAccessor(
  tables: [
    ...cloudTableClass,
    ...rTableClass,
  ],
)
class InsertDAO extends DatabaseAccessor<DriftDb> with _$InsertDAOMixin {
  InsertDAO(DriftDb attachedDatabase) : super(attachedDatabase);

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
            fragmentMemoryInfos: null,
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
            fragmentMemoryInfos: null,
          ),
        );
      },
    );
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
}
