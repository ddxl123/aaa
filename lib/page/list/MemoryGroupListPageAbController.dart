import 'package:drift_main/drift/DriftDb.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPage/MemoryGroupGizmoEditPage.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class MemoryGroupListPageAbController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final memoryGroupGizmos = <Ab<MemoryGroup>>[].ab;

  Future<void> refreshPage() async {
    final mgs = await DriftDb.instance.generalQueryDAO.queryAllMemoryGroups();
    memoryGroupGizmos.clearBroken(this);
    memoryGroupGizmos.refreshInevitable((obj) => obj..addAll(mgs.map((e) => e.ab)));
  }

  void onStatusTap(Ab<MemoryGroup> memoryGroupGizmo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MemoryGroupGizmoEditPage(
          editPageType: MemoryGroupGizmoEditPageType.modify,
          memoryGroupGizmo: memoryGroupGizmo,
        ),
      ),
    );
  }
}
