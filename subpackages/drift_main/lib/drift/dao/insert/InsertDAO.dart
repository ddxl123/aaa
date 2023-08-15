part of drift_db;

@DriftAccessor(
  tables: tableClasses,
)
class InsertDAO extends DatabaseAccessor<DriftDb> with _$InsertDAOMixin {
  InsertDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<ClientSyncInfo> insertClientSyncInfo({
    required ClientSyncInfosCompanion newClientSyncInfoCompanion,
    required SyncTag syncTag,
  }) async {
    final find = await db.generalQueryDAO.queryClientSyncInfoOrNull();
    if (find != null) throw "本地已存在客户端同步信息！";
    return newClientSyncInfoCompanion.insert(
      syncTag: syncTag,
      isReplaceWhenIdSame: false,
    );
  }

  /// 向 [dynamicFragmentGroups] 每个元素，插入相同的 [willFragmentsCompanion]。
  ///
  /// 当 [dynamicFragmentGroups] 元素为 null 时，表示插入到 root 组内。
  Future<Fragment> insertFragmentAndR({
    required FragmentsCompanion willFragmentsCompanion,
    required List<FragmentGroup?> dynamicFragmentGroups,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    late Fragment newFragment;
    await RefFragments(
      self: () async {
        newFragment = await willFragmentsCompanion.insert(
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync,
          isCloudTableAutoId: true,
          isReplaceWhenIdSame: false,
        );
      },
      rFragment2FragmentGroups: RefRFragment2FragmentGroups(
        self: () async {
          for (var v in dynamicFragmentGroups) {
            await Crt.rFragment2FragmentGroupsCompanion(
              creator_user_id: newFragment.creator_user_id,
              fragment_group_id: (v?.id).toValue(),
              fragment_id: newFragment.id,
              client_be_selected: false,
            ).insert(
              syncTag: syncTag,
              isCloudTableWithSync: isCloudTableWithSync,
              isCloudTableAutoId: true,
              isReplaceWhenIdSame: false,
            );
          }
        },
        order: 1,
      ),
      fragments_father_fragment_id: null,
      fragmentMemoryInfos: null,
      memoryModels: null,
      userComments: null,
      userLikes: null,
      order: 0,
    ).run();
    return newFragment;
  }

  /// 创建一个记忆组。
  Future<MemoryGroup> insertMemoryGroup({
    required MemoryGroupsCompanion newMemoryGroupsCompanion,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    late final MemoryGroup newMg;
    await RefMemoryGroups(
      self: () async {
        newMg = await newMemoryGroupsCompanion.insert(
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync,
          isCloudTableAutoId: true,
          isReplaceWhenIdSame: false,
        );
      },
      fragmentMemoryInfos: null,
      order: 0,
    ).run();
    return newMg;
  }

  /// 将已选的 [fragments] 添加到 [memoryGroup] 中，实际创建了 [FragmentMemoryInfo]s。
  Future<void> insertSelectedFragmentToMemoryGroup({
    required MemoryGroup memoryGroup,
    required bool isRemoveRepeat,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await RefFragmentMemoryInfos(
      self: () async {
        // TODO: user 为 null 时的处理。
        final user = (await db.generalQueryDAO.queryUserOrNull())!;
        final fs = await db.generalQueryDAO.queryAllSelectedFragments();
        await Future.forEach<Fragment>(
          fs.values.map((e) => e.$1),
          (e) async {
            final newFmInfo = Crt.fragmentMemoryInfosCompanion(
              creator_user_id: user.id,
              memory_group_id: memoryGroup.id,
              fragment_id: e.id,
              click_time: "[]",
              click_value: "[]",
              actual_show_time: "[]",
              click_familiarity: "[]",
              next_plan_show_time: "[]",
              show_familiarity: "[]",
              button_values: "[]",
              content_value: "[]",
              study_status: StudyStatus.never,
            );
            if (isRemoveRepeat) {
              final isExist = await db.generalQueryDAO.queryIsExistFragmentInMemoryGroup(fragment: e, memoryGroup: memoryGroup);
              if (!isExist) {
                await newFmInfo.insert(
                  syncTag: syncTag,
                  isCloudTableWithSync: isCloudTableWithSync,
                  isCloudTableAutoId: true,
                  isReplaceWhenIdSame: false,
                );
              }
            } else {
              await newFmInfo.insert(
                syncTag: syncTag,
                isCloudTableWithSync: isCloudTableWithSync,
                isCloudTableAutoId: true,
                isReplaceWhenIdSame: false,
              );
            }
          },
        );
      },
      memoryGroups: RefMemoryGroups(
        self: () async {
          // 需要将 willNewLearnCount +1。
          await db.updateDAO.resetMemoryGroupForOnlySave(
            originalMemoryGroupReset: () async {
              await memoryGroup.reset(
                creator_user_id: toAbsent(),
                memory_model_id: toAbsent(),
                new_display_order: toAbsent(),
                new_review_display_order: toAbsent(),
                review_display_order: toAbsent(),
                review_interval: toAbsent(),
                start_time: toAbsent(),
                title: toAbsent(),
                will_new_learn_count: (memoryGroup.will_new_learn_count + 1).toValue(),
                syncTag: syncTag,
                isCloudTableWithSync: isCloudTableWithSync,
              );
            },
            syncTag: syncTag,
          );
        },
        fragmentMemoryInfos: null,
        order: 1,
      ),
      order: 0,
    ).run();
  }

  /// 创建一个新的记忆模型。
  Future<MemoryModel> insertMemoryModel({
    required MemoryModelsCompanion memoryModelsCompanion,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    late final MemoryModel newMemoryModel;
    await RefMemoryModels(
      self: () async {
        newMemoryModel = await memoryModelsCompanion.insert(
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync,
          isCloudTableAutoId: true,
          isReplaceWhenIdSame: false,
        );
      },
      memoryGroups: null,
      order: 0,
    ).run();
    return newMemoryModel;
  }

  /// 创建一个新的速记。
  Future<Shorthand> insertShorthand({
    required ShorthandsCompanion shorthandsCompanion,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    late final Shorthand newShorthand;
    await RefShorthands(
      self: () async {
        newShorthand = await shorthandsCompanion.insert(
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync,
          isCloudTableAutoId: true,
          isReplaceWhenIdSame: false,
        );
      },
      order: 0,
    ).run();
    return newShorthand;
  }

  /// 创建一个新的文章。
  Future<Shorthand> insertArticle({
    required ShorthandsCompanion shorthandsCompanion,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    late final Shorthand newShorthand;
    await RefShorthands(
      self: () async {
        newShorthand = await shorthandsCompanion.insert(
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync,
          isCloudTableAutoId: true,
          isReplaceWhenIdSame: false,
        );
      },
      order: 0,
    ).run();
    return newShorthand;
  }
}
