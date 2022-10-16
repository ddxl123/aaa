import 'package:aaa/algorithm_parser/parser.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';

class InAppStageAbController extends AbController {
  InAppStageAbController({required this.memoryGroupGizmo});

  final Ab<MemoryGroup> memoryGroupGizmo;

  late final Ab<MemoryModel> memoryModelGizmo;

  final dancerQuery = DancerQuery();

  /// [DancerQuery.getNewDancer]
  final fragmentAndMemoryInfos = Ab<Tuple2<Fragment, List<FragmentMemoryInfo>>?>(null);

  final storage = InternalVariableStorage().ab;

  final buttonDataState = Ab<ButtonDataState?>(null);

  /// 若为 true，则展示按钮数据值；
  /// 若为 false，则表示按钮天数值。
  final isButtonDataShowValue = true.ab;

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
    final dancer = await dancerQuery.getNewDancer(mg: memoryGroupGizmo());
    fragmentAndMemoryInfos.refreshInevitable((obj) => dancer);
    print(fragmentAndMemoryInfos());
    if (fragmentAndMemoryInfos() == null) return;

    await parse();
  }

  Future<void> parse() async {
    final currentShowFamiliar = await parseFamiliarity();
    final pbd = await parseButtonData(currentShowFamiliar: currentShowFamiliar);

    if (pbd.resultMin != null) {
      await parseNextShowTime(currentShowFamiliar: currentShowFamiliar, buttonDataValue2NextShowTime: pbd.resultMin!);
    }
    if (pbd.resultMax != null) {
      await parseNextShowTime(currentShowFamiliar: currentShowFamiliar, buttonDataValue2NextShowTime: pbd.resultMax!);
    }
    for (var element in pbd.resultButtonValues) {
      await parseNextShowTime(currentShowFamiliar: currentShowFamiliar, buttonDataValue2NextShowTime: element);
    }

    buttonDataState.refreshEasy((oldValue) => pbd);
  }

  Future<double> parseFamiliarity() async {
    final currentFamiliarity = await AlgorithmParser<FamiliarityState>().parse(
      state: FamiliarityState(
        content: memoryModelGizmo().familiarityAlgorithm,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: storage(),
            countAllIF: IvFilter(
              ivf: () async => await dancerQuery.getCountAll(mg: memoryGroupGizmo()),
              isReGet: false,
            ),
            countNewIF: IvFilter(
              ivf: () async => await dancerQuery.getCountNew(mg: memoryGroupGizmo()),
              isReGet: false,
            ),
            timesIF: IvFilter(
              ivf: () async => await dancerQuery.getTimes(tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            currentActualShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getCurrentActualShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            currentPlanedShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getCurrentPlanedShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            showFamiliarIF: IvFilter(
              ivf: () async => await dancerQuery.getShowFamiliar(tuple: fragmentAndMemoryInfos()!, currentShowFamiliar: null),
              isReGet: false,
            ),
            clickTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getClickTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!, isCreateNow: false),
              isReGet: false,
            ),
            clickValueIF: IvFilter(
              ivf: () async => await dancerQuery.getClickValue(tuple: fragmentAndMemoryInfos()!, clickValue: null),
              isReGet: false,
            ),
          );
        },
      ),
    );
    return currentFamiliarity.state.result;
  }

  Future<ButtonDataState> parseButtonData({required double currentShowFamiliar}) async {
    return (await AlgorithmParser<ButtonDataState>().parse(
      state: ButtonDataState(
        content: memoryModelGizmo().buttonAlgorithm,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: storage(),
            countAllIF: IvFilter(
              ivf: () async => await dancerQuery.getCountAll(mg: memoryGroupGizmo()),
              isReGet: false,
            ),
            countNewIF: IvFilter(
              ivf: () async => await dancerQuery.getCountNew(mg: memoryGroupGizmo()),
              isReGet: false,
            ),
            timesIF: IvFilter(
              ivf: () async => await dancerQuery.getTimes(tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            currentActualShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getCurrentActualShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            currentPlanedShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getCurrentPlanedShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            showFamiliarIF: IvFilter(
              ivf: () async => await dancerQuery.getShowFamiliar(tuple: fragmentAndMemoryInfos()!, currentShowFamiliar: currentShowFamiliar),
              isReGet: true,
            ),
            clickTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getClickTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!, isCreateNow: false),
              isReGet: false,
            ),
            clickValueIF: IvFilter(
              ivf: () async => await dancerQuery.getClickValue(tuple: fragmentAndMemoryInfos()!, clickValue: null),
              isReGet: false,
            ),
          );
        },
      ),
    ))
        .state;
  }

  Future<void> parseNextShowTime({required double currentShowFamiliar, required ButtonDataValue2NextShowTime buttonDataValue2NextShowTime}) async {
    final r = await AlgorithmParser<NextShowTimeState>().parse(
      state: NextShowTimeState(
        content: memoryModelGizmo().nextTimeAlgorithm,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          await atom.filter(
            storage: storage(),
            countAllIF: IvFilter(
              ivf: () async => await dancerQuery.getCountAll(mg: memoryGroupGizmo()),
              isReGet: false,
            ),
            countNewIF: IvFilter(
              ivf: () async => await dancerQuery.getCountNew(mg: memoryGroupGizmo()),
              isReGet: false,
            ),
            timesIF: IvFilter(ivf: () async => await dancerQuery.getTimes(tuple: fragmentAndMemoryInfos()!), isReGet: false),
            currentActualShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getCurrentActualShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            currentPlanedShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getCurrentPlanedShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            showFamiliarIF: IvFilter(
              ivf: () async => await dancerQuery.getShowFamiliar(tuple: fragmentAndMemoryInfos()!, currentShowFamiliar: currentShowFamiliar),
              isReGet: false,
            ),
            clickTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getClickTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!, isCreateNow: true),
              isReGet: true,
            ),
            clickValueIF: IvFilter(
              ivf: () async => await dancerQuery.getClickValue(tuple: fragmentAndMemoryInfos()!, clickValue: buttonDataValue2NextShowTime.value),
              isReGet: true,
            ),
          );
        },
      ),
    );
    buttonDataValue2NextShowTime.time = r.state.result;
  }
}
