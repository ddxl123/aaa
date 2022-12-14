import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../edit/MemoryGroupGizmoEditPage/MemoryGroupGizmoEditPageAbController.dart';

class MemoryModeListPageAbController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final memoryModels = <Ab<MemoryModel>>[].ab;

  @override
  void onDispose() {
    refreshController.dispose();
    super.onDispose();
  }

  // Future<void> addMemoryModel({required MemoryModelsCompanion memoryModelsCompanion}) async {
  //   final newEntity = await DriftDb.instance.insertDAO.insertMemoryModel(memoryModelsCompanion: memoryModelsCompanion);
  //   memoryModels.refreshInevitable((obj) => obj..add(newEntity.ab));
  // }

  Future<void> refreshMemoryModels() async {
    final mgs = (await DriftDb.instance.generalQueryDAO.queryMemoryModels()).map((e) => e.ab);
    memoryModels().clearBroken(this);
    memoryModels.refreshInevitable((obj) => obj..addAll(mgs));
  }

  void confirmSelect() {
    // Aber.findOrNullLast<MemoryGroupGizmoEditPageAbController>()?.bSelectedMemoryModel.abObj.refreshInevitable((obj) => selected());
    Navigator.pop(context);
  }
}
