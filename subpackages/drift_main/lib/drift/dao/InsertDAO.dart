part of drift_db;

/// TODO: 所有curd函数体都要包裹上事务。
@DriftAccessor(
  tables: tableClasses,
)
class InsertDAO extends DatabaseAccessor<DriftDb> with _$InsertDAOMixin {
  InsertDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<User> insertUser() async {
    final findUser = await select(users).getSingleOrNull();
    if (findUser != null) throw '已存在用户！';
    return await Crt.usersCompanion(
      age: 18,
      email: '1033839760@qq.com'.toValue(),
      password: 'password'.toValue(),
      username: 'username',
    ).insert(syncTag: null);
  }

  /// 向当前 [FragmentGroups] 表中插入一条数据, 返回新插入的 [FragmentGroup]。
  Future<FragmentGroup> insertFragmentGroupWithRef({
    required FragmentGroupsCompanion willEntity,
    required SyncTag? syncTag,
  }) async {
    late FragmentGroup returnFragmentGroup;
    await withRefs(
      syncTag: syncTag,
      ref: (syncTag) async => RefFragmentGroups(
        self: (table) async {
          returnFragmentGroup = await insertReturningWith(table, entity: willEntity, syncTag: syncTag);
        },
        child_fragmentGroups: null,
        rFragment2FragmentGroups: null,
      ),
    );
    return returnFragmentGroup;
  }

  /// 向当前 [Fragments] 表中插入一条数据, 返回新插入的 [Fragment]。
  Future<Fragment> insertFragmentWithRef({
    required FragmentsCompanion willFragment,
    required FragmentGroupsCompanion? willFragmentGroup,
    required SyncTag? syncTag,
  }) async {
    late Fragment newFragment;
    await withRefs(
      syncTag: syncTag,
      ref: (syncTag) async => RefFragments(
        self: (table) async {
          newFragment = await willFragment.insert(syncTag: syncTag);
        },
        rFragment2FragmentGroups: RefRFragment2FragmentGroups(
          self: (table) async {
            await Crt.rFragment2FragmentGroupsCompanion(
              creatorUserId: willFragment.creatorUserId.value,
              fragmentGroupId: willFragmentGroup?.id ?? null.toValue(),
              fragmentId: willFragment.id.value,
            ).insert(syncTag: syncTag);
          },
        ),
        child_fragments: null,
        fragmentMemoryInfos: null,
        memoryModels: null,
      ),
    );
    return newFragment;
  }

  /// 创建一个记忆组。
  Future<MemoryGroup> insertMemoryGroup({required MemoryGroupsCompanion newMemoryGroupsCompanion, required SyncTag? syncTag}) async {
    late final MemoryGroup newMg;
    await withRefs(
      syncTag: syncTag,
      ref: (st) async => RefMemoryGroups(
        self: (table) async {
          newMg = await newMemoryGroupsCompanion.insert(syncTag: st);
        },
        fragmentMemoryInfos: null,
      ),
    );
    return newMg;
  }

  /// 将已选的 [fragments] 添加到 [memoryGroup] 中，实际创建了 [FragmentMemoryInfo]s。
  Future<void> insertSelectedFragmentToMemoryGroup({
    required MemoryGroup memoryGroup,
    required bool isRemoveRepeat,
  }) async {
    await withRefs(
      syncTag: null,
      ref: (st) async {
        return RefFragmentMemoryInfos(
          self: (_) async {
            final user = await db.generalQueryDAO.queryUser();
            final fs = await db.generalQueryDAO.querySelectedFragments();
            await Future.forEach<Fragment>(
              fs,
              (e) async {
                final newFmInfo = Crt.fragmentMemoryInfosCompanion(
                  creatorUserId: user.id,
                  memoryGroupId: memoryGroup.id,
                  fragmentId: e.id,
                  clickTime: null.toValue(),
                  clickValue: null.toValue(),
                  currentActualShowTime: null.toValue(),
                  nextPlanShowTime: null.toValue(),
                  showFamiliarity: null.toValue(),
                );
                if (isRemoveRepeat) {
                  final isExist = await db.generalQueryDAO.queryIsExistFragmentInMemoryGroup(fragment: e, memoryGroup: memoryGroup);
                  if (!isExist) {
                    await newFmInfo.insert(syncTag: st);
                  }
                } else {
                  await newFmInfo.insert(syncTag: st);
                }
              },
            );
          },
          memoryGroups: RefMemoryGroups(
            self: (_) async {
              // 需要将 willNewLearnCount +1。
              await db.updateDAO.resetMemoryGroupForOnlySave(
                originalMemoryGroupReset: (SyncTag resetSyncTag) async {
                  return memoryGroup.reset(
                    creatorUserId: toAbsent(),
                    memoryModelId: toAbsent(),
                    newDisplayOrder: toAbsent(),
                    newReviewDisplayOrder: toAbsent(),
                    reviewInterval: toAbsent(),
                    startTime: toAbsent(),
                    title: toAbsent(),
                    willNewLearnCount: (memoryGroup.willNewLearnCount + 1).toValue(),
                    syncTag: resetSyncTag,
                  );
                },
                syncTag: st,
              );
            },
            fragmentMemoryInfos: null,
          ),
        );
      },
    );
  }

  /// 创建一个新的记忆模型。
  Future<MemoryModel> insertMemoryModel({required MemoryModelsCompanion memoryModelsCompanion, required SyncTag? syncTag}) async {
    late final MemoryModel newMemoryModel;
    await withRefs(
      syncTag: syncTag,
      ref: (st) async => RefMemoryModels(
        self: (table) async {
          newMemoryModel = await memoryModelsCompanion.insert(syncTag: st);
        },
        memoryGroups: null,
      ),
    );
    return newMemoryModel;
  }
}
