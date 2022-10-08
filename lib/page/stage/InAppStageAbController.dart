import 'package:aaa/algorithm_parser/parser.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';

class InAppStageAbController extends AbController {
  InAppStageAbController({required this.memoryGroupGizmo});

  final Ab<MemoryGroup> memoryGroupGizmo;

  late final Ab<MemoryModel> memoryModelGizmo;

  final dancerQueryDAO = DriftDb.instance.dancerQueryDAO;

  /// 为 null 时表示已完成学习。
  final currentFragmentAndMemoryInfo = Ab<Tuple2<Fragment, FragmentMemoryInfo?>?>(null);

  @override
  bool get isEnableLoading => true;

  @override
  Widget loadingWidget() {
    return const Material(
      child: Center(
        child: Text('加载中...'),
      ),
    );
  }

  @override
  Future<void> loadingFuture() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final mm = await DriftDb.instance.generalQueryDAO.queryMemoryModelById(memoryModelId: memoryGroupGizmo().memoryModelId);
    memoryModelGizmo = mm!.ab;

    await show();
  }

  Future<void> show() async {
    final dancer = await dancerQueryDAO.getDancer(mg: memoryGroupGizmo());
    currentFragmentAndMemoryInfo.refreshInevitable((obj) => dancer);
    if (currentFragmentAndMemoryInfo() == null) return;

    await parseButtonData();
  }

  Future<void> parseButtonData() async {
    await AlgorithmParser().parse(
      state: ButtonDataState(
        content: memoryModelGizmo().buttonAlgorithm,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariable internalVariable, NType? nType, int? number) async {
          return await InternalVariable.filter(
            iv: internalVariable,
            nType: nType,
            number: number,
            ivgCountAll: () async => await dancerQueryDAO.getCountAll(mg: memoryGroupGizmo()),
            ivsCountNew: () async => await dancerQueryDAO.getCountNew(mg: memoryGroupGizmo()),
            ivsTimes: () async => await dancerQueryDAO.getTimes(mg: memoryGroupGizmo(), tuple: currentFragmentAndMemoryInfo()!),
            ivsActualShowTime: () async => dancerQueryDAO.getActualShowTime(mg: memoryGroupGizmo()),
            ivsPlanedShowTime: ivsPlanedShowTime,
            ivsShowFamiliar: ivsShowFamiliar,
            ivcClickTime: ivcClickTime,
            ivcClickValue: ivcClickValue,
          );
        },
      ),
    );
  }
}
