import 'dart:async';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class FragmentGroupListPageController extends GroupListWidgetController<FragmentGroup, Fragment, RFragment2FragmentGroup> {
  final currentFragmentGroupTagsAb = <FragmentGroupTag>[].ab;

  @override
  Future<GroupsAndUnitEntities<FragmentGroup, Fragment, RFragment2FragmentGroup>> findEntities(FragmentGroup? whichSurfaceGroupEntity) async {
    FragmentGroup? jumpTargetFragmentGroup;
    if (whichSurfaceGroupEntity?.jump_to_fragment_groups_id != null) {
      jumpTargetFragmentGroup = await db.generalQueryDAO.queryJumpTargetFragmentGroup(jumpTargetFragmentGroupId: whichSurfaceGroupEntity!.jump_to_fragment_groups_id!);
    }
    // 若 whichGroupEntity 不为 null，则必然存在 whichGroupEntity。father_fragment_groups_id!。
    final fs = await db.generalQueryDAO.queryFragmentsInFragmentGroupById(surfaceFragmentGroup: whichSurfaceGroupEntity, set: {});
    final fgs = await db.generalQueryDAO.queryFragmentGroupsInFragmentGroupById(surfaceFragmentGroup: whichSurfaceGroupEntity);
    // 相同碎片组可能会出现多次，但 id 不一样
    return GroupsAndUnitEntities(
      unitEntities: fs.values.expand((element) => element.$2).map((e) => Unit(unitEntity: fs[e.fragment_id]!.$1, unitREntity: e)).toList(),
      groupEntities: fgs,
      jumpTargetEntity: jumpTargetFragmentGroup,
    );
  }

  @override
  Future<(int, int)> needRefreshCount(Ab<Group<FragmentGroup, Fragment, RFragment2FragmentGroup>> whichGroup) async {
    final selectedCount = await DriftDb.instance.generalQueryDAO.querySubFragmentsCountInFragmentGroup(
      surfaceFragmentGroup: whichGroup().surfaceEntity(),
      queryFragmentWhereType: QueryFragmentWhereType.selected,
    );
    final allCount = await DriftDb.instance.generalQueryDAO.querySubFragmentsCountInFragmentGroup(
      surfaceFragmentGroup: whichGroup().surfaceEntity(),
      queryFragmentWhereType: QueryFragmentWhereType.all,
    );
    // 不相等的话，取消选择父组
    if (selectedCount != allCount) {
      final st = await SyncTag.create();
      await db.updateDAO.resetFragmentGroupIsSelected(
        surfaceFragmentGroup: whichGroup().surfaceEntity(),
        isSelected: false,
        syncTag: st,
      );
    }
    return (selectedCount, allCount);
  }

  Future<void> resetFragmentIsSelected({
    required Ab<Unit<Fragment, RFragment2FragmentGroup>> unitAb,
    required bool isSelected,
  }) async {
    await db.updateDAO.resetFragmentIsSelected(
      rFragment2FragmentGroup: unitAb().unitREntity,
      isSelected: isSelected,
      syncTag: await SyncTag.create(),
    );
    unitAb.refreshForce();
    await refreshCount(whichGroup: getCurrentGroupAb());
  }

  Future<void> resetFragmentGroupAndSubIsSelected({
    required Ab<FragmentGroup?> fragmentGroupAb,
    required bool isSelected,
  }) async {
    await db.updateDAO.resetFragmentGroupAndSubIsSelected(
      surfaceFragmentGroup: fragmentGroupAb(),
      isSelected: isSelected,
      syncTag: await SyncTag.create(),
    );
    fragmentGroupAb.refreshForce();
    await refreshCount(whichGroup: getCurrentGroupAb());
  }

  @override
  FutureOr<void> refreshExtra() async {
    if (getCurrentGroupAb()().getDynamicGroupEntity() != null) {
      final tags = await db.generalQueryDAO.queryFragmentGroupTagsByFragmentGroupId(
        fragmentGroupId: getCurrentGroupAb()().getDynamicGroupEntity()!.id,
      );
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
            surfaceFragmentGroup: value().surfaceEntity()!,
            isSelected: true,
            syncTag: st,
          );
        }
        for (var value in getCurrentGroupAb()().units()) {
          await db.updateDAO.resetFragmentIsSelected(
            rFragment2FragmentGroup: value().unitREntity,
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
            surfaceFragmentGroup: value().surfaceEntity()!,
            isSelected: false,
            syncTag: st,
          );
        }
        for (var value in getCurrentGroupAb()().units()) {
          await db.updateDAO.resetFragmentIsSelected(
            rFragment2FragmentGroup: value().unitREntity,
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
            surfaceFragmentGroup: value().surfaceEntity()!,
            isSelected: !value().surfaceEntity()!.client_be_selected,
            syncTag: st,
          );
        }
        for (var value in getCurrentGroupAb()().units()) {
          await db.updateDAO.resetFragmentIsSelected(
            rFragment2FragmentGroup: value().unitREntity,
            isSelected: !value().unitREntity.client_be_selected,
            syncTag: st,
          );
        }
      },
    );
    await refreshCurrentGroup();
  }

  /// 清空全部已选
  Future<void> clearAllSelected() async {
    await db.updateDAO.resetAllSelectedFragmentAndFragmentGroupToClear();
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

  /// 移动已选
  ///
  /// 当碎片组是 jump 类型，则移动的是 jump，不会对源碎片组进行移动。
  Future<void> moveSelected() async {
    final currentSurfaceFragmentGroup = getCurrentGroupAb()().surfaceEntity();
    final fgs = await db.generalQueryDAO.queryAllSelectedFragmentGroups();
    final fs = await db.generalQueryDAO.queryAllSelectedFragments();
    final isExist = getGroupChainCombineEntityNotRoot().any((chain) => fgs.any((fg) => chain.id == fg.id));
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
          await db.transaction(
            () async {
              final st = await SyncTag.create();
              final user = Aber.find<GlobalAbController>().loggedInUser()!;
              for (var v in fgs) {
                // 当 v 的 father 未被选择时（而非 v 的祖父），如果 father 被选择，则会将 father 整组进行移动。
                // 不用担心同一页面出现相同碎片组的问题，因为同一页面不会出现相同 id 的碎片组，重复的碎片组已经用 jump 方式跳转了，不会出现相同碎片组 id 的情况。

                // 碎片组的父组是否也被选择（非祖父组）
                final isFatherSelected = fgs.any((element) {
                  if (element.jump_to_fragment_groups_id != null) {
                    return element.jump_to_fragment_groups_id == v.father_fragment_groups_id;
                  }
                  return element.id == v.father_fragment_groups_id;
                });

                if (!isFatherSelected) {
                  await RefFragmentGroups(
                    self: () async {
                      await v.reset(
                        be_publish: toAbsent(),
                        client_be_selected: toAbsent(),
                        creator_user_id: toAbsent(),
                        father_fragment_groups_id: (currentSurfaceFragmentGroup?.jump_to_fragment_groups_id ?? currentSurfaceFragmentGroup?.id).toValue(),
                        jump_to_fragment_groups_id: toAbsent(),
                        profile: toAbsent(),
                        title: toAbsent(),
                        client_cover_local_path: toAbsent(),
                        cover_cloud_path: toAbsent(),
                        client_be_cloud_path_upload: toAbsent(),
                        syncTag: st,
                        isCloudTableWithSync: SyncTag.parseToUserId(v.id) == user.id,
                      );
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
              }
              for (var v in fs.values.map((e) => e.$2)) {
                for (var inner in v) {
                  // 碎片组的父组是否也被选择（非祖父组）
                  final isFatherSelected = fgs.any((element) {
                    if (element.jump_to_fragment_groups_id != null) {
                      return element.jump_to_fragment_groups_id == inner.fragment_group_id;
                    }
                    return element.id == inner.fragment_group_id;
                  });

                  // 当 v 所在的组未被选择时（而非 v 的祖父），如果 father 被选择，则会将 father 整组进行移动。
                  // 因为 jump 的设定，碎片组始终是唯一的，因此 rFragment2FragmentGroup 的 fragmentGroupId 也是唯一的。
                  if (!isFatherSelected) {
                    await RefRFragment2FragmentGroups(
                      self: () async {
                        await inner.reset(
                          client_be_selected: toAbsent(),
                          creator_user_id: toAbsent(),
                          fragment_group_id: (currentSurfaceFragmentGroup?.jump_to_fragment_groups_id ?? currentSurfaceFragmentGroup?.id).toValue(),
                          fragment_id: toAbsent(),
                          syncTag: st,
                          isCloudTableWithSync: SyncTag.parseToUserId(inner.id) == user.id,
                        );
                      },
                      order: 0,
                    ).run();
                  }
                }
              }
              await refreshCurrentGroup();
              SmartDialog.dismiss(status: SmartStatus.dialog);
            },
          );
        },
      ),
    );
  }

  /// 复用已选
  Future<void> reuseSelected() async {
    final fgs = await db.generalQueryDAO.queryAllSelectedFragmentGroups();
    final isExist = getGroupChainCombineEntityNotRoot().any((chain) => fgs.any((fg) => chain.id == fg.id));
    if (isExist) {
      SmartDialog.showToast("不能将自身移动到自身上面！");
      return;
    }
    await showCustomDialog(
      builder: (ctx) {
        return OkAndCancelDialogWidget(
          title: "是否将已选的复用到当前页面碎片组内？",
          okText: "复用",
          cancelText: "返回",
          onOk: () async {
            await db.transaction(
              () async {
                final user = Aber.find<GlobalAbController>().loggedInUser()!;
                final currentSurfaceFragmentGroup = getCurrentGroupAb()().surfaceEntity();

                final fgs = await db.generalQueryDAO.queryAllSelectedFragmentGroups();
                final fs = await db.generalQueryDAO.queryAllSelectedFragments();

                final st = await SyncTag.create();

                for (var v in fgs) {
                  // 碎片组的父组是否也被选择（非祖父组）
                  final isFatherSelected = fgs.any((element) {
                    if (element.jump_to_fragment_groups_id != null) {
                      return element.jump_to_fragment_groups_id == v.father_fragment_groups_id;
                    }
                    return element.id == v.father_fragment_groups_id;
                  });
                  if (!isFatherSelected) {
                    await RefFragmentGroups(
                      self: () async {
                        await Crt.fragmentGroupsCompanion(
                          be_publish: false,
                          client_be_selected: false,
                          creator_user_id: v.creator_user_id,
                          father_fragment_groups_id: (currentSurfaceFragmentGroup?.jump_to_fragment_groups_id ?? currentSurfaceFragmentGroup?.id).toValue(),
                          jump_to_fragment_groups_id: (v.jump_to_fragment_groups_id ?? v.id).toValue(),
                          profile: "未进行跳转：${v.profile}",
                          title: "未进行跳转：${v.title}",
                          client_cover_local_path: null.toValue(),
                          cover_cloud_path: null.toValue(),
                          client_be_cloud_path_upload: false,
                        ).insert(
                          syncTag: st,
                          isCloudTableWithSync: true,
                          isCloudTableAutoId: true,
                          isReplaceWhenIdSame: false,
                        );
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
                }

                for (var v in fs.values) {
                  for (var inner in v.$2) {
                    // 碎片组的父组是否也被选择（非祖父组）
                    final isFatherSelected = fgs.any((element) {
                      if (element.jump_to_fragment_groups_id != null) {
                        return element.jump_to_fragment_groups_id == inner.fragment_group_id;
                      }
                      return element.id == inner.fragment_group_id;
                    });
                    if (!isFatherSelected) {
                      await RefRFragment2FragmentGroups(
                        self: () async {
                          await Crt.rFragment2FragmentGroupsCompanion(
                            client_be_selected: false,
                            creator_user_id: user.id,
                            fragment_group_id: (currentSurfaceFragmentGroup?.jump_to_fragment_groups_id ?? currentSurfaceFragmentGroup?.id).toValue(),
                            fragment_id: v.$1.id,
                          ).insert(
                            syncTag: st,
                            isCloudTableWithSync: true,
                            // 每个复用碎片都会产生新的 id，因此每个页面可以重复出现相同碎片。
                            isCloudTableAutoId: true,
                            isReplaceWhenIdSame: false,
                          );
                        },
                        order: 0,
                      ).run();
                    }
                  }
                }
                await refreshCurrentGroup();
                SmartDialog.dismiss(status: SmartStatus.dialog);
              },
            );
          },
        );
      },
    );
  }

  /// 删除已选
  ///
  /// 如果碎片存在于多个组中，则只删除其 RFragment2FragmentGroup。
  /// 如果碎片只存在于一个组中，则 Fragment 和 RFragment2FragmentGroup 都删除。
  Future<void> deleteSelected() async {
    await showCustomDialog(
      builder: (ctx) {
        return OkAndCancelDialogWidget(
          title: "若你是创建者，删除后将不可恢复，确定要删除？",
          okText: "删除",
          cancelText: "返回",
          onOk: () async {
            await db.transaction(
              () async {
                final userId = Aber.find<GlobalAbController>().loggedInUser()!.id;

                final fgs = await db.generalQueryDAO.queryAllSelectedFragmentGroups();
                final fs = await db.generalQueryDAO.queryAllSelectedFragments();

                final fTags = await db.generalQueryDAO.queryFragmentGroupTagsByFragmentGroupIds(
                  fragmentGroupIds: fgs.map(
                    (e) {
                      if (e.jump_to_fragment_groups_id != null) {
                        return e.jump_to_fragment_groups_id!;
                      }
                      return e.id;
                    },
                  ).toList(),
                );

                final st = await SyncTag.create();

                await RefFragmentGroups(
                  self: () async {
                    for (var element in fgs) {
                      await element.delete(
                        syncTag: st,
                        isCloudTableWithSync: SyncTag.parseToUserId(element.id) == userId,
                      );
                      if (element.jump_to_fragment_groups_id != null) {
                        final jumpTarget = await db.generalQueryDAO.queryJumpTargetFragmentGroup(jumpTargetFragmentGroupId: element.jump_to_fragment_groups_id!);
                        await jumpTarget?.delete(
                          syncTag: st,
                          isCloudTableWithSync: SyncTag.parseToUserId(element.id) == userId,
                        );
                      }
                    }
                  },
                  fragmentGroupTags: RefFragmentGroupTags(
                    self: () async {
                      for (var fTag in fTags) {
                        await fTag.delete(syncTag: st, isCloudTableWithSync: SyncTag.parseToUserId(fTag.id) == userId);
                      }
                    },
                    order: 0,
                  ),
                  rFragment2FragmentGroups: null,
                  fragmentGroups_father_fragment_groups_id: null,
                  fragmentGroups_jump_to_fragment_groups_id: null,
                  userComments: null,
                  userLikes: null,
                  order: 0,
                ).run();

                await RefFragments(
                  self: () async {
                    // 先删除全部已选的 rFragment2FragmentGroup，再查询游离的 fragment 进行删除。
                    for (var value in fs.values) {
                      for (var inner in value.$2) {
                        print("==========================");
                        print(inner.id);
                        await inner.delete(
                          syncTag: st,
                          isCloudTableWithSync: SyncTag.parseToUserId(value.$2.first.id) == userId,
                        );
                      }
                    }
                    await db.deleteDAO.deleteAllFreeFragment(syncTag: st, userId: userId);
                  },
                  fragmentMemoryInfos: null,
                  rFragment2FragmentGroups: null,
                  fragments_father_fragment_id: null,
                  memoryModels: null,
                  userComments: null,
                  userLikes: null,
                  order: 0,
                ).run();

                await refreshCurrentGroup();
                SmartDialog.dismiss(status: SmartStatus.dialog);
              },
            );
          },
        );
      },
    );
  }

  /// [dynamicFragmentGroup] 是否属于自己的。
  bool isSelfOfFragmentGroup({required FragmentGroup dynamicFragmentGroup}) {
    if (SyncTag.parseToUserId(dynamicFragmentGroup.id) != Aber.find<GlobalAbController>().loggedInUser()!.id) {
      return false;
    }
    return true;
  }

  @override
  FutureOr<void> refreshDone() {}
}
