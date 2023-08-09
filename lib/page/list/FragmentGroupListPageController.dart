import 'dart:async';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';

class FragmentGroupListPageController extends GroupListWidgetController<FragmentGroup, Fragment> {
  final currentFragmentGroupTagsAb = <FragmentGroupTag>[].ab;

  @override
  Future<GroupsAndUnitEntities<FragmentGroup, Fragment>> findEntities(FragmentGroup? whichGroupEntity) async {
    // 若 whichGroupEntity 不为 null，则必然存在 whichGroupEntity。father_fragment_groups_id!。
    final fs = await db.generalQueryDAO.queryFragmentsInFragmentGroupById(targetFragmentGroupId: whichGroupEntity?.id);
    final fgs = await db.generalQueryDAO.queryFragmentGroupsInFragmentGroupById(targetFragmentGroupId: whichGroupEntity?.id);
    return GroupsAndUnitEntities(
      unitEntities: fs,
      groupEntities: fgs,
    );
  }

  @override
  Future<(int, int)> needRefreshCount(FragmentGroup? whichGroupEntity) async {
    final selectedCount = await DriftDb.instance.generalQueryDAO.querySubFragmentsCountInFragmentGroup(
      targetFragmentGroupId: whichGroupEntity?.id,
      queryFragmentWhereType: QueryFragmentWhereType.selected,
    );
    final allCount = await DriftDb.instance.generalQueryDAO.querySubFragmentsCountInFragmentGroup(
      targetFragmentGroupId: whichGroupEntity?.id,
      queryFragmentWhereType: QueryFragmentWhereType.all,
    );
    if (selectedCount != allCount) {
      final st = await SyncTag.create();
      await db.updateDAO.resetFragmentGroup(
        originalFragmentGroupReset: whichGroupEntity == null
            ? null
            : () async {
                await whichGroupEntity.reset(
                  client_be_selected: false.toValue(),
                  creator_user_id: toAbsent(),
                  father_fragment_groups_id: toAbsent(),
                  title: toAbsent(),
                  profile: toAbsent(),
                  syncTag: st,
                  be_private: toAbsent(),
                  be_publish: toAbsent(),
                  save_original_id: toAbsent(),
                  isCloudTableWithSync: false,
                );
              },
        syncTag: st,
      );
    }
    return (selectedCount, allCount);
  }

  Future<void> resetFragmentIsSelected({required Ab<Fragment> fragmentAb, required bool isSelected}) async {
    await db.updateDAO.resetFragmentIsSelected(
      originalFragment: fragmentAb(),
      isSelected: isSelected,
      syncTag: await SyncTag.create(),
    );
    fragmentAb.refreshForce();
    await refreshCount(whichGroup: getCurrentGroupAb());
  }

  Future<void> resetFragmentGroupAndSubIsSelected({required Ab<FragmentGroup?> fragmentGroupAb, required bool isSelected}) async {
    await db.updateDAO.resetFragmentGroupAndSubIsSelected(
      fragmentGroup: fragmentGroupAb(),
      isSelected: isSelected,
      syncTag: await SyncTag.create(),
    );
    fragmentGroupAb.refreshForce();
    await refreshCount(whichGroup: getCurrentGroupAb());
  }

  @override
  FutureOr<void> refreshExtra() async {
    if (getCurrentGroupAb()().entity() != null) {
      final tags = await db.generalQueryDAO.queryFragmentGroupTagsByFragmentGroupId(fragmentGroupId: getCurrentGroupAb()().entity()!.id);
      currentFragmentGroupTagsAb.refreshInevitable((obj) => obj
        ..clear()
        ..addAll(tags));
    }
  }

  /// 对当前页面全选
  Future<void> selectAll() async {
    await db.transaction(
      () async {
        final st = await SyncTag.create();

        for (var value in getCurrentGroupAb()().groups()) {
          await db.updateDAO.resetFragmentGroupAndSubIsSelected(
            fragmentGroup: value().entity()!,
            isSelected: true,
            syncTag: st,
          );
        }
        for (var value in getCurrentGroupAb()().units()) {
          await db.updateDAO.resetFragmentIsSelected(
            originalFragment: value().unitEntity(),
            isSelected: true,
            syncTag: st,
          );
        }
      },
    );
    await refreshCurrentGroup();
  }

  /// 对当前页面全不选
  Future<void> deselectAll() async {
    await db.transaction(
      () async {
        final st = await SyncTag.create();

        for (var value in getCurrentGroupAb()().groups()) {
          await db.updateDAO.resetFragmentGroupAndSubIsSelected(
            fragmentGroup: value().entity()!,
            isSelected: false,
            syncTag: st,
          );
        }
        for (var value in getCurrentGroupAb()().units()) {
          await db.updateDAO.resetFragmentIsSelected(
            originalFragment: value().unitEntity(),
            isSelected: false,
            syncTag: st,
          );
        }
      },
    );
    await refreshCurrentGroup();
  }

  /// 对当前页面反选
  Future<void> invertSelect() async {
    await db.transaction(
      () async {
        final st = await SyncTag.create();

        for (var value in getCurrentGroupAb()().groups()) {
          await db.updateDAO.resetFragmentGroupAndSubIsSelected(
            fragmentGroup: value().entity()!,
            isSelected: !value().entity()!.client_be_selected,
            syncTag: st,
          );
        }
        for (var value in getCurrentGroupAb()().units()) {
          await db.updateDAO.resetFragmentIsSelected(
            originalFragment: value().unitEntity(),
            isSelected: !value().unitEntity().client_be_selected,
            syncTag: st,
          );
        }
      },
    );
    await refreshCurrentGroup();
  }

  /// 清空全部已选
  Future<void> clearAllSelected() async {
    await db.updateDAO.resetAllSelectFragmentAndFragmentGroup();
    await refreshCurrentGroup();
  }

  /// 删除已选
  Future<void> deleteSelected() async {
    await db.deleteDAO.deleteSelected(userId: Aber.find<GlobalAbController>().loggedInUser()!.id);
  }

  /// [fg] 是否属于自己的。
  bool isSelfOfFragmentGroup({required FragmentGroup fg}) {
    if (fg.save_original_id != null) return false;
    if (SyncTag.parseToUserId(fg.id) != Aber.find<GlobalAbController>().loggedInUser()!.id) {
      return false;
    }
    return true;
  }

  @override
  FutureOr<void> refreshDone() {}
}
