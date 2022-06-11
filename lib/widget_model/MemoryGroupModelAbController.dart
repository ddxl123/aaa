import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryGroupModelAbController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final memoryGroups = <Ab<MemoryGroup>>[].ab;


  Future<void> addMemoryGroup(MemoryGroupsCompanion willEntity) async {
    final newEntity = await DriftDb.instance.singleDAO.insertMemoryGroup(willEntity);
    memoryGroups.refreshInevitable((obj) => obj..add(newEntity.ab));
  }

  Future<void> refreshMemoryGroups() async {
    final mgs = (await DriftDb.instance.singleDAO.queryMemoryGroups()).map((e) => e.ab);
    memoryGroups().clear_(this);
    memoryGroups.refreshInevitable((obj) => obj..addAll(mgs));
  }
}
