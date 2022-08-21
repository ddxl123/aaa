import 'package:aaa/tool/aber/Aber.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class InAppStageAbController extends AbController {
  InAppStageAbController({required this.memoryGroupGizmo});

  final Ab<MemoryGroup> memoryGroupGizmo;

  final currentFragmentAndMemoryInfo = Ab<Tuple2<Fragment, FragmentMemoryInfo?>?>(null);

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    await Future.delayed(const Duration(seconds: 2));
    final dancer = await DriftDb.instance.singleDAO.queryFragmentsForDancer(mg: memoryGroupGizmo());
    currentFragmentAndMemoryInfo.refreshInevitable((obj) => dancer);
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
