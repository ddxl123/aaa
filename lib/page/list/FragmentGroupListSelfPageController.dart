import 'dart:async';
import 'dart:convert';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/page/fragment_group_view/FragmentGroupListViewAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;

enum ReuseOrDownload {
  reuse,
  download,
}

class FragmentGroupListSelfPageController extends FragmentGroupListViewAbController {
  FragmentGroupListSelfPageController({required super.enterUserId, required super.enterFragmentGroupId});

  /// fragmentGroupId（已去重） - fragmentGroup
  ///
  /// 与 [selectedFragmentsMap] 不会被同时选择。
  final selectedSurfaceFragmentGroupsMap = <int, FragmentGroup>{}.ab;

  /// fragmentId(已去重) - Units
  ///
  /// 与 [selectedSurfaceFragmentGroupsMap] 不会被同时选择。
  final selectedFragmentsMap = <int, List<Unit<Fragment, RFragment2FragmentGroup>>>{}.ab;

  bool isSelectedUnit({required Unit<Fragment, RFragment2FragmentGroup> unit, Abw? abw}) {
    return selectedFragmentsMap(abw)[unit.unitEntity.id]?.where((element) => element.unitREntity.id == unit.unitREntity.id).isNotEmpty == true;
  }

  /// 获取已选碎片。
  ///
  /// 注意：已选碎片组与已选碎片不会被同时选择。
  Future<List<int>> getSelectedFragments() async {
    final selectedFIds = <int>[];
    if (selectedSurfaceFragmentGroupsMap().isNotEmpty) {
      final countResult = await request(
        path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUPS_FRAGMENT_IDS_WITH_R_QUERY,
        dtoData: FragmentGroupsFragmentIdsWithRQueryDto(
          fragment_group_ids_list: selectedSurfaceFragmentGroupsMap().keys.toList(),
          is_contain_current_login_user_create: true,
        ),
        parseResponseVoData: FragmentGroupsFragmentIdsWithRQueryVo.fromJson,
      );
      await countResult.handleCode(
        code150301: (String showMessage, vo) async {
          selectedFIds.addAll(vo.fragment_id_with_rs_list.map((e) => e.fragment_id));
        },
        otherException: (a, b, c) async {
          logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
        },
      );
    } else {
      selectedFIds.addAll(selectedFragmentsMap().keys);
    }
    return selectedFIds;
  }

  /// 获取已选碎片数量。
  ///
  /// 注意：已选碎片组与已选碎片不会被同时选择。
  Future<int> getSelectedFragmentsCount() async {
    int count = 0;
    if (selectedSurfaceFragmentGroupsMap().isNotEmpty) {
      final countResult = await request(
        path: HttpPath.GET__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUPS_FRAGMENTS_COUNT_QUERY,
        dtoData: FragmentGroupsFragmentsCountQueryDto(
          fragment_group_ids_list: selectedSurfaceFragmentGroupsMap().keys.toList(),
          is_contain_current_login_user_create: true,
        ),
        parseResponseVoData: FragmentGroupsFragmentsCountQueryVo.fromJson,
      );
      await countResult.handleCode(
        code150201: (String showMessage, vo) async {
          count = vo.no_repeat_count;
        },
        otherException: (a, b, c) async {
          logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
        },
      );
    } else {
      count = selectedFragmentsMap().length;
    }
    return count;
  }

  // final currentFragmentGroupTagsAb = <FragmentGroupTag>[].ab;

  // @override
  // Future<GroupsAndUnitEntities<FragmentGroup, Fragment, RFragment2FragmentGroup>> findEntities(FragmentGroup? whichSurfaceGroupEntity) async {
  //   // FragmentGroup? jumpTargetFragmentGroup;
  //   // if (whichSurfaceGroupEntity?.jump_to_fragment_groups_id != null) {
  //   //   jumpTargetFragmentGroup = await db.generalQueryDAO.queryJumpTargetFragmentGroup(jumpTargetFragmentGroupId: whichSurfaceGroupEntity!.jump_to_fragment_groups_id!);
  //   // }
  //   // // 若 whichGroupEntity 不为 null，则必然存在 whichGroupEntity。father_fragment_groups_id!。
  //   // final fs = await db.generalQueryDAO.queryFragmentsInFragmentGroupById(surfaceFragmentGroup: whichSurfaceGroupEntity, set: {});
  //   // final fgs = await db.generalQueryDAO.queryFragmentGroupsInFragmentGroupById(surfaceFragmentGroup: whichSurfaceGroupEntity);
  //   // // 相同碎片组可能会出现多次，但 id 不一样
  //   // return GroupsAndUnitEntities(
  //   //   unitEntities: fs.values.expand((element) => element.$2).map((e) => Unit(unitEntity: fs[e.fragment_id]!.$1, unitREntity: e)).toList(),
  //   //   groupEntities: fgs,
  //   //   jumpTargetEntity: jumpTargetFragmentGroup,
  //   // );
  //   request(path:HttpPath, dtoData: dtoData, parseResponseVoData: parseResponseVoData)
  // }

