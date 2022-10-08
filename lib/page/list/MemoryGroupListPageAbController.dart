import 'package:drift_main/DriftDb.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPage.dart';
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
                [MemoryGroupStatus.notStart]: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MemoryGroupGizmoEditPage(
                        editPageType: MemoryGroupGizmoEditPageType.modify,
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
