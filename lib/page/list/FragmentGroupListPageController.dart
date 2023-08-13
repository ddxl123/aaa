import 'dart:async';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../edit/FragmentGroupGizmoEditPage.dart';

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
        originalFragmentGroupReset: () async {
          if (whichGroupEntity != null) {
            await whichGroupEntity.reset(
              client_be_selected: false.toValue(),
              creator_user_id: toAbsent(),
              father_fragment_groups_id: toAbsent(),
              jump_to_fragment_groups_id: toAbsent(),
              title: toAbsent(),
              profile: toAbsent(),
              syncTag: st,
              be_publish: toAbsent(),
              save_original_id: toAbsent(),
              isCloudTableWithSync: false,
            );
          }
        },
        syncTag: st,
      );
    }
    return (selectedCount, allCount);
  }

  Future<void> resetFragmentIsSelected({
    required Ab<Fragment> fragmentAb,
    required bool isSelected,
  }) async {
    final rF2Fg = await db.generalQueryDAO.queryRFragment2FragmentGroupsBy(
      fragment: fragmentAb(),
      fragmentGroup: getCurrentGroupAb()().entity(),
    );

    await db.updateDAO.resetFragmentIsSelected(
      originalFragment: fragmentAb(),
      originalRFragment2FragmentGroup: rF2Fg,
      isSelected: isSelected,
      syncTag: await SyncTag.create(),
    );
    fragmentAb.refreshForce();
    await refreshCount(whichGroup: getCurrentGroupAb());
  }

  Future<void> resetFragmentGroupAndSubIsSelected({
    required Ab<FragmentGroup?> fragmentGroupAb,
    required bool isSelected,
  }) async {
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
      final tags = await db.generalQueryDAO.queryFragmentGroupTagsByFragmentGroupId(
        fragmentGroupId: getCurrentGroupAb()().entity()!.id,
      );
      currentFragmentGroupTagsAb.refreshInevitable((obj) => obj
        ..clear()
        ..addAll(tags));
    }
  }

  /// 对当前页面全选
  /// TODO: 处理对 jump 随着进行选择的问题
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
          final rF2Fg = await db.generalQueryDAO.queryRFragment2FragmentGroupsBy(
            fragment: value().unitEntity(),
            fragmentGroup: getCurrentGroupAb()().entity(),
          );
          await db.updateDAO.resetFragmentIsSelected(
            originalRFragment2FragmentGroup: rF2Fg,
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
          final rF2Fg = await db.generalQueryDAO.queryRFragment2FragmentGroupsBy(
            fragment: value().unitEntity(),
            fragmentGroup: getCurrentGroupAb()().entity(),
          );
          await db.updateDAO.resetFragmentIsSelected(
            originalRFragment2FragmentGroup: rF2Fg,
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
          final rF2Fg = await db.generalQueryDAO.queryRFragment2FragmentGroupsBy(
            fragment: value().unitEntity(),
            fragmentGroup: getCurrentGroupAb()().entity(),
          );
          await db.updateDAO.resetFragmentIsSelected(
            originalRFragment2FragmentGroup: rF2Fg,
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
    await db.updateDAO.resetAllSelectFragmentAndFragmentGroupToClear();
    await refreshCurrentGroup();
  }

  /// TODO：检测是否有碎片或碎片组处于已发布的碎片组内，若是，则不建议移动，而是使用复用，复用更适用于嵌套组合成一个新的碎片组。
  /// TODO：移动：将碎片或碎片组移动到其他碎片组内。
  /// TODO：    - 创建者对其移动操作，会同步到云端，并通知已下载的用户进行更新。
  /// TODO：    - 下载者更新或重新下载碎片组后，移动的会被复原。
  /// TODO：    - 在多个相同的碎片组内，都存在相同的碎片的时候，移动其中一个，其他的会被同时移动，因为者多个本身就是同一个碎片组，并且相同的碎片本身就是同一个碎片。
  /// TODO：    - 所有人对任意碎片、任意碎片组都有权限进行移动。
  /// TODO：复用：将相同的碎片存放至不同的碎片组中。
  /// TODO：    - 更新或重新下载碎片组后，不会导致移动的被复原，而是会在原来的地方重新出现一份。
  /// TODO：    - 所有人对任意碎片、任意碎片组都有权限进行复用。
  /// TODO：
  /// TODO：如果创建者删除了碎片，无论是移动还是复用，都会同时被删除。
  /// TODO：
  /// TODO：删除：将碎片或碎片组进行删除。
  /// TODO：    - 更新或重新下载碎片组后，删除的会被复原，
  /// TODO：
  /// TODO：克隆：复制一份完全一样的碎片，但本质上与原碎片是不同的碎片，克隆的碎片和原碎片不会相互影响，可以对克隆的碎片进行任意的修改。
  /// TODO：    - 默认仅对创作者开发权限，创作者可以开放权限让任何人都能进行克隆。

  /// TODO：对已选碎片数量、递归查询等重写。

  /// 移动已选
  ///
  /// 当碎片组是 jump 类型，则移动的是 jump，不会对源碎片组进行移动。
  Future<void> moveSelected() async {
    final currentFragmentGroupChain = getCurrentFragmentGroupChain();
    final currentFragmentGroup = getCurrentGroupAb()().entity();
    final fgs = await db.generalQueryDAO.queryAllSelectedFragmentGroups();
    final fs = await db.generalQueryDAO.queryAllSelectedFragments();
    final isExist = currentFragmentGroupChain.any((chain) => fgs.any((fg) => chain.id == fg.id));
    if (isExist) {
      SmartDialog.showToast("不能将自身移动到自身上面！");
      return;
    }
    await showCustomDialog(
      builder: (ctx) => OkAndCancelDialogWidget(
        title: "是否将已选的移动到当前页面碎片组内？",
        okText: "移动",
        cancelText: "返回",
        onOk: () async {
          final st = await SyncTag.create();
          final user = Aber.find<GlobalAbController>().loggedInUser()!;
          for (var v in fgs) {
            // 当 v 的 father 未被选择时（而非 v 的祖父），如果 father 被选择，则会将 father 整组进行移动。
            // 不用担心同一页面出现相同碎片的问题，因为同一页面不会出现相同 id 的碎片组，重复的碎片组已经用 jump 方式跳转了，不会出现相同碎片组 id 的情况。
            if (!fgs.any((element) => element.id == v.father_fragment_groups_id)) {
              await db.updateDAO.resetFragmentGroup(
                syncTag: st,
                originalFragmentGroupReset: () async {
                  await v.reset(
                    be_publish: toAbsent(),
                    client_be_selected: toAbsent(),
                    creator_user_id: toAbsent(),
                    // 因为进入 jump 碎片组时，当前页面处于 jump 的原碎片组内，因此 currentFragmentGroup 就是原碎片组，并无需将 father 设为 jump。
                    father_fragment_groups_id: (currentFragmentGroup?.id).toValue(),
                    jump_to_fragment_groups_id: toAbsent(),
                    profile: toAbsent(),
                    save_original_id: toAbsent(),
                    title: toAbsent(),
                    syncTag: st,
                    isCloudTableWithSync: SyncTag.parseToUserId(v.id) == user.id,
                  );
                },
              );
            }
          }
          for (var v in fs.$2) {
            // 当 v 所在的组未被选择时（而非 v 的祖父），如果 father 被选择，则会将 father 整组进行移动。
            // 因为 jump 的设定，碎片组始终是唯一的，因此 rFragment2FragmentGroup 的 fragmentGroupId 也是唯一的。
            if (!fgs.any((element) => element.id == v.fragment_group_id)) {
              await db.updateDAO.resetFragment(
                originalFragmentReset: null,
                originalRFragment2FragmentGroupReset: () async {
                  await v.reset(
                    client_be_selected: toAbsent(),
                    creator_user_id: toAbsent(),
                    fragment_group_id: (currentFragmentGroup?.id).toValue(),
                    fragment_id: toAbsent(),
                    syncTag: st,
                    isCloudTableWithSync: SyncTag.parseToUserId(v.id) == user.id,
                  );
                },
                syncTag: st,
              );
            }
          }
          await refreshCurrentGroup();
          SmartDialog.dismiss(status: SmartStatus.dialog);
        },
      ),
    );
  }

  /// 复用已选
  Future<void> reuseSelected() async {
    await showCustomDialog(
      builder: (ctx) {
        return OkAndCancelDialogWidget(
          title: "是否将已选碎片复用到当前页面碎片组内？",
          text: "复用：与克隆不同，复用是将相同的碎片存放至不同的碎片组中。\n注意：当碎片制作者删除了碎片，复用的碎片在进行更新或重新下载后会同时被删除。",
          okText: "复用",
          cancelText: "返回",
          onOk: () async {
            final currentFragmentGroup = getCurrentGroupAb()().entity();
            final currentGroupAllFragment = getCurrentGroupAb()().units().map((e) => e().unitEntity());
            final fs = await db.generalQueryDAO.queryAllSelectedFragments();
            final user = Aber.find<GlobalAbController>().loggedInUser()!;
            final st = await SyncTag.create();

            for (var v in fs.$1) {
              if (!currentGroupAllFragment.any((element) => element.id == v.id)) {
                await RefRFragment2FragmentGroups(
                  self: () async {
                    await Crt.rFragment2FragmentGroupsCompanion(
                      client_be_selected: false,
                      creator_user_id: user.id,
                      fragment_group_id: (currentFragmentGroup?.id).toValue(),
                      fragment_id: v.id,
                    ).insert(
                      syncTag: st,
                      isCloudTableWithSync: true,
                      // 每个复用碎片都会产生新的 id，因此每个页面可以重复出现相同碎片。
                      // TODO: 不过会出现一个问题，当原碎片被删除时，其 [RFragment2FragmentGroup] 会找不到对应的 fragment。
                      isCloudTableAutoId: true,
                      isReplaceWhenIdSame: false,
                    );
                  },
                  order: 0,
                ).run();
              }
            }
            await refreshCurrentGroup();
            SmartDialog.dismiss(status: SmartStatus.dialog);
          },
        );
      },
    );
  }

  /// 删除已选
  Future<void> deleteSelected() async {
    await showCustomDialog(
      builder: (ctx) {
        return OkAndCancelDialogWidget(
          title: "删除后将不可恢复，确定要删除？",
          text: "若删除的碎片或碎片组被其他用户下载过，那么在用户更新或重新下载时，将会丢失其删除的碎片。",
          okText: "删除",
          cancelText: "返回",
          onOk: () async {
            await db.deleteDAO.deleteSelected(userId: Aber.find<GlobalAbController>().loggedInUser()!.id);
            await refreshCurrentGroup();
            SmartDialog.dismiss(status: SmartStatus.dialog);
          },
        );
      },
    );
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
