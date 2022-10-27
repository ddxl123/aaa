import 'package:aaa/algorithm_parser/parser.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';

class InAppStageAbController extends AbController {
  InAppStageAbController({required this.memoryGroupGizmo});

  final Ab<MemoryGroup> memoryGroupGizmo;

  late final Ab<MemoryModel> memoryModelGizmo;

  final performerQuery = PerformerQuery();

  /// [PerformerQuery.getNewPerformer]
  final fragmentAndMemoryInfos = Ab<Tuple2<Fragment, List<FragmentMemoryInfo>>?>(null);

  final storage = InternalVariableStorage().ab;

  final buttonDataState = Ab<ButtonDataState?>(null);

  /// 若为 true，则展示按钮数据值；
  /// 若为 false，则表示按钮天数值。
  final isButtonDataShowValue = false.ab;

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
    await _init();
  }

  Future<void> _init() async {
    final mm = await DriftDb.instance.generalQueryDAO.queryMemoryModelById(memoryModelId: memoryGroupGizmo().memoryModelId);
    memoryModelGizmo = mm!.ab;
    await _perform();
  }

  /// 点击数值按钮后进行调用。
  ///
  /// 完成当前表演，并进行下一次表演。
  Future<void> finishAndStartNextPerform() async {
    await withRefs(
      syncTag: null,
      ref: (SyncTag syncTag) async {
        return RefFragmentMemoryInfos(
          self: ($FragmentMemoryInfosTable table) async {
          },
        );
      },
    );
  }

  /// 获取新舞者并执行表演。
  Future<void> _perform() async {
    final dancer = await performerQuery.getNewPerformer(mg: memoryGroupGizmo());
    fragmentAndMemoryInfos.refreshInevitable((obj) => dancer);
    if (fragmentAndMemoryInfos() == null) return;

    await _parse();
  }

  Future<void> _parse() async {
    final currentShowFamiliar = await _parseFamiliarity();
    final pbd = await _parseButtonData(currentShowFamiliar: currentShowFamiliar);
    if (pbd.resultMin != null) {
      await _parseNextShowTime(currentShowFamiliar: currentShowFamiliar, buttonDataValue2NextShowTime: pbd.resultMin!);
    }
    if (pbd.resultMax != null) {
      await _parseNextShowTime(currentShowFamiliar: currentShowFamiliar, buttonDataValue2NextShowTime: pbd.resultMax!);
    }
    for (var element in pbd.resultButtonValues) {
      await _parseNextShowTime(currentShowFamiliar: currentShowFamiliar, buttonDataValue2NextShowTime: element);
    }

    buttonDataState.refreshEasy((oldValue) => pbd);
  }

  /// 解析出当前展示熟练度。
  Future<double> _parseFamiliarity() async {
    final currentFamiliarity = await AlgorithmParser<FamiliarityState>().parse(
      state: FamiliarityState(
        useContent: memoryModelGizmo().familiarityAlgorithm,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: storage(),
            countAllIF: IvFilter(
              ivf: () async => await performerQuery.getCountAll(mg: memoryGroupGizmo()),
              isReGet: false,
            ),
            countNewIF: IvFilter(
              ivf: () async => await performerQuery.getCountNew(mg: memoryGroupGizmo()),
              isReGet: false,
            ),
            timesIF: IvFilter(
              ivf: () async => await performerQuery.getTimes(tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            currentActualShowTimeIF: IvFilter(
              ivf: () async => await performerQuery.getCurrentActualShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            currentPlanedShowTimeIF: IvFilter(
              ivf: () async => await performerQuery.getCurrentPlanedShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            showFamiliarIF: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliar(tuple: fragmentAndMemoryInfos()!, currentShowFamiliar: null),
              isReGet: false,
            ),
            clickTimeIF: IvFilter(
              ivf: () async => await performerQuery.getClickTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!, isCreateNow: false),
              isReGet: false,
            ),
            clickValueIF: IvFilter(
              ivf: () async => await performerQuery.getClickValue(tuple: fragmentAndMemoryInfos()!, clickValue: null),
              isReGet: false,
            ),
          );
        },
      ),
    );
    return currentFamiliarity.state.result;
  }

  /// 解析按钮的数值数据。
  Future<ButtonDataState> _parseButtonData({required double currentShowFamiliar}) async {
    return (await AlgorithmParser<ButtonDataState>().parse(
      state: ButtonDataState(
        useContent: memoryModelGizmo().buttonAlgorithm,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: storage(),
            countAllIF: IvFilter(
              ivf: () async => await performerQuery.getCountAll(mg: memoryGroupGizmo()),
              isReGet: false,
            ),
            countNewIF: IvFilter(
              ivf: () async => await performerQuery.getCountNew(mg: memoryGroupGizmo()),
              isReGet: false,
            ),
            timesIF: IvFilter(
              ivf: () async => await performerQuery.getTimes(tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            currentActualShowTimeIF: IvFilter(
              ivf: () async => await performerQuery.getCurrentActualShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            currentPlanedShowTimeIF: IvFilter(
              ivf: () async => await performerQuery.getCurrentPlanedShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            showFamiliarIF: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliar(tuple: fragmentAndMemoryInfos()!, currentShowFamiliar: currentShowFamiliar),
              isReGet: true,
            ),
            clickTimeIF: IvFilter(
              ivf: () async => await performerQuery.getClickTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!, isCreateNow: false),
              isReGet: false,
            ),
            clickValueIF: IvFilter(
              ivf: () async => await performerQuery.getClickValue(tuple: fragmentAndMemoryInfos()!, clickValue: null),
              isReGet: false,
            ),
          );
        },
      ),
    ))
        .state;
  }

  /// 解析每个按钮的下一次展示时间。
  Future<void> _parseNextShowTime({required double currentShowFamiliar, required ButtonDataValue2NextShowTime buttonDataValue2NextShowTime}) async {
    final r = await AlgorithmParser<NextShowTimeState>().parse(
      state: NextShowTimeState(
        useContent: memoryModelGizmo().nextTimeAlgorithm,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: InternalVariableStorage(),
            countAllIF: IvFilter(
              ivf: () async => await performerQuery.getCountAll(mg: memoryGroupGizmo()),
              isReGet: false,
            ),
            countNewIF: IvFilter(
              ivf: () async => await performerQuery.getCountNew(mg: memoryGroupGizmo()),
              isReGet: false,
            ),
            timesIF: IvFilter(ivf: () async => await performerQuery.getTimes(tuple: fragmentAndMemoryInfos()!), isReGet: false),
            currentActualShowTimeIF: IvFilter(
              ivf: () async => await performerQuery.getCurrentActualShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            currentPlanedShowTimeIF: IvFilter(
              ivf: () async => await performerQuery.getCurrentPlanedShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            showFamiliarIF: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliar(tuple: fragmentAndMemoryInfos()!, currentShowFamiliar: currentShowFamiliar),
              isReGet: false,
            ),
            clickTimeIF: IvFilter(
              ivf: () async => await performerQuery.getClickTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!, isCreateNow: true),
              isReGet: true,
            ),
            clickValueIF: IvFilter(
              ivf: () async => await performerQuery.getClickValue(tuple: fragmentAndMemoryInfos()!, clickValue: buttonDataValue2NextShowTime.value),
              isReGet: true,
            ),
          );
        },
      ),
    );
    buttonDataValue2NextShowTime.time = r.state.result;
  }
}
