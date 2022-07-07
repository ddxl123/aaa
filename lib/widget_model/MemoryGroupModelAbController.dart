import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/page/create/CreateModifyMemoryGroupPage.dart';
import 'package:aaa/page/create/CreateOrModifyType.dart';
import 'package:aaa/tool/Helper.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BasicSingleOuterMemoryGroup {
  BasicSingleOuterMemoryGroup({required this.memoryGroup});

  final Ab<MemoryGroup> memoryGroup;
}

class SingleOuterNormalMemoryGroup extends BasicSingleOuterMemoryGroup {
  SingleOuterNormalMemoryGroup({required Ab<MemoryGroup> memoryGroup}) : super(memoryGroup: memoryGroup);
}

class SingleOuterFullFloatingMemoryGroup extends BasicSingleOuterMemoryGroup {
  SingleOuterFullFloatingMemoryGroup({required Ab<MemoryGroup> memoryGroup}) : super(memoryGroup: memoryGroup);
}

class MemoryGroupModelAbController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final normalMemoryGroups = <Ab<SingleOuterNormalMemoryGroup>>[].ab;
  final fullFloatingMemoryGroups = <Ab<SingleOuterFullFloatingMemoryGroup>>[].ab;

  Future<void> refreshPage() async {
    final mgs = await DriftDb.instance.singleDAO.queryMemoryGroups();
    normalMemoryGroups.clear_(this);
    fullFloatingMemoryGroups.clear_(this);
    for (var value in mgs) {
      if (value.type == MemoryGroupType.normal) {
        normalMemoryGroups.refreshInevitable((obj) => obj..add(SingleOuterNormalMemoryGroup(memoryGroup: value.ab).ab));
      } else if (value.type == MemoryGroupType.fullFloating) {
        fullFloatingMemoryGroups.refreshInevitable((obj) => obj..add(SingleOuterFullFloatingMemoryGroup(memoryGroup: value.ab).ab));
      }
    }
  }

  Future<void> onStatusTap(Ab<BasicSingleOuterMemoryGroup> nmg) async {
    final mg = nmg().memoryGroup();
    void notStart() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CreateModifyMemoryGroupPage(createOrModifyType: CreateModifyCheckType.modifyCheck)),
      );
    }

    Helper.filter(
      from: mg.type,
      targets: {
        [MemoryGroupType.normal]: () => Helper.filter(
              from: mg.normalStatus,
              targets: {
                [MemoryGroupStatusForNormal.notStart]: () => notStart(),
              },
              orElse: null,
            ),
        [MemoryGroupType.fullFloating]: () => Helper.filter(
              from: mg.fullFloatingStatus,
              targets: {
                [MemoryGroupStatusForFullFloating.notStarted]: () => notStart(),
              },
              orElse: null,
            ),
      },
      orElse: null,
    );
  }
}
