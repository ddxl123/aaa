import 'package:drift_main/DriftDb.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPage.dart';
import 'package:aaa/page/edit/EditPageType.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class MemoryGroupListPageAbController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final memoryGroupGizmos = <Ab<MemoryGroup>>[].ab;

  Future<void> refreshPage() async {
    final mgs = await DriftDb.instance.singleDAO.queryMemoryGroups();
    memoryGroupGizmos.clear_(this);
    memoryGroupGizmos.refreshInevitable((obj) => obj..addAll(mgs.map((e) => e.ab)));
  }

  Future<void> onStatusTap(Ab<MemoryGroup> memoryGroupGizmo) async {
    void notStart() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MemoryGroupGizmoEditPage(
            configPageType: EditPageType.modifyCheck,
            memoryGroupGizmo: memoryGroupGizmo,
          ),
        ),
      );
    }

    filter(
      from: memoryGroupGizmo().type,
      targets: {
        [MemoryGroupType.inApp]: () => filter(
              from: memoryGroupGizmo().normalStatus,
              targets: {
                [MemoryGroupStatusForInApp.notStart]: () => notStart(),
              },
              orElse: null,
            ),
        [MemoryGroupType.allFloating]: () => filter(
              from: memoryGroupGizmo().fullFloatingStatus,
              targets: {
                [MemoryGroupStatusForAllFloating.notStarted]: () => notStart(),
              },
              orElse: null,
            ),
      },
      orElse: null,
    );
  }
}