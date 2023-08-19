import 'dart:async';
import 'dart:convert';

import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:tools/tools.dart';

class FragmentGroupListViewAbController extends GroupListWidgetController<FragmentGroup, Fragment, RFragment2FragmentGroup> {
  FragmentGroupListViewAbController({required this.userId, required this.enterFragmentGroup});

  final int userId;

  final currentUser = Ab<User?>(null);

  /// 因为不能将 surface 进行发布，因此 [enterFragmentGroup] 始终是 target。
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
      path: HttpPath.NO_LOGIN_REQUIRED_SINGLE_ROW_QUERY,
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
      path: HttpPath.NO_LOGIN_REQUIRED_KNOWLEDGE_BASE_QUERY_KNOWLEDGE_BASE_FRAGMENT_GROUP_INNER,
      dtoData: KnowledgeBaseFragmentGroupInnerQueryDto(
        fragment_group_id: targetId,
        user_id: (whichSurfaceGroupEntity == null && enterFragmentGroup == null) ? userId : null,
      ),
      parseResponseVoData: KnowledgeBaseFragmentGroupInnerQueryVo.fromJson,
    );
    final gaue = await result.handleCode(
      code30401: (String showMessage, KnowledgeBaseFragmentGroupInnerQueryVo vo) async {
        currentFragmentGroupTagsAb()
          ..clear()
          ..addAll(vo.fragment_group_self_tags_list);

        // 当前组的 surface
        FragmentGroup? currentSurfaceFragmentGroup;
        // 当前组的 jumpTarget
        FragmentGroup? currentJumpTargetFragmentGroup;

        if (enterFragmentGroup != null) {
          if (whichSurfaceGroupEntity == null) {
            currentSurfaceFragmentGroup = vo.fragment_groups_list.singleWhere((element) => element.id == enterFragmentGroup!.id);
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
        return GroupsAndUnitEntities(
          // 因为查询的包含 whichSurfaceGroupEntity 自身，因此排除掉。
          groupEntities: vo.fragment_groups_list.where((element) => element.id != targetId).toList(),
          unitEntities: vo.fragments_list.map((e) => Unit(unitEntity: e.fragment, unitREntity: e.r_fragment_2_fragment_groups)).toList(),
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