  @override
  Future<(int, int)> needRefreshCount(Ab<Group<FragmentGroup, Fragment, RFragment2FragmentGroup>> whichGroup) async {
    return (0, 0);
    // final selectedCount = await DriftDb.instance.generalQueryDAO.querySubFragmentsCountInFragmentGroup(
    //   surfaceFragmentGroup: whichGroup().surfaceEntity(),
    //   queryFragmentWhereType: QueryFragmentWhereType.selected,
    // );
    // final allCount = await DriftDb.instance.generalQueryDAO.querySubFragmentsCountInFragmentGroup(
    //   surfaceFragmentGroup: whichGroup().surfaceEntity(),
    //   queryFragmentWhereType: QueryFragmentWhereType.all,
    // );
    // // 不相等的话，取消选择父组
    // if (selectedCount != allCount) {
    //   final st = await SyncTag.create();
    //   await db.updateDAO.resetFragmentGroupIsSelected(
    //     surfaceFragmentGroup: whichGroup().surfaceEntity(),
    //     isSelected: false,
    //     syncTag: st,
    //   );
    // }
    // return (selectedCount, allCount);
  }

  void selectFragment({
    required Unit<Fragment, RFragment2FragmentGroup> unit,
    required bool isSelect,
  }) {
    if (selectedSurfaceFragmentGroupsMap().isNotEmpty) {
      SmartDialog.showToast("碎片组和碎片不能同时选择！");
      return;
    }
    if (isSelect) {
      if (!selectedFragmentsMap().containsKey(unit.unitEntity.id)) {
        selectedFragmentsMap().addAll({unit.unitEntity.id: []});
      }
      selectedFragmentsMap()[unit.unitEntity.id]!.add(unit);
    } else {
      final many = selectedFragmentsMap()[unit.unitEntity.id];
      // 移除 R
      many?.removeWhere((element) => element.unitREntity.id == unit.unitREntity.id);
      if (many?.isEmpty == true) {
        // 如果 R 为空数组，则移除 Fragment
        selectedFragmentsMap().remove(unit.unitEntity.id);
      }
    }
    selectedFragmentsMap.refreshForce();
  }

