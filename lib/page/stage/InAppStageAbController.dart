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
  ///
  /// [FragmentMemoryInfo] 为当前碎片的最近一次的碎片信息。
  final fragmentAndEarliestMemoryInfo = Ab<Tuple2<Fragment, FragmentMemoryInfo?>?>(null);

  final internalVariableStorage = InternalVariableStorage().ab;

  late final ivgCountAllIF = IvFilter(ivf: () async => await dancerQueryDAO.getCountAll(mg: memoryGroupGizmo()), isCoverResult: false);

  late final ivsCountNewIF = IvFilter(ivf: () async => await dancerQueryDAO.getCountNew(mg: memoryGroupGizmo()), isCoverResult: false);

  late final ivsTimesIF = IvFilter(
    ivf: () async => await dancerQueryDAO.getTimes(mg: memoryGroupGizmo(), tuple: fragmentAndEarliestMemoryInfo()!),
    isCoverResult: false,
  );
  late final ivsActualShowTimeIF = IvFilter(
    ivf: () async => dancerQueryDAO.getActualShowTime(mg: memoryGroupGizmo()),
    isCoverResult: false,
  );

  late final ivsPlanedShowTimeIF = IvFilter(
    ivf: () async => dancerQueryDAO.getPlanedShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndEarliestMemoryInfo()!),
    isCoverResult: false,
  );

  // 如果 parseFamiliarity 已经存在结果值，并不会再次执行。
  // late final ivsShowFamiliarIF = IvFilter(
  //   isCover: false,
  //   ivf: parseFamiliarity,
  // );

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
    fragmentAndEarliestMemoryInfo.refreshInevitable((obj) => dancer);
    if (fragmentAndEarliestMemoryInfo() == null) return;

    await parseButtonData();
  }

  Future<void> parseButtonData() async {
    // await AlgorithmParser().parse(
    //   state: ButtonDataState(
    //     content: memoryModelGizmo().buttonAlgorithm,
    //     simulationType: SimulationType.external,
    //     externalResultHandler: (InternalVariable internalVariable, NType? nType, int? number) async {
    //       return await internalVariableStorage().filterStorage(
    //         iv: internalVariable,
    //         nType: nType,
    //         number: number,
    //         ivgCountAllIF: ivgCountAllIF,
    //         ivsCountNewIF: ivsCountNewIF,
    //         ivsTimesIF: ivsTimesIF,
    //         ivsActualShowTimeIF: ivsActualShowTimeIF,
    //         ivsPlanedShowTimeIF: ivsPlanedShowTimeIF,
    //         ivsShowFamiliarIF: ivsShowFamiliarIF,
    //         ivcClickTimeIF: ivcClickTime,
    //         ivcClickValueIF: ivcClickValue,
    //       );
    //     },
    //   ),
    // );
  }

  Future<double?> parseFamiliarity() async {
    final result = await AlgorithmParser<FamiliarityState>().parse(
      state: FamiliarityState(
        content: memoryModelGizmo().familiarityAlgorithm,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableConst internalVariable, NType? nType, int? number) async {
          return await internalVariableStorage().filterStorage(iv: internalVariable,
              nType: nType,
              number: number,
              ivgCountAllIF: ivgCountAllIF,
              ivsCountNewIF: ivsCountNewIF,
              ivsTimesIF: ivsTimesIF,
              ivsActualShowTimeIF: ivsActualShowTimeIF,
              ivsPlanedShowTimeIF: ivsPlanedShowTimeIF,
              ivsShowFamiliarIF: ivsShowFamiliarIF,
              ivcClickTimeIF: ivcClickTimeIF,
              ivcClickValueIF: ivcClickValueIF)
        },
      ),
    );

    internalVariableStorage().showFamiliar = result.state.result;
    return result.state.result;
  }
}
