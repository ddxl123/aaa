import 'package:drift_main/DriftDb.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPage.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
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
    filter(
      from: memoryGroupGizmo().type,
      targets: {
        [MemoryGroupType.inApp]: () => filter(
              from: memoryGroupGizmo().status,
              targets: {
                [MemoryGroupStatus.notInit]: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MemoryGroupGizmoEditPage(
                        editPageType: MemoryGroupGizmoEditPageType.initCheck,
                        memoryGroupGizmo: memoryGroupGizmo,
                      ),
                    ),
                  );
                },
                [MemoryGroupStatus.notStart]: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MemoryGroupGizmoEditPage(
                        editPageType: MemoryGroupGizmoEditPageType.modifyOtherCheck,
                        memoryGroupGizmo: memoryGroupGizmo,
                      ),
                    ),
                  );
                },
              },
              orElse: null,
            ),
      },
      orElse: null,
    );
  }
}
