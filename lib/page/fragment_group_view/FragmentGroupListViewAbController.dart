import 'dart:async';
import 'dart:convert';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:tools/tools.dart';

class FragmentGroupListViewAbController extends GroupListWidgetController<FragmentGroup, Fragment, RFragment2FragmentGroup> {
  FragmentGroupListViewAbController({required this.userId, required this.enterFragmentGroup});

  final int userId;

  final currentUser = Ab<User?>(null);

  /// 因为不能将 surface 进行发布，因此 [enterFragmentGroup] 始终是 dynamicFragmentGroup 类型。
  ///
  /// 为 null 的话，说明进入的是 [userId] 的 root.
  final FragmentGroup? enterFragmentGroup;

  final currentFragmentGroupTagsAb = <FragmentGroupTag>[].ab;

  @override
  void onInit() {
    super.onInit();
    queryCurrentUser();
  }

  Future<void> queryCurrentUser() async {
    final result = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_SINGLE_ROW_QUERY,
      dtoData: SingleRowQueryDto(
        table_name: db.users.actualTableName,
        row_id: userId,
      ),
      parseResponseVoData: SingleRowQueryVo.fromJson,
    );
    await result.handleCode(
      code90101: (String showMessage, SingleRowQueryVo vo) async {
        currentUser.refreshInevitable((obj) => User.fromJson(vo.row));
        thisRefresh();
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
      },
    );
  }

  @override
  Future<bool> backListener(bool hasRoute) async {
    if (hasRoute) return false;
    if (getGroupChainNotRoot().isNotEmpty) {
      await backGroup();
      return true;
    }
    return false;
  }

  /// TODO: 云端查询问题
  @override
  Future<GroupsAndUnitEntities<FragmentGroup, Fragment, RFragment2FragmentGroup>> findEntities(FragmentGroup? whichSurfaceGroupEntity) async {
    // 因为不能将 surface 进行发布，因此 [enterFragmentGroup] 始终是 target。
    final targetId = (whichSurfaceGroupEntity?.jump_to_fragment_groups_id ?? whichSurfaceGroupEntity?.id) ?? enterFragmentGroup?.id;
    final result = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUP_ONE_SUB_QUERY,
      dtoData: FragmentGroupOneSubQueryDto(
        fragment_group_query_wrapper: FragmentGroupQueryWrapper(
          first_target_user_id: userId,
          is_contain_current_login_user_create: Aber.find<GlobalAbController>().loggedInUser()!.id == userId ? true : false,
          only_published: false,
          target_fragment_group_id: targetId,
        ),
        dto_padding_1: null,
      ),
      parseResponseVoData: FragmentGroupOneSubQueryVo.fromJson,
    );
    final gaue = await result.handleCode(
      code30401: (String showMessage, vo) async {
        currentFragmentGroupTagsAb()
          ..clear()
          ..addAll(vo.self_fragment_group_tags_list);

        // 当前组的 surface
        FragmentGroup? currentSurfaceFragmentGroup;
        // 当前组的 jumpTarget
        FragmentGroup? currentJumpTargetFragmentGroup;

        if (enterFragmentGroup != null) {
          if (whichSurfaceGroupEntity == null) {
            currentSurfaceFragmentGroup = vo.self_fragment_group;
            currentJumpTargetFragmentGroup = null;
          } else {
            for (var v in vo.fragment_groups_list) {
              if (v.id == whichSurfaceGroupEntity.jump_to_fragment_groups_id) {
                currentSurfaceFragmentGroup = whichSurfaceGroupEntity;
                currentJumpTargetFragmentGroup = v;
              } else if (v.id == whichSurfaceGroupEntity.id) {
                currentSurfaceFragmentGroup = v;
                currentJumpTargetFragmentGroup = null;
              }
            }
          }
        } else {
          if (whichSurfaceGroupEntity == null) {
            currentSurfaceFragmentGroup = null;
            currentJumpTargetFragmentGroup = null;
          } else {
            for (var v in vo.fragment_groups_list) {
              if (v.id == whichSurfaceGroupEntity.jump_to_fragment_groups_id) {
                currentSurfaceFragmentGroup = whichSurfaceGroupEntity;
                currentJumpTargetFragmentGroup = v;
              } else if (v.id == whichSurfaceGroupEntity.id) {
                currentSurfaceFragmentGroup = v;
                currentJumpTargetFragmentGroup = null;
              }
            }
          }
        }

        // 将 root 组转换成进入组
        // 与返回的 GroupsAndUnitEntities.jumpTargetEntity 不同，这里是设置 root 的，而不是每次进入的。
        if (whichSurfaceGroupEntity == null && enterFragmentGroup != null) {
          setRootGroupEntity(surfaceEntity: currentSurfaceFragmentGroup, jumpTargetEntity: currentJumpTargetFragmentGroup);
        }

        final fragmentWithRsBreak = <Unit<Fragment, RFragment2FragmentGroup>>[];
        for (var w in vo.fragments_list) {
          for (var r in w.r_fragment_2_fragment_groups) {
            fragmentWithRsBreak.add(Unit(unitEntity: w.fragment, unitREntity: r));
          }
        }
        return GroupsAndUnitEntities(
          groupEntities: vo.fragment_groups_list,
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

  @override
  Future<(int, int)> needRefreshCount(Ab<Group<FragmentGroup, Fragment, RFragment2FragmentGroup>> whichGroup) async {
    return (0, 0);
  }

  @override
  FutureOr<void> refreshExtra() async {
    await queryCurrentUser();
  }

  @override
  FutureOr<void> refreshDone() {}
}
