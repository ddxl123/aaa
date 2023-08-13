part of drift_db;

/// xxx.reset 专用。
typedef FutureFunction = Future<void> Function();

/// TODO: 所有 reset 不再使用这样的函数，而是直接使用 [RefXXX]，例如直接使用 [RefFragments]。
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
    required FutureFunction? originalFragmentReset,
    required FutureFunction? originalRFragment2FragmentGroupReset,
    required SyncTag syncTag,
  }) async {
    await RefFragments(
      self: originalFragmentReset ?? () async {},
      fragmentMemoryInfos: null,
      rFragment2FragmentGroups: RefRFragment2FragmentGroups(
        self: originalRFragment2FragmentGroupReset ?? () async {},
        order: 0,
      ),
      fragments_father_fragment_id: null,
      memoryModels: null,
      userComments: null,
      userLikes: null,
      order: 0,
    ).run();
  }

  /// 修改 [FragmentGroup]。
  Future<void> resetFragmentGroup({
    required FutureFunction originalFragmentGroupReset,
    required SyncTag syncTag,
  }) async {
    await RefFragmentGroups(
      self: originalFragmentGroupReset,
      fragmentGroupTags: null,
      rFragment2FragmentGroups: null,
      fragmentGroups_father_fragment_groups_id: null,
      fragmentGroups_jump_to_fragment_groups_id: null,
      userComments: null,
      userLikes: null,
      order: 0,
    ).run();
  }

  /// 修改 [Fragment]，仅修改 [isSelected]
  Future<void> resetFragmentIsSelected({
    required Fragment originalFragment,
    required RFragment2FragmentGroup originalRFragment2FragmentGroup,
    required bool isSelected,
    required SyncTag syncTag,
  }) async {
    await RefFragments(
      self: () async {
        await originalFragment.reset(
          creator_user_id: toAbsent(),
          father_fragment_id: toAbsent(),
          title: toAbsent(),
          content: toAbsent(),
          client_be_selected: isSelected.toValue(),
          be_sep_publish: toAbsent(),
          syncTag: syncTag,
          isCloudTableWithSync: false,
        );
      },
      fragmentMemoryInfos: null,
      rFragment2FragmentGroups: RefRFragment2FragmentGroups(
        self: () async {
          await originalRFragment2FragmentGroup.reset(
            client_be_selected: isSelected.toValue(),
            creator_user_id: toAbsent(),
            fragment_group_id: toAbsent(),
            fragment_id: toAbsent(),
            syncTag: syncTag,
            isCloudTableWithSync: false,
          );
        },
        order: 0,
      ),
      fragments_father_fragment_id: null,
      memoryModels: null,
      userComments: null,
      userLikes: null,
      order: 0,
    ).run();
  }

  /// 修改 [fragmentGroup] 自身的 [FragmentGroup.local_is_selected]，以及子孙组和子孙碎片。
  ///
  /// 传入的 [fragmentGroup] 可能是 jump 类型，内部会进行跳转。
  Future<void> resetFragmentGroupAndSubIsSelected({
    required FragmentGroup? fragmentGroup,
    required bool isSelected,
    required SyncTag syncTag,
  }) async {
    await RefFragmentGroups(
      self: () async {
        // 对自身组
        await fragmentGroup?.reset(
          creator_user_id: toAbsent(),
          father_fragment_groups_id: toAbsent(),
          jump_to_fragment_groups_id: toAbsent(),
          client_be_selected: isSelected.toValue(),
          title: toAbsent(),
          profile: toAbsent(),
          be_publish: toAbsent(),
          save_original_id: toAbsent(),
          syncTag: syncTag,
          isCloudTableWithSync: false,
        );
        // 不能让跳转的目标碎片组设为 true
        if (fragmentGroup?.jump_to_fragment_groups_id != null) {
          final t = await db.generalQueryDAO.queryJumpTargetFragmentGroup(jumpFragmentGroupId: fragmentGroup!.jump_to_fragment_groups_id!);
          await t?.reset(
            creator_user_id: toAbsent(),
            father_fragment_groups_id: toAbsent(),
            jump_to_fragment_groups_id: toAbsent(),
            client_be_selected: false.toValue(),
            title: toAbsent(),
            profile: toAbsent(),
            be_publish: toAbsent(),
            save_original_id: toAbsent(),
            syncTag: syncTag,
            isCloudTableWithSync: false,
          );
        }

        final fgs = await db.generalQueryDAO.querySubFragmentGroupsInFragmentGroupById(targetFragmentGroup: fragmentGroup);
        final fs = await db.generalQueryDAO.querySubFragmentsInFragmentGroupById(targetFragmentGroup: fragmentGroup);
        // 碎片组不会出现重复
        for (var v in fgs) {
          await v.reset(
            creator_user_id: toAbsent(),
            father_fragment_groups_id: toAbsent(),
            jump_to_fragment_groups_id: toAbsent(),
            client_be_selected: isSelected.toValue(),
            title: toAbsent(),
            profile: toAbsent(),
            be_publish: toAbsent(),
            save_original_id: toAbsent(),
            syncTag: syncTag,
            isCloudTableWithSync: false,
          );
        }
        for (var v in fs.values) {
          // 碎片可能会存在重复，但已经去重过，就算没去重也无碍，因为重复修改等于没有修改。
          await v.$1.reset(
            creator_user_id: toAbsent(),
            father_fragment_id: toAbsent(),
            title: toAbsent(),
            content: toAbsent(),
            client_be_selected: isSelected.toValue(),
            syncTag: syncTag,
            be_sep_publish: toAbsent(),
            isCloudTableWithSync: false,
          );
          // 可能会存在重复，但已经去重过，就算没去重也无碍，因为重复修改等于没有修改。
          for (var f2fg in v.$2) {
            await f2fg.reset(
              client_be_selected: isSelected.toValue(),
              creator_user_id: toAbsent(),
              fragment_group_id: toAbsent(),
              fragment_id: toAbsent(),
              syncTag: syncTag,
              isCloudTableWithSync: false,
            );
          }
        }
      },
      fragmentGroupTags: null,
      rFragment2FragmentGroups: null,
      fragmentGroups_father_fragment_groups_id: null,
      fragmentGroups_jump_to_fragment_groups_id: null,
      userComments: null,
      userLikes: null,
      order: 0,
    ).run();
  }

  Future<void> resetAllSelectedFragmentAndFragmentGroupToClear() async {
    final st = await SyncTag.create();
    await RefFragmentGroups(
      self: () async {
        final fgs = await db.generalQueryDAO.queryAllSelectedFragmentGroups();
        for (var element in fgs) {
          await element.reset(
            be_publish: toAbsent(),
            client_be_selected: false.toValue(),
            creator_user_id: toAbsent(),
            father_fragment_groups_id: toAbsent(),
            jump_to_fragment_groups_id: toAbsent(),
            profile: toAbsent(),
            save_original_id: toAbsent(),
            title: toAbsent(),
            syncTag: st,
            isCloudTableWithSync: false,
          );
        }
      },
      fragmentGroupTags: null,
      rFragment2FragmentGroups: RefRFragment2FragmentGroups(
        self: () async {
          final fs = await db.generalQueryDAO.queryAllSelectedFragments();
          // 不用担心重复，因为已经去重了。
          for (var element in fs.values) {
            await element.$1.reset(
              be_sep_publish: toAbsent(),
              client_be_selected: false.toValue(),
              content: toAbsent(),
              creator_user_id: toAbsent(),
              father_fragment_id: toAbsent(),
              title: toAbsent(),
              syncTag: st,
              isCloudTableWithSync: false,
            );
            // 不用担心重复，因为已经去重了。
            for (var f2fg in element.$2) {
              await f2fg.reset(
                client_be_selected: false.toValue(),
                creator_user_id: toAbsent(),
                fragment_group_id: toAbsent(),
                fragment_id: toAbsent(),
                syncTag: st,
                isCloudTableWithSync: false,
              );
            }
          }
        },
        order: 0,
      ),
      fragmentGroups_father_fragment_groups_id: null,
      fragmentGroups_jump_to_fragment_groups_id: null,
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
    required FragmentMemoryInfo fragmentMemoryInfo,
    required SyncTag syncTag,
  }) async {
    await RefFragmentMemoryInfos(
      self: originalFragmentMemoryInfoReset,
      memoryGroups: RefMemoryGroups(
        self: () async {
          if (fragmentMemoryInfo.study_status == StudyStatus.never) {
            // 需要 willNewLearnCount -1。
            await originalMemoryGroup.reset(
              creator_user_id: toAbsent(),
              memory_model_id: toAbsent(),
              new_display_order: toAbsent(),
              new_review_display_order: toAbsent(),
              review_display_order: toAbsent(),
              review_interval: toAbsent(),
              start_time: toAbsent(),
              title: toAbsent(),
              will_new_learn_count: (originalMemoryGroup.will_new_learn_count - 1).toValue(),
              syncTag: syncTag,
              isCloudTableWithSync: true,
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
