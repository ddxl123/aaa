import 'package:aaa/push_page/push_page.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPage/MemoryGroupGizmoEditPage.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryGroupListPageAbController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final memoryGroupGizmos = <Ab<MemoryGroup>>[].ab;

  Future<void> refreshPage() async {
    throw "TODO";
    // final mgs = await DriftDb.instance.generalQueryDAO.queryMemoryGroups();
    // memoryGroupGizmos.clearBroken(this);
    // memoryGroupGizmos.refreshInevitable((obj) => obj..addAll(mgs.map((e) => e.ab)));
  }

  Future<void> onStatusTap(Ab<MemoryGroup> memoryGroupGizmo) async {
    await pushToMemoryGroupGizmoEditPageOfModify(context: context, memoryGroupId: memoryGroupGizmo().id);
    await refreshPage();
  }
}