  Future<void> selectFragmentGroup({
    required FragmentGroup targetSurfaceFragmentGroup,
    required bool isSelect,
  }) async {
    if (selectedFragmentsMap().isNotEmpty) {
      SmartDialog.showToast("碎片组和碎片不能同时选择！");
      return;
    }
    if (isSelect) {
      final fragmentGroupQueryWrapper = FragmentGroupQueryWrapper(
        first_target_user_id: enterUserId,
        is_contain_current_login_user_create: true,
        only_published: false,
        target_fragment_group_id: targetSurfaceFragmentGroup.jump_to_fragment_groups_id ?? targetSurfaceFragmentGroup.id,
      );
      final result = await request(
        path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_ALL_SUB_FRAGMENT_GROUPS_QUERY,
        dtoData: FragmentGroupAllSubFragmentGroupsQueryDto(
          fragment_group_query_wrapper: fragmentGroupQueryWrapper,
          dto_padding_1: null,
        ),
        parseResponseVoData: FragmentGroupAllSubFragmentGroupsQueryVo.fromJson,
      );
      await result.handleCode(
        code30501: (String showMessage, FragmentGroupAllSubFragmentGroupsQueryVo vo) async {
          if (targetSurfaceFragmentGroup.jump_to_fragment_groups_id == null) {
            selectedSurfaceFragmentGroupsMap().addAll({vo.self_fragment_group!.id: vo.self_fragment_group!});
          } else {
            selectedSurfaceFragmentGroupsMap().addAll({targetSurfaceFragmentGroup.id: targetSurfaceFragmentGroup});
          }
          for (var value in vo.fragment_groups_list) {
            selectedSurfaceFragmentGroupsMap().addAll({value.id: value});
          }
        },
        otherException: (a, b, c) async {
          logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
        },
      );
    } else {
      void nestCurrentAndChildrenRemove({required FragmentGroup surfaceFg}) {
        selectedSurfaceFragmentGroupsMap().removeWhere((key, value) => key == surfaceFg.id);
        for (var value in selectedSurfaceFragmentGroupsMap().values.toList()) {
          if (value.father_fragment_groups_id == (surfaceFg.jump_to_fragment_groups_id ?? surfaceFg.id)) {
            nestCurrentAndChildrenRemove(surfaceFg: value);
          }
        }
      }

      void nestCurrentAndFathersRemove({required FragmentGroup surfaceFg}) {
        selectedSurfaceFragmentGroupsMap().removeWhere((key, value) => key == surfaceFg.id);
        for (var value in selectedSurfaceFragmentGroupsMap().values.toList()) {
          if ((value.jump_to_fragment_groups_id ?? value.id) == surfaceFg.father_fragment_groups_id) {
            nestCurrentAndFathersRemove(surfaceFg: value);
          }
        }
      }

      nestCurrentAndChildrenRemove(surfaceFg: targetSurfaceFragmentGroup);

      final firstResult =
          selectedSurfaceFragmentGroupsMap().values.where((element) => (element.jump_to_fragment_groups_id ?? element.id) == targetSurfaceFragmentGroup.father_fragment_groups_id);
      if (firstResult.isNotEmpty) {
        nestCurrentAndFathersRemove(surfaceFg: firstResult.first);
      }
    }
    selectedSurfaceFragmentGroupsMap.refreshForce();
  }

  @override
  FutureOr<void> refreshExtra() async {
    //   if (getCurrentGroupAb()().getDynamicGroupEntity() != null) {
    //     final tags = await db.generalQueryDAO.queryFragmentGroupTagsByFragmentGroupId(
    //       fragmentGroupId: getCurrentGroupAb()().getDynamicGroupEntity()!.id,
    //     );
    //     currentFragmentGroupTagsAb.refreshInevitable((obj) => obj
    //       ..clear()
    //       ..addAll(tags));
    //   }
  }

