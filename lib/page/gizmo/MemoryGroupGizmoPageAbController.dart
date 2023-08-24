import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryGroupGizmoPageAbController extends AbController {
  MemoryGroupGizmoPageAbController({required this.memoryGroupGizmo});

  final MemoryGroup memoryGroupGizmo;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final Ab<MemoryModel?> memoryModel = Ab(null);

  final fragments = <Fragment>[].ab;

  Future<void> refreshPage() async {
    await refreshFragments();
    await refreshMemoryModels();
  }

  Future<void> refreshFragments() async {
    final result = await request(
      path: HttpPath.GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_FRAGMENTS_QUERY,
      dtoData: MemoryGroupFragmentsQueryDto(
        memory_group_id: memoryGroupGizmo.id,
        dto_padding_1: null,
      ),
      parseResponseVoData: MemoryGroupFragmentsQueryVo.fromJson,
    );
    await result.handleCode(
      code160501: (String showMessage, MemoryGroupFragmentsQueryVo vo) async {
        fragments().clear();
        fragments.refreshInevitable((obj) => obj..addAll(vo.fragments_list));
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );
  }

  Future<void> refreshMemoryModels() async {
    // TODO
    // final mg = await db.generalQueryDAO.queryMemoryModelInMemoryGroup(memoryGroup: memoryGroupGizmo());
    // memoryModel.refreshEasy((oldValue) => mg);
  }
}
