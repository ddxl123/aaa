import 'package:tools/tools.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class InAppStageAbController extends AbController {
  InAppStageAbController({required this.memoryGroupGizmo});

  final Ab<MemoryGroup> memoryGroupGizmo;

  /// 为 null 时表示已完成学习。
  final currentFragmentAndMemoryInfo = Ab<Tuple2<Fragment, FragmentMemoryInfo?>?>(null);

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final dancer = await DriftDb.instance.queryDAO.queryFragmentsForDancer(mg: memoryGroupGizmo());
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