  /// 对当前页面全选
  Future<void> selectAll() async {
    if (selectedSurfaceFragmentGroupsMap().isEmpty && selectedFragmentsMap().isEmpty) {
      showCustomDialog(
        builder: (ctx) {
          return OkAndCancelDialogWidget(
            title: "请选择一种",
            text: "碎片和碎片组不能被同时选择",
            columnChildren: [
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      child: Text("全选当前页碎片组", style: TextStyle(color: Colors.blue)),
                      onPressed: () async {
                        SmartDialog.dismiss(status: SmartStatus.dialog);
                        for (var value in getCurrentGroupAb()().groups()) {
                          await selectFragmentGroup(targetSurfaceFragmentGroup: value().surfaceEntity()!, isSelect: true);
                        }
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      child: Text("全选当前页碎片", style: TextStyle(color: Colors.blue)),
                      onPressed: () async {
                        SmartDialog.dismiss(status: SmartStatus.dialog);
                        for (var value in getCurrentGroupAb()().units()) {
                          selectFragment(unit: value(), isSelect: true);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
      return;
    }
    if (selectedSurfaceFragmentGroupsMap().isNotEmpty) {
      for (var value in getCurrentGroupAb()().groups()) {
        await selectFragmentGroup(targetSurfaceFragmentGroup: value().surfaceEntity()!, isSelect: true);
      }
      return;
    }
    if (selectedFragmentsMap().isNotEmpty) {
      for (var value in getCurrentGroupAb()().units()) {
        selectFragment(unit: value(), isSelect: true);
      }
    }
  }

  /// 对当前页面全不选
  Future<void> deselectAll() async {
    if (selectedSurfaceFragmentGroupsMap().isNotEmpty) {
      for (var value in getCurrentGroupAb()().groups()) {
        await selectFragmentGroup(targetSurfaceFragmentGroup: value().surfaceEntity()!, isSelect: false);
      }
      return;
    }
    if (selectedFragmentsMap().isNotEmpty) {
      for (var value in getCurrentGroupAb()().units()) {
        selectFragment(unit: value(), isSelect: false);
      }
    }
  }

  /// 清空全部已选
  Future<void> clearAllSelected() async {
    selectedFragmentsMap.refreshInevitable((obj) => obj..clear());
    selectedSurfaceFragmentGroupsMap.refreshInevitable((obj) => obj..clear());
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
    await showCustomDialog(
      builder: (ctx) {
        return OkAndCancelDialogWidget(
          text: "是否将已选的移动到当前页中？",
          cancelText: "返回",
          okText: "移动",
          onOk: () async {
            if (selectedSurfaceFragmentGroupsMap().isNotEmpty && selectedFragmentsMap().isNotEmpty) {
              selectedSurfaceFragmentGroupsMap.refreshInevitable((obj) => obj..clear());
              selectedFragmentsMap.refreshInevitable((obj) => obj..clear());
              SmartDialog.showToast("选择发生异常！");
              return;
            }
            if (selectedSurfaceFragmentGroupsMap().isNotEmpty) {
              // 检测已选碎片组包括子碎片组与当前页碎片组是否存在嵌套
              // 并检测已选碎片组是否存在非自己创建的组。
              bool? nestOrNotSelf;
              getGroupChainSurfaceEntityNotRoot().any(
                (element) {
                  bool isNest = false;
                  isNest = selectedSurfaceFragmentGroupsMap().values.any(
                    (e) {
                      return e.id == element.id;
                    },
                  );
                  if (isNest) {
                    nestOrNotSelf = true;
                    return true;
                  }
                  if (element.creator_user_id != enterUserId) {
                    nestOrNotSelf = false;
                    return true;
                  }
                  return false;
                },
              );
              if (nestOrNotSelf == true) {
                SmartDialog.showToast("不能将已选的碎片组移动到自身之中！");
                return;
              }
              if (nestOrNotSelf == false) {
                SmartDialog.showToast("不能移动非自己创建的碎片组！");
                return;
              }
              // 筛选出已选的顶层碎片组
              final top = selectedSurfaceFragmentGroupsMap().values.toList();
              top.removeWhere(
                (element) => selectedSurfaceFragmentGroupsMap().values.any(
                      // 存在爸爸，则移除
                      (inner) => (inner.jump_to_fragment_groups_id ?? inner.id) == element.father_fragment_groups_id,
                    ),
              );

              // 将 top 移动到当前页碎片组中
              final result = await request(
                path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUPS_MOVE,
                dtoData: FragmentGroupsMoveDto(
                  fragment_groups_list: top.map((e) => e..father_fragment_groups_id = getCurrentGroupAb()().getDynamicGroupEntity()?.id).toList(),
                  dto_padding_1: null,
                ),
                parseResponseVoData: FragmentGroupsMoveVo.fromJson,
              );
              await result.handleCode(
                code150501: (String showMessage) async {
                  SmartDialog.showToast("移动成功！");
                  selectedSurfaceFragmentGroupsMap().clear();
                },
                otherException: (a, b, c) async {
                  logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
                },
              );
            }
            if (selectedFragmentsMap().isNotEmpty) {
              if (selectedFragmentsMap().values.any((element) => element.any((inner) => inner.unitREntity.creator_user_id != enterUserId))) {
                SmartDialog.showToast("不能移动非自己关联的碎片！");
                return;
              } else {
                final result = await request(
                  path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_HANDLE_FRAGMENTS_MOVE,
                  dtoData: FragmentsMoveDto(
                    r_fragment_2_fragment_groups_list: selectedFragmentsMap()
                        .values
                        .expand((element) => element)
                        .map((e) => e.unitREntity..fragment_group_id = getCurrentGroupAb()().getDynamicGroupEntity()?.id)
                        .toList(),
                    dto_padding_1: null,
                  ),
                  parseResponseVoData: FragmentsMoveVo.fromJson,
                );
                await result.handleCode(
                  code150601: (String showMessage) async {
                    SmartDialog.showToast("移动成功！");
                    selectedFragmentsMap().clear();
                  },
                  otherException: (a, b, c) async {
                    logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
                  },
                );
              }
            }
            SmartDialog.dismiss(status: SmartStatus.dialog);
          },
        );
      },
    );
  }

  /// 下载碎片，或复用已选
  Future<void> reuseSelectedOrDownload({required ReuseOrDownload reuseOrDownload}) async {
    final text = reuseOrDownload == ReuseOrDownload.reuse ? "是否将已选的复用到当前页中？" : "是否保存到当前页中？";
    final okText = reuseOrDownload == ReuseOrDownload.reuse ? "复用" : "保存";
    final nestOrNotSelfTrue = reuseOrDownload == ReuseOrDownload.reuse ? "不能将已选的碎片组复用到自身之中！" : "不能将其保存到自身之中！";
    final successToast = reuseOrDownload == ReuseOrDownload.reuse ? "复用成功！" : "保存成功";
    await showCustomDialog(
      builder: (ctx) {
        return OkAndCancelDialogWidget(
          text: text,
          cancelText: "返回",
          okText: okText,
          onOk: () async {
            SmartDialog.showLoading(msg: "保存中...");
            if (selectedSurfaceFragmentGroupsMap().isNotEmpty && selectedFragmentsMap().isNotEmpty) {
              selectedSurfaceFragmentGroupsMap.refreshInevitable((obj) => obj..clear());
              selectedFragmentsMap.refreshInevitable((obj) => obj..clear());
              SmartDialog.showToast("选择发生异常！");
              return;
            }
            if (selectedSurfaceFragmentGroupsMap().isNotEmpty) {
              // 检测已选碎片组包括子碎片组与当前页碎片组是否存在嵌套
              // 并检测已选碎片组是否存在非自己创建的组。
              bool? nestOrNotSelf;
              getGroupChainSurfaceEntityNotRoot().any(
                (element) {
                  bool isNest = false;
                  isNest = selectedSurfaceFragmentGroupsMap().values.any(
                    (e) {
                      return e.id == (element.jump_to_fragment_groups_id ?? element.id);
                    },
                  );
                  if (isNest) {
                    nestOrNotSelf = true;
                    return true;
                  }
                  if (element.creator_user_id != enterUserId) {
                    nestOrNotSelf = false;
                    return true;
                  }
                  return false;
                },
              );
              if (nestOrNotSelf == true) {
                SmartDialog.showToast(nestOrNotSelfTrue);
                return;
              }
              // 筛选出已选的顶层碎片组
              final top = selectedSurfaceFragmentGroupsMap().values.toList();
              top.removeWhere(
                (element) => selectedSurfaceFragmentGroupsMap().values.any(
                      // 存在爸爸，则移除
                      (inner) => (inner.jump_to_fragment_groups_id ?? inner.id) == element.father_fragment_groups_id,
                    ),
              );

              // 将 top 复用到当前页碎片组中
              final result = await request(
                path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUPS_REUSE,
                dtoData: FragmentGroupsReuseDto(
                  fragment_groups_list: top.map(
                    (e) {
                      return Crt.fragmentGroupEntity(
                        creator_user_id: enterUserId,
                        father_fragment_groups_id: getCurrentGroupAb()().getDynamicGroupEntity()?.id,
                        jump_to_fragment_groups_id: e.jump_to_fragment_groups_id ?? e.id,
                        be_publish: false,
                        cover_cloud_path: null,
                        profile: jsonEncode(q.Document().toDelta().toJson()),
                        title: "${e.title}-跳转",
                      );
                    },
                  ).toList(),
                  dto_padding_1: null,
                ),
                parseResponseVoData: FragmentGroupsReuseVo.fromJson,
              );
              await result.handleCode(
                code150701: (String showMessage) async {
                  SmartDialog.showToast(successToast);
                  selectedSurfaceFragmentGroupsMap().clear();
                },
                otherException: (a, b, c) async {
                  logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
                },
              );
            }
            if (selectedFragmentsMap().isNotEmpty) {
              final result = await request(
                path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_HANDLE_FRAGMENTS_REUSE,
                dtoData: FragmentsReuseDto(
                  r_fragment_2_fragment_groups_list: selectedFragmentsMap().values.expand((element) => element).map(
                    (e) {
                      return Crt.rFragment2FragmentGroupEntity(
                        creator_user_id: enterUserId,
                        fragment_group_id: getCurrentGroupAb()().getDynamicGroupEntity()?.id,
                        fragment_id: e.unitEntity.id,
                      );
                    },
                  ).toList(),
                  dto_padding_1: null,
                ),
                parseResponseVoData: FragmentsReuseVo.fromJson,
              );
              await result.handleCode(
                code150801: (String showMessage) async {
                  SmartDialog.showToast(successToast);
                  selectedFragmentsMap().clear();
                },
                otherException: (a, b, c) async {
                  logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
                },
              );
            }
            SmartDialog.dismiss(status: SmartStatus.loading);
            SmartDialog.dismiss(status: SmartStatus.dialog);
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
          text: "是否将已选的进行删除？",
          cancelText: "返回",
          okText: "删除",
          onOk: () async {
            if (selectedSurfaceFragmentGroupsMap().isNotEmpty && selectedFragmentsMap().isNotEmpty) {
              selectedSurfaceFragmentGroupsMap.refreshInevitable((obj) => obj..clear());
              selectedFragmentsMap.refreshInevitable((obj) => obj..clear());
              SmartDialog.showToast("选择发生异常！");
              return;
            }
            if (selectedSurfaceFragmentGroupsMap().isNotEmpty) {
              // 检测已选碎片组包括子碎片组与当前页碎片组是否存在嵌套
              // 并检测已选碎片组是否存在非自己创建的组。
              bool? nestOrNotSelf;
              getGroupChainSurfaceEntityNotRoot().any(
                (element) {
                  if (element.creator_user_id != enterUserId) {
                    nestOrNotSelf = false;
                    return true;
                  }
                  return false;
                },
              );
              if (nestOrNotSelf == false) {
                SmartDialog.showToast("不能删除非自己创建的碎片组！");
                return;
              }
              // 筛选出已选的顶层碎片组
              final top = selectedSurfaceFragmentGroupsMap().values.toList();
              top.removeWhere(
                (element) => selectedSurfaceFragmentGroupsMap().values.any(
                      // 存在爸爸，则移除
                      (inner) => (inner.jump_to_fragment_groups_id ?? inner.id) == element.father_fragment_groups_id,
                    ),
              );

              final result = await request(
                path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUPS_DELETE,
                dtoData: FragmentGroupsDeleteDto(
                  fragment_group_ids_list: top.map((e) => e.id).toList(),
                  dto_padding_1: null,
                ),
                parseResponseVoData: FragmentGroupsDeleteVo.fromJson,
              );
              await result.handleCode(
                code150901: (String showMessage) async {
                  SmartDialog.showToast("删除成功！");
                  selectedSurfaceFragmentGroupsMap().clear();
                },
                otherException: (a, b, c) async {
                  logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
                },
              );
            }
            if (selectedFragmentsMap().isNotEmpty) {
              if (selectedFragmentsMap().values.any((element) => element.any((inner) => inner.unitREntity.creator_user_id != enterUserId))) {
                SmartDialog.showToast("不能删除非自己关联的碎片！");
                return;
              } else {
                final result = await request(
                  path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_HANDLE_FRAGMENTS_DELETE,
                  dtoData: FragmentsDeleteDto(
                    r_fragment_2_fragment_group_ids_list: selectedFragmentsMap()
                        .values
                        .expand((element) => element)
                        .map(
                          (e) => e.unitREntity.id,
                        )
                        .toList(),
                    dto_padding_1: null,
                  ),
                  parseResponseVoData: FragmentsDeleteVo.fromJson,
                );
                await result.handleCode(
                  code151001: (String showMessage) async {
                    SmartDialog.showToast("删除成功！");
                    selectedFragmentsMap().clear();
                  },
                  otherException: (a, b, c) async {
                    logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
                  },
                );
              }
            }
            SmartDialog.dismiss(status: SmartStatus.dialog);
          },
        );
      },
    );
  }

  /// [dynamicFragmentGroup] 是否属于自己的。
  bool isSelfOfFragmentGroup({required FragmentGroup dynamicFragmentGroup}) {
    return dynamicFragmentGroup.creator_user_id == Aber.find<GlobalAbController>().loggedInUser()!.id;
  }

  @override
  FutureOr<void> refreshDone() async {}
}
