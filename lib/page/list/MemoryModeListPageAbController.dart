import 'package:drift_main/DriftDb.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPageAbController.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryModeListPageAbController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final memoryModels = <Ab<MemoryModel>>[].ab;

  final selected = Ab<MemoryModel?>(null);

  @override
  void onInit() {
    selected.refreshEasy((oldValue) => Aber.findOrNullLast<MemoryGroupGizmoEditPageAbController>()?.selectedMemoryModel() ?? oldValue);
  }

  Future<void> addMemoryModel(MemoryModelsCompanion willEntity) async {
    final newEntity = await DriftDb.instance.insertDAO.insertMemoryModel(willEntity);
    memoryModels.refreshInevitable((obj) => obj..add(newEntity.ab));
  }

  Future<void> refreshMemoryModels() async {
    final mgs = (await DriftDb.instance.generalQueryDAO.queryAllMemoryModels()).map((e) => e.ab);
    memoryModels().clear_(this);
    memoryModels.refreshInevitable((obj) => obj..addAll(mgs));
  }

  void selectMemoryModel(MemoryModel memoryModel) {
    if (selected() == memoryModel) {
      selected.refreshInevitable((obj) => null);
    } else {
      selected.refreshInevitable((obj) => memoryModel);
    }
  }

  void confirmSelect() {
    Aber.findOrNullLast<MemoryGroupGizmoEditPageAbController>()?.selectedMemoryModel.refreshInevitable((obj) => selected());
    Navigator.pop(context);
  }
}
