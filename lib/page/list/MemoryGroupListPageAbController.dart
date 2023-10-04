import 'package:aaa/push_page/push_page.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPage/MemoryGroupGizmoEditPage.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryGroupListPageAbController extends AbController {
  MemoryGroupListPageAbController({required this.user});

  final User user;
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final memoryGroupGizmos = <MemoryGroup>[].ab;

  Future<void> refreshPage() async {
    final localAll = await driftDb.generalQueryDAO.queryAllMemoryGroups();
    memoryGroupGizmos.refreshInevitable((obj) => obj
      ..clear()
      ..addAll(localAll));

    _cloud();
  }

  Future<void> _cloud() async {
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
        final localAll = memoryGroupGizmos();
        final cloudAll = vo.memory_groups_list;
        final localSet = localAll.map((e) => e.id).toSet();
        final cloudSet = cloudAll.map((e) => e.id).toSet();
        final onlyLocal = localSet.difference(cloudSet);
        final onlyCloud = cloudSet.difference(localSet);

        // 删除仅存在于本地的
        await driftDb.deleteDAO.deleteManyMemoryGroups(mgIds: onlyLocal);
        // 下载仅存在于云端的
        await driftDb.insertDAO.insertManyMemoryGroups(mgs: cloudAll.where((element) => onlyCloud.any((c) => c == element.id)).toList());
        // 覆盖下载云端版本至本地（本地版本低于云端版本）
        final download = localAll.where((element) => cloudAll.any((c) => c.id == element.id && c.sync_version > element.sync_version));
        await driftDb.insertDAO.insertManyMemoryGroups(mgs: download.toList());
        // 覆盖上传本地版本至云端（本地版本高于云端版本）
        final upload = localAll.where((element) => cloudAll.any((c) => c.id == element.id && c.sync_version < element.sync_version));
        final uploadResult = await request(
          path: HttpPath.POST__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUP_MANY_UPDATE,
          dtoData: MemoryGroupManyUpdateDto(
            memory_groups_list: upload.toList(),
            dto_padding_1: null,
          ),
          parseResponseVoData: MemoryGroupManyUpdateVo.fromJson,
        );
        await uploadResult.handleCode(
          code151401: (String showMessage) async {
            // 记忆组同步成功
          },
        );

        memoryGroupGizmos.refreshInevitable((obj) => obj
          ..clear()
          ..addAll(localAll));
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
