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
    final currentFamiliarity = await parseFamiliarity();
    await parseButtonData(currentFamiliarity: currentFamiliarity);
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
              isReGet: true,
            ),
            countNewIF: IvFilter(
              ivf: () async => await dancerQuery.getCountNew(mg: memoryGroupGizmo()),
              isReGet: true,
            ),
            timesIF: IvFilter(
              ivf: () async => await dancerQuery.getTimes(tuple: fragmentAndMemoryInfos()!),
              isReGet: true,
            ),
            actualShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getCurrentActualShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: true,
            ),
            planedShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getCurrentPlanedShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: true,
            ),
            showFamiliarIF: IvFilter(
              ivf: () async => await dancerQuery.getShowFamiliar(tuple: fragmentAndMemoryInfos()!, currentShowFamiliar: null),
              isReGet: true,
            ),
            clickTimeIF: IvFilter(
              ivf: () async => [null],
              isReGet: true,
            ),
            clickValueIF: IvFilter(
              ivf: () async => [null],
              isReGet: true,
            ),
          );
        },
      ),
    );
    return currentFamiliarity.state.result;
  }

  Future<void> parseButtonData({required double currentFamiliarity}) async {
    await AlgorithmParser().parse(
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
            actualShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getCurrentActualShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            planedShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getCurrentPlanedShowTime(mg: memoryGroupGizmo(), tuple: fragmentAndMemoryInfos()!),
              isReGet: false,
            ),
            showFamiliarIF: IvFilter(
              ivf: () async => await dancerQuery.getShowFamiliar(tuple: fragmentAndMemoryInfos()!, currentShowFamiliar: currentFamiliarity),
              isReGet: true,
            ),
            clickTimeIF: IvFilter(
              ivf: () async => [null],
              isReGet: false,
            ),
            clickValueIF: IvFilter(
              ivf: () async => [null],
              isReGet: false,
            ),
          );
        },
      ),
    );
  }
}
