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
              creatorUserId: toAbsent(),
              fatherFragmentGroupsId: toAbsent(),
              local_isSelected: isSelected.toValue(),
              title: toAbsent(),
              syncTag: st,
            );
          },
          rFragment2FragmentGroups: null,
          child_fragmentGroups: null,
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
              content: toAbsent(),
              creatorUserId: toAbsent(),
              fatherFragmentId: toAbsent(),
              local_isSelected: isSelected.toValue(),
              noteId: toAbsent(),
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
              creatorUserId: toAbsent(),
              fatherFragmentGroupsId: toAbsent(),
              local_isSelected: isSelected.toValue(),
              title: toAbsent(),
              syncTag: st,
            );
            final fs = await db.generalQueryDAO.querySubFragmentsInFragmentGroup(targetFragmentGroup: fragmentGroup);
            final fgs = await db.generalQueryDAO.querySubFragmentGroupsInFragmentGroup(targetFragmentGroup: fragmentGroup);
            await Future.forEach<Fragment>(
              fs,
              (element) async {
                await element.reset(
                  content: toAbsent(),
                  creatorUserId: toAbsent(),
                  fatherFragmentId: toAbsent(),
                  local_isSelected: isSelected.toValue(),
                  noteId: toAbsent(),
                  syncTag: st,
                );
              },
            );
            await Future.forEach<FragmentGroup>(
              fgs,
              (element) async {
                await element.reset(
                  creatorUserId: toAbsent(),
                  fatherFragmentGroupsId: toAbsent(),
                  local_isSelected: isSelected.toValue(),
                  title: toAbsent(),
                  syncTag: st,
                );
              },
            );
          },
          rFragment2FragmentGroups: null,
          child_fragmentGroups: null,
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
}
