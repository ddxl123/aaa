import 'dart:async';
import 'dart:convert';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';

import '../../push_page/push_page.dart';
import '../list/FragmentGroupListSelfPageController.dart';
import 'FragmentGroupSelectViewAbController.dart';

class FragmentGroupListViewAbController extends GroupListWidgetController<FragmentGroup, Fragment, RFragment2FragmentGroup> {
  FragmentGroupListViewAbController({required this.enterUserId, required this.enterFragmentGroupId});

  final int enterUserId;

  final int? enterFragmentGroupId;

  final enterUser = Ab<User?>(null);

  /// 因为不能将 surface 进行发布，因此 [enterFragmentGroupAb] 始终是 dynamicFragmentGroup 类型。
  ///
  /// 为 null 的话，说明进入的是 [enterUserId] 的 root.
  final currentFragmentGroupInformation = Ab<KnowledgeBaseFragmentGroupWrapperBo?>(null);

  @override
  Future<bool> backListener(bool hasRoute) async {
    if (hasRoute) return false;
    if (getGroupChainNotRoot().isNotEmpty) {
      await backGroup();
      return true;
    }
    return false;
  }

  @override
  Future<GroupsAndUnitEntities<FragmentGroup, Fragment, RFragment2FragmentGroup>> findEntities(FragmentGroup? whichSurfaceGroupEntity) async {
    // 因为不能将 surface 进行发布，因此 [enterFragmentGroup] 始终是 target。
    final targetDynamicId = (whichSurfaceGroupEntity?.jump_to_fragment_groups_id ?? whichSurfaceGroupEntity?.id) ?? enterFragmentGroupId;
    // 获取当前页面的当前碎片组和子碎片组以及碎片。
    final result = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUP_ONE_SUB_QUERY,
      dtoData: FragmentGroupOneSubQueryDto(
        fragment_group_query_wrapper: FragmentGroupQueryWrapper(
          first_target_user_id: enterUserId,
          is_contain_current_login_user_create: Aber.find<GlobalAbController>().loggedInUser()!.id == enterUserId ? true : false,
          only_published: false,
          target_fragment_group_id: targetDynamicId,
        ),
        dto_padding_1: null,
      ),
      parseResponseVoData: FragmentGroupOneSubQueryVo.fromJson,
    );
    final gaue = await result.handleCode(
      code30401: (String showMessage, vo) async {
        // 当前组的 surface
        FragmentGroup? currentSurfaceFragmentGroup;
        // 当前组的 jumpTarget
        FragmentGroup? currentJumpTargetFragmentGroup;

        if (enterFragmentGroupId != null) {
          if (whichSurfaceGroupEntity == null) {
            currentSurfaceFragmentGroup = vo.self_fragment_group;
            currentJumpTargetFragmentGroup = null;
          } else {
            currentSurfaceFragmentGroup = whichSurfaceGroupEntity;
            currentJumpTargetFragmentGroup = whichSurfaceGroupEntity.jump_to_fragment_groups_id == null ? null : vo.self_fragment_group;
          }
        } else {
          if (whichSurfaceGroupEntity == null) {
            currentSurfaceFragmentGroup = null;
            currentJumpTargetFragmentGroup = null;
          } else {
            currentSurfaceFragmentGroup = whichSurfaceGroupEntity;
            currentJumpTargetFragmentGroup = whichSurfaceGroupEntity.jump_to_fragment_groups_id == null ? null : vo.self_fragment_group;
          }
        }

        // 将 root 组转换成进入组
        // 与返回的 GroupsAndUnitEntities.jumpTargetEntity 不同，这里是设置 root 的，而不是每次进入的。
        if (whichSurfaceGroupEntity == null && enterFragmentGroupId != null) {
          setRootGroupEntity(surfaceEntity: currentSurfaceFragmentGroup, jumpTargetEntity: currentJumpTargetFragmentGroup);
        }

        final fragmentWithRsBreak = <Unit<Fragment, RFragment2FragmentGroup>>[];
        for (var w in vo.fragments_list) {
          for (var r in w.r_fragment_2_fragment_groups) {
            fragmentWithRsBreak.add(Unit(unitEntity: w.fragment, unitREntity: r));
          }
        }
        return GroupsAndUnitEntities(
          groupEntities: vo.fragment_group_with_jump_wrappers_list.map((e) => (e.fragment_group, e.jump_fragment_group)).toList(),
          unitEntities: fragmentWithRsBreak,
          jumpTargetEntity: currentJumpTargetFragmentGroup,
        );
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
        // TODO：
        throw "出现异常！";
      },
    );
    return gaue;
  }

  Future<void> _queryCurrentUser() async {
    final result = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_SINGLE_ROW_QUERY,
      dtoData: SingleRowQueryDto(
        table_name: driftDb.users.actualTableName,
        row_id: enterUserId,
      ),
      parseResponseVoData: SingleRowQueryVo.fromJson,
    );
    await result.handleCode(
      code90101: (String showMessage, SingleRowQueryVo vo) async {
        enterUser.refreshInevitable((obj) => User.fromJson(vo.row));
        thisRefresh();
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
      },
    );
  }

  Future<void> _queryCurrentFragmentGroupInformation() async {
    if (enterFragmentGroupId == null) {
      currentFragmentGroupInformation.refreshInevitable((obj) => null);
      return;
    }
    final result = await request(
      path: HttpPath.GET__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUP_INFORMATION,
      dtoData: FragmentGroupInformationDto(
        fragment_group_id: enterFragmentGroupId!,
        dto_padding_1: null,
      ),
      parseResponseVoData: FragmentGroupInformationVo.fromJson,
    );
    await result.handleCode(
      code151201: (String showMessage, FragmentGroupInformationVo vo) async {
        currentFragmentGroupInformation.refreshInevitable((obj) => vo.knowledge_base_fragment_group_wrapper_bo);
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
      },
    );
  }

  @override
  FutureOr<void> refreshExtra() async {
    await _queryCurrentUser();
    await _queryCurrentFragmentGroupInformation();
  }

  @override
  Future<(int, int)> needRefreshCount(Ab<Group<FragmentGroup, Fragment, RFragment2FragmentGroup>> whichGroup) async {
    return (0, 0);
  }

  @override
  FutureOr<void> refreshDone() {}

  /// 返回是否已喜欢。
  Future<bool> likeHandle() async {
    if (enterFragmentGroupId == null) {
      return false;
    }
    final result = await request(
      path: HttpPath.GET__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUP_LIKE_CHANGE,
      dtoData: FragmentGroupLikeChangeForCurrentLoginedDto(
        fragment_group_id: enterFragmentGroupId!,
        dto_padding_1: null,
      ),
      parseResponseVoData: FragmentGroupLikeChangeForCurrentLoginedVo.fromJson,
    );
    await result.handleCode(
      code151301: (String showMessage, FragmentGroupLikeChangeForCurrentLoginedVo vo) async {
        if (currentFragmentGroupInformation()?.liked_id_for_current_logined == null) {
          if (vo.liked != null) {
            currentFragmentGroupInformation()?.liked_count += 1;
          }
        } else {
          if (vo.liked == null) {
            currentFragmentGroupInformation()?.liked_count -= 1;
          }
        }
        currentFragmentGroupInformation()?.liked_id_for_current_logined = vo.liked;
        currentFragmentGroupInformation.refreshForce();
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );
    return currentFragmentGroupInformation()?.liked_id_for_current_logined != null;
  }

  Future<void> download(FragmentGroup targetSurfaceFragmentGroup) async {
    await pushToFragmentGroupSelectView(
      context: context,
      selectResult: (FragmentGroup? selectedDynamicFragmentGroup, FragmentGroupSelectViewAbController controller) async {
        await controller.selectFragmentGroup(targetSurfaceFragmentGroup: targetSurfaceFragmentGroup, isSelect: true);
        await controller.reuseSelectedOrDownload(reuseOrDownload: ReuseOrDownload.download);
      },
    );
  }
}
