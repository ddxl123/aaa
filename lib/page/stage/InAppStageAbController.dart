import 'package:aaa/tool/aber/Aber.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';

class InAppStageAbController extends AbController {
  InAppStageAbController({required this.memoryGroupGizmo});

  final Ab<MemoryGroup> memoryGroupGizmo;

  final Ab<Fragment?> currentFragment = null.ab;

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    await Future.delayed(const Duration(seconds: 2));
    // final dancer = await DriftDb.instance.singleDAO.queryFragmentsForDancer(mg: memoryGroupGizmo());
    // currentFragment.refreshEasy((oldValue) => dancer);
  }

  @override
  Widget loadingWidget() {
    return const Material(
      child: Center(
        child: Text('加载中...'),
      ),
    );
  }
}
