part of drift_db;

/// xxx.reset 专用。
typedef ResetFutureFunction<T> = Future<T> Function(SyncTag resetSyncTag);

/// TODO: 所有curd函数体都要包裹上事务, withRefs 内部自带事务。
///
///
@DriftAccessor(
  tables: tableClasses,
)
class UpdateDAO extends DatabaseAccessor<DriftDb> with _$UpdateDAOMixin {
  UpdateDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<void> resetClientSyncInfo({
    required ResetFutureFunction<ClientSyncInfo> originalClientSyncInfoReset,
    required SyncTag? syncTag,
  }) async {
    await withRefs(
      syncTag: syncTag,
      ref: (st) async {
        return RefClientSyncInfos(
          self: (_) async {
            await originalClientSyncInfoReset(st);
          },
        );
      },
    );
  }

  /// 修改 [originalFragmentReset]。
  Future<void> resetFragment({
    required ResetFutureFunction<Fragment> originalFragmentReset,
    required SyncTag? syncTag,
  }) async {
    await withRefs(
      syncTag: syncTag,
      ref: (st) async {
        return RefFragments(
          self: (_) async {
            await originalFragmentReset(st);
          },
          fragmentMemoryInfos: null,
          rFragment2FragmentGroups: null,
          child_fragments: null,
          memoryModels: null,
        );
      },
    );
  }

  /// 修改 [FragmentGroup]，仅修改 [isSelected]
  Future<void> resetFragmentGroupIsSelected({
    required FragmentGroup? originalFragmentGroup,
    required bool isSelected,
    required SyncTag? syncTag,
  }) async {
    await withRefs(
      syncTag: syncTag,
      ref: (SyncTag st) async {
        return RefFragmentGroups(
          self: ($FragmentGroupsTable table) async {
            await originalFragmentGroup?.reset(
              creator_user_id: toAbsent(),
              father_fragment_groups_id: toAbsent(),
              client_be_selected: isSelected.toValue(),
              title: toAbsent(),
              syncTag: st,
            );
          },
          rFragment2FragmentGroups: null,
          child_fragmentGroups: null,
          fragmentGroupConfigs: null,
        );
      },
    );
  }

  /// 修改 [Fragment]，仅修改 [isSelected]
  Future<void> resetFragmentIsSelected({
    required Fragment originalFragment,
    required bool isSelected,
    required SyncTag? syncTag,
  }) async {
    await withRefs(
      syncTag: syncTag,
      ref: (SyncTag st) async {
        return RefFragments(
          self: (_) async {
            await originalFragment.reset(
              creator_user_id: toAbsent(),
              father_fragment_id: toAbsent(),
              fragment_template_id: toAbsent(),
              title: toAbsent(),
              content: toAbsent(),
              client_be_selected: isSelected.toValue(),
              note_id: toAbsent(),
              syncTag: st,
            );
          },
          fragmentMemoryInfos: null,
          rFragment2FragmentGroups: null,
          child_fragments: null,
          memoryModels: null,
        );
      },
    );
  }

  /// 修改 [fragmentGroup] 自身的 [FragmentGroup.local_is_selected]，以及子组和子碎片。
  Future<void> resetFragmentGroupAndSubIsSelected({required FragmentGroup? fragmentGroup, required bool isSelected}) async {
    await withRefs(
      syncTag: null,
      ref: (st) async {
        return RefFragmentGroups(
          self: (table) async {
            await fragmentGroup?.reset(
              creator_user_id: toAbsent(),
              father_fragment_groups_id: toAbsent(),
              client_be_selected: isSelected.toValue(),
              title: toAbsent(),
              syncTag: st,
            );
            final fs = await db.generalQueryDAO.querySubFragmentsInFragmentGroup(targetFragmentGroup: fragmentGroup);
            final fgs = await db.generalQueryDAO.querySubFragmentGroupsInFragmentGroup(targetFragmentGroup: fragmentGroup);
            await Future.forEach<Fragment>(
              fs,
              (element) async {
                await element.reset(
                  creator_user_id: toAbsent(),
                  father_fragment_id: toAbsent(),
                  fragment_template_id: toAbsent(),
                  title: toAbsent(),
                  content: toAbsent(),
                  client_be_selected: isSelected.toValue(),
                  note_id: toAbsent(),
                  syncTag: st,
                );
              },
            );
            await Future.forEach<FragmentGroup>(
              fgs,
              (element) async {
                await element.reset(
                  creator_user_id: toAbsent(),
                  father_fragment_groups_id: toAbsent(),
                  client_be_selected: isSelected.toValue(),
                  title: toAbsent(),
                  syncTag: st,
                );
              },
            );
          },
          rFragment2FragmentGroups: null,
          child_fragmentGroups: null,
          fragmentGroupConfigs: null,
        );
      },
    );
  }

  /// 修改 [MemoryGroup]，仅进行修改后的存储，不影响 [FragmentMemoryInfo]。
  Future<void> resetMemoryGroupForOnlySave({
    required ResetFutureFunction<MemoryGroup> originalMemoryGroupReset,
    required SyncTag? syncTag,
  }) async {
    await withRefs(
      syncTag: syncTag,
      ref: (syncTag) async {
        return RefMemoryGroups(
          self: (table) async {
            await originalMemoryGroupReset(syncTag);
          },
          fragmentMemoryInfos: null,
        );
      },
    );
  }

  /// 修改 [MemoryGroup]，仅进行修改后的存储，不影响 [FragmentMemoryInfo]。
  Future<void> resetMemoryModelOnlySave({
    required ResetFutureFunction<MemoryModel> originalMemoryModelReset,
    required SyncTag? syncTag,
  }) async {
    await withRefs(
      syncTag: syncTag,
      ref: (st) async {
        return RefMemoryModels(
          self: ($MemoryModelsTable table) async {
            await originalMemoryModelReset(st);
          },
          memoryGroups: null,
        );
      },
    );
  }

  /// performer 完成后，对其记忆信息进行修改。
  ///
  /// 会将 [MemoryGroup.willNewLearnCount] 减去 1。
  Future<void> resetFragmentMemoryInfoForFinishPerform({
    required ResetFutureFunction<FragmentMemoryInfo> originalFragmentMemoryInfoReset,
    required MemoryGroup originalMemoryGroup,
    required bool isNew,
    required SyncTag? syncTag,
  }) async {
    await withRefs(
      syncTag: syncTag,
      ref: (st) async {
        return RefFragmentMemoryInfos(
          self: (_) async {
            await originalFragmentMemoryInfoReset(st);
          },
          memoryGroups: RefMemoryGroups(
            self: (_) async {
              if (isNew) {
                // 需要 willNewLearnCount -1。
                await originalMemoryGroup.reset(
                  creator_user_id: toAbsent(),
                  memory_model_id: toAbsent(),
                  new_display_order: toAbsent(),
                  new_review_display_order: toAbsent(),
                  review_interval: toAbsent(),
                  start_time: toAbsent(),
                  title: toAbsent(),
                  will_new_learn_count: (originalMemoryGroup.will_new_learn_count - 1).toValue(),
                  syncTag: st,
                );
              }
            },
            fragmentMemoryInfos: null,
          ),
        );
      },
    );
  }
}
