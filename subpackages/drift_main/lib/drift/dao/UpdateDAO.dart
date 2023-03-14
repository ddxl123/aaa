part of drift_db;

/// xxx.reset 专用。
typedef FutureFunction = Future<void> Function();

@DriftAccessor(
  tables: tableClasses,
)
class UpdateDAO extends DatabaseAccessor<DriftDb> with _$UpdateDAOMixin {
  UpdateDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<void> resetClientSyncInfo({
    required FutureFunction originalClientSyncInfoReset,
    required SyncTag syncTag,
  }) async {
    await RefClientSyncInfos(
      self: originalClientSyncInfoReset,
      order: 0,
    ).run();
  }

  /// 修改 [originalFragmentReset]。
  Future<void> resetFragment({
    required FutureFunction originalFragmentReset,
    required SyncTag syncTag,
  }) async {
    await RefFragments(
      self: originalFragmentReset,
      fragmentMemoryInfos: null,
      rFragment2FragmentGroups: null,
      child_fragments: null,
      memoryModels: null,
      userComments: null,
      userLikes: null,
      order: 0,
    ).run();
  }

  /// 修改 [FragmentGroup]。
  Future<void> resetFragmentGroup({
    required FutureFunction? originalFragmentGroupReset,
    required SyncTag syncTag,
  }) async {
    await RefFragmentGroups(
      self: originalFragmentGroupReset ?? () async {},
      rFragment2FragmentGroups: null,
      child_fragmentGroups: null,
      userComments: null,
      userLikes: null,
      order: 0,
    ).run();
  }

  /// 修改 [Fragment]，仅修改 [isSelected]
  Future<void> resetFragmentIsSelected({
    required Fragment originalFragment,
    required bool isSelected,
    required SyncTag syncTag,
  }) async {
    await RefFragments(
      self: () async {
        await originalFragment.reset(
          creator_user_id: toAbsent(),
          father_fragment_id: toAbsent(),
          fragment_template_id: toAbsent(),
          title: toAbsent(),
          content: toAbsent(),
          client_be_selected: isSelected.toValue(),
          note_id: toAbsent(),
          tags: toAbsent(),
          be_sep_publish: toAbsent(),
          syncTag: syncTag,
        );
      },
      fragmentMemoryInfos: null,
      rFragment2FragmentGroups: null,
      child_fragments: null,
      memoryModels: null,
      userComments: null,
      userLikes: null,
      order: 0,
    ).run();
  }

  /// 修改 [fragmentGroup] 自身的 [FragmentGroup.local_is_selected]，以及子组和子碎片。
  Future<void> resetFragmentGroupAndSubIsSelected({
    required FragmentGroup? fragmentGroup,
    required bool isSelected,
    required SyncTag syncTag,
  }) async {
    await RefFragmentGroups(
      self: () async {
        await fragmentGroup?.reset(
          creator_user_id: toAbsent(),
          father_fragment_groups_id: toAbsent(),
          client_be_selected: isSelected.toValue(),
          title: toAbsent(),
          be_private: toAbsent(),
          be_publish: toAbsent(),
          tags: toAbsent(),
          syncTag: syncTag,
        );
        final fs = await db.generalQueryDAO.querySubFragmentsInFragmentGroupById(targetFragmentGroupId: fragmentGroup?.id);
        final fgs = await db.generalQueryDAO.querySubFragmentGroupsInFragmentGroupById(targetFragmentGroupId: fragmentGroup?.id);
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
              syncTag: syncTag,
              tags: toAbsent(),
              be_sep_publish: toAbsent(),
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
              be_private: toAbsent(),
              be_publish: toAbsent(),
              tags: toAbsent(),
              syncTag: syncTag,
            );
          },
        );
      },
      rFragment2FragmentGroups: null,
      child_fragmentGroups: null,
      userComments: null,
      userLikes: null,
      order: 0,
    ).run();
  }

  /// 修改 [MemoryGroup]，仅进行修改后的存储，不影响 [FragmentMemoryInfo]。
  Future<void> resetMemoryGroupForOnlySave({
    required FutureFunction originalMemoryGroupReset,
    required SyncTag syncTag,
  }) async {
    await RefMemoryGroups(
      self: originalMemoryGroupReset,
      fragmentMemoryInfos: null,
      order: 0,
    ).run();
  }

  /// 修改 [MemoryGroup]。
  ///
  /// TODO: 是否要对 memoryGroups 进行修改
  Future<void> resetMemoryModel({
    required FutureFunction originalMemoryModelReset,
    required SyncTag syncTag,
  }) async {
    await RefMemoryModels(
      self: originalMemoryModelReset,
      memoryGroups: null,
      order: 0,
    ).run();
  }

  /// performer 完成后，对其记忆信息进行修改。
  ///
  /// 会将 [MemoryGroup.willNewLearnCount] 减去 1。
  Future<void> resetFragmentMemoryInfoForFinishPerform({
    required FutureFunction originalFragmentMemoryInfoReset,
    required MemoryGroup originalMemoryGroup,
    required bool isNew,
    required SyncTag syncTag,
  }) async {
    await RefFragmentMemoryInfos(
      self: originalFragmentMemoryInfoReset,
      memoryGroups: RefMemoryGroups(
        self: () async {
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
              syncTag: syncTag,
            );
          }
        },
        fragmentMemoryInfos: null,
        order: 1,
      ),
      order: 0,
    ).run();
  }

  Future<void> resetShorthand({
    required FutureFunction originalShorthandReset,
    required SyncTag syncTag,
  }) async {
    await RefShorthands(
      self: originalShorthandReset,
      order: 0,
    ).run();
  }
}
