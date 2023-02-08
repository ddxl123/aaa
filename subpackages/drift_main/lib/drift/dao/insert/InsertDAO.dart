part of drift_db;

@DriftAccessor(
  tables: tableClasses,
)
class InsertDAO extends DatabaseAccessor<DriftDb> with _$InsertDAOMixin {
  InsertDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<ClientSyncInfo> insertClientSyncInfo({required ClientSyncInfosCompanion newClientSyncInfoCompanion}) async {
    final find = await db.generalQueryDAO.queryClientSyncInfoOrNull();
    if (find != null) throw "本地已存在客户端同步信息！";
    return newClientSyncInfoCompanion.insert(syncTag: null);
  }

  /// 插入一个碎片组，会同时插入碎片组配置。
  Future<FragmentGroupWithExtra> insertFragmentGroup({
    required FragmentGroupsCompanion willFragmentGroupsCompanion,
    required SyncTag? syncTag,
  }) async {
    late FragmentGroup returnFragmentGroup;
    await withRefs(
      syncTag: syncTag,
      ref: (st) async => RefFragmentGroups(
        self: (table) async {
          returnFragmentGroup = await willFragmentGroupsCompanion.insert(syncTag: st);
        },
        child_fragmentGroups: null,
        rFragment2FragmentGroups: null,
        userComments: null,
        userLikes: null,
      ),
    );
    return FragmentGroupWithExtra(fragmentGroup: returnFragmentGroup);
  }

  /// 向多个 [whichFragmentGroups] 中，插入相同的 [willFragmentsCompanion]。
  ///
  /// 当元素为 null 时，表示插入到 root 组内。
  ///
  /// [whichFragmentGroups] 为空数组时，会抛出异常。
  Future<Fragment> insertFragment({
    required FragmentsCompanion willFragmentsCompanion,
    required List<FragmentGroup?> whichFragmentGroups,
    required SyncTag? syncTag,
  }) async {
    if (whichFragmentGroups.isEmpty) {
      throw '要插入的碎片组不能为空！';
    }
    late Fragment newFragment;
    await withRefs(
      syncTag: syncTag,
      ref: (syncTag) async => RefFragments(
        self: (table) async {
          newFragment = await willFragmentsCompanion.insert(syncTag: syncTag);
        },
        rFragment2FragmentGroups: RefRFragment2FragmentGroups(
          self: (table) async {
            await Future.forEach<FragmentGroup?>(
              whichFragmentGroups,
              (whichFragmentGroup) async {
                await Crt.rFragment2FragmentGroupsCompanion(
                  creator_user_id: willFragmentsCompanion.creator_user_id.value,
                  fragment_group_id: (whichFragmentGroup?.id).toValue(),
                  fragment_id: willFragmentsCompanion.id.value,
                ).insert(syncTag: syncTag);
              },
            );
          },
        ),
        child_fragments: null,
        fragmentMemoryInfos: null,
        memoryModels: null,
        userComments: null,
        userLikes: null,
      ),
    );
    return newFragment;
  }

  /// 创建一个记忆组。
  Future<MemoryGroup> insertMemoryGroup({required MemoryGroupsCompanion newMemoryGroupsCompanion, required SyncTag? syncTag}) async {
    late final MemoryGroup newMg;
    await withRefs(
      syncTag: syncTag,
      ref: (st) async {
        return RefMemoryGroups(
          self: (table) async {
            newMg = await newMemoryGroupsCompanion.insert(syncTag: st);
          },
          fragmentMemoryInfos: null,
        );
      },
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
            // TODO: user 为 null 时的处理。
            final user = (await db.generalQueryDAO.queryUserOrNull())!;
            final fs = await db.generalQueryDAO.querySelectedFragments();
            await Future.forEach<Fragment>(
              fs,
              (e) async {
                final newFmInfo = Crt.fragmentMemoryInfosCompanion(
                  creator_user_id: user.id,
                  memory_group_id: memoryGroup.id,
                  fragment_id: e.id,
                  click_time: null.toValue(),
                  click_value: null.toValue(),
                  current_actual_show_time: null.toValue(),
                  next_plan_show_time: null.toValue(),
                  show_familiarity: null.toValue(),
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
                  return await memoryGroup.reset(
                    creator_user_id: toAbsent(),
                    memory_model_id: toAbsent(),
                    new_display_order: toAbsent(),
                    new_review_display_order: toAbsent(),
                    review_interval: toAbsent(),
                    start_time: toAbsent(),
                    title: toAbsent(),
                    will_new_learn_count: (memoryGroup.will_new_learn_count + 1).toValue(),
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
