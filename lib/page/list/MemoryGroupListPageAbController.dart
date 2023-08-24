import 'package:aaa/push_page/push_page.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPage/MemoryGroupGizmoEditPage.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryGroupListPageAbController extends AbController {
  MemoryGroupListPageAbController({required this.user});

  final User user;
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final memoryGroupGizmos = <MemoryGroup>[].ab;

  Future<void> refreshPage() async {
    final result = await request(
      path: HttpPath.POST__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUPS_QUERY,
      dtoData: MemoryGroupsQueryDto(
        user_id: user.id,
        dto_padding_1: null,
      ),
      parseResponseVoData: MemoryGroupsQueryVo.fromJson,
    );
    await result.handleCode(
      code160101: (String showMessage, MemoryGroupsQueryVo vo) async {
        memoryGroupGizmos().clear();
        memoryGroupGizmos.refreshInevitable((obj) => obj..addAll(vo.memory_groups_list));
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );
  }

  Future<void> onStatusTap(MemoryGroup memoryGroupGizmo) async {
    await pushToMemoryGroupGizmoEditPageOfModify(context: context, memoryGroupId: memoryGroupGizmo.id);
    await refreshPage();
  }
}
