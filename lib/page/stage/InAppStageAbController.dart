import 'package:aaa/algorithm_parser/parser.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';

class InAppStageAbController extends AbController {
  InAppStageAbController({required this.memoryGroupGizmo});

  final Ab<MemoryGroup> memoryGroupGizmo;

  late final Ab<MemoryModel> memoryModelGizmo;

  final dancerQuery = DancerQuery();

  /// 为 null 时表示已完成学习。
  ///
  /// [FragmentMemoryInfo] 为当前碎片的最近一次的碎片信息。
  final fragmentAndEarliestMemoryInfo = Ab<Tuple2<Fragment, FragmentMemoryInfo?>?>(null);

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
    final dancer = await dancerQuery.getDancer(mg: memoryGroupGizmo());
    fragmentAndEarliestMemoryInfo.refreshInevitable((obj) => dancer);
    if (fragmentAndEarliestMemoryInfo() == null) return;

    await parseButtonData();
  }

  Future<void> parseButtonData() async {
    await AlgorithmParser().parse(
      state: ButtonDataState(
        content: memoryModelGizmo().buttonAlgorithm,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: storage(),
            countAllIF: IvFilter(
              ivf: () async => await dancerQuery.getCountAll(nTypeNumber: atom.nTypeNumber, mg: memoryGroupGizmo()),
              isCover: false,
            ),
            countNewIF: IvFilter(
              ivf: () async => await dancerQuery.getCountNew(nTypeNumber: atom.nTypeNumber, mg: memoryGroupGizmo()),
              isCover: false,
            ),
            timesIF: IvFilter(
              ivf: () async => await dancerQuery.getTimes(nTypeNumber: atom.nTypeNumber, mg: memoryGroupGizmo(), tuple: fragmentAndEarliestMemoryInfo()!),
              isCover: false,
            ),
            actualShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getActualShowTime(nTypeNumber: atom.nTypeNumber, mg: memoryGroupGizmo()),
              isCover: false,
            ),
            planedShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getPlanedShowTime(nTypeNumber: atom.nTypeNumber, mg: memoryGroupGizmo(), tuple: fragmentAndEarliestMemoryInfo()!),
              isCover: false,
            ),
            showFamiliarIF: IvFilter(
              ivf: () async => await parseCurrentFamiliarity(),
              isCover: false,
            ),
            clickTimeIF: IvFilter(
              ivf: () async => null,
              isCover: false,
            ),
            clickValueIF: IvFilter(
              ivf: () async => null,
              isCover: false,
            ),
          );
        },
      ),
    );
  }

  Future<double?> parseCurrentFamiliarity() async {
    final result = await AlgorithmParser<FamiliarityState>().parse(
      state: FamiliarityState(
        content: memoryModelGizmo().familiarityAlgorithm,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: storage(),
            countAllIF: IvFilter(
              ivf: () async => await dancerQuery.getCountAll(nTypeNumber: atom.nTypeNumber, mg: memoryGroupGizmo()),
              isCover: true,
            ),
            countNewIF: IvFilter(
              ivf: () async => await dancerQuery.getCountNew(nTypeNumber: atom.nTypeNumber, mg: memoryGroupGizmo()),
              isCover: true,
            ),
            timesIF: IvFilter(
              ivf: () async => await dancerQuery.getTimes(nTypeNumber: atom.nTypeNumber, mg: memoryGroupGizmo(), tuple: fragmentAndEarliestMemoryInfo()!),
              isCover: true,
            ),
            actualShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getActualShowTime(nTypeNumber: atom.nTypeNumber, mg: memoryGroupGizmo()),
              isCover: true,
            ),
            planedShowTimeIF: IvFilter(
              ivf: () async => await dancerQuery.getPlanedShowTime(nTypeNumber: atom.nTypeNumber, mg: memoryGroupGizmo(), tuple: fragmentAndEarliestMemoryInfo()!),
              isCover: true,
            ),
            showFamiliarIF: IvFilter(
              ivf: () async => await dancerQuery.getShowFamiliar(nTypeNumber: atom.nTypeNumber, mg: memoryGroupGizmo(), mm: memoryModelGizmo()),
              isCover: false,
            ),
            clickTimeIF: IvFilter(
              ivf: () async => null,
              isCover: false,
            ),
            clickValueIF: IvFilter(
              ivf: () async => null,
              isCover: false,
            ),
          );
        },
      ),
    );
    return result.state.result;
  }
}
