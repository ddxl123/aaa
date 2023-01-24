import 'dart:convert';

import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPage/MemoryGroupGizmoEditPageAbController.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';

import 'PerformerDAO.dart';

class Performer {
  final Fragment fragment;
  final FragmentMemoryInfo fragmentMemoryInfo;

  Performer({
    required this.fragment,
    required this.fragmentMemoryInfo,
  });
}

class InAppStageAbController extends AbController {
  InAppStageAbController({required this.memoryGroupAb});

  final Ab<MemoryGroup> memoryGroupAb;

  late final Ab<MemoryModel> memoryModelAb;

  final performerQuery = PerformerQuery();

  final quillController = q.QuillController.basic();

  /// 若为 true，则展示按钮数据值；
  /// 若为 false，则表示按钮天数值。
  final isButtonDataShowValue = false.ab;

  /// 每展示碎片时都会被重置。
  /// [PerformerQuery.getNewPerformer]
  final currentPerformer = Ab<Performer?>(null);

  /// 每展示碎片时都会被重置。
  int? currentActualShowTime;

  /// 每展示碎片时都会被重置。
  double? currentShowFamiliar;

  /// 每展示碎片时都会被重置。
  final currentButtonDataState = Ab<ButtonDataState?>(null);

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
    final mm = await db.generalQueryDAO.queryMemoryModelInMemoryGroup(memoryGroup: memoryGroupAb());
    memoryModelAb = mm!.ab;

    await _next();
  }

  /// 仅获取下一个 [Performer]。
  Future<void> _next() async {
    final performer = await performerQuery.getNewPerformer(mg: memoryGroupAb());
    currentPerformer.refreshInevitable((obj) => performer);
    // 说明没有下一个了。
    if (currentPerformer() == null) return;

    // 必须按照顺序进行获取，否则要么没有对应的值，要么可能会使用上一次的值。
    currentActualShowTime = timeDifference(target: DateTime.now(), start: memoryGroupAb().start_time!);
    currentShowFamiliar = await _parseCurrentFamiliarity();

    final pbd = await _parseButtonData();
    if (pbd.resultMin != null) {
      await _parseNextShowTime(buttonDataValue2NextShowTime: pbd.resultMin!);
    }
    if (pbd.resultMax != null) {
      await _parseNextShowTime(buttonDataValue2NextShowTime: pbd.resultMax!);
    }
    for (var element in pbd.resultButtonValues) {
      await _parseNextShowTime(buttonDataValue2NextShowTime: element);
    }

    quillController.document = q.Document.fromJson(jsonDecode(currentPerformer()!.fragment.content));
    currentButtonDataState.refreshEasy((oldValue) => pbd);
  }

  /// 仅完成当前表演。
  ///
  /// 点击数值按钮后进行调用。
  Future<void> _finish({required double clickValue}) async {
    if (currentPerformer() == null) {
      throw '没有下一个碎片了，却仍然请求了下一个碎片！';
    }

    final buttonDataValue2NextShowTime = ButtonDataValue2NextShowTime(value: clickValue);
    await _parseNextShowTime(buttonDataValue2NextShowTime: buttonDataValue2NextShowTime);

    final info = currentPerformer()!.fragmentMemoryInfo;

    final isNew = info.next_plan_show_time == null ? true : false;
    await performerQuery.finish(
      originalFragmentMemoryInfoReset: (SyncTag resetSyncTag) async {
        return await currentPerformer()!.fragmentMemoryInfo.reset(
              creator_user_id: toAbsent(),
              fragment_id: toAbsent(),
              memory_group_id: toAbsent(),
              click_time: (info.click_time ?? '[]').arrayAdd(timeDifference(target: DateTime.now(), start: memoryGroupAb().start_time!)).toValue(),
              click_value: (info.click_value ?? '[]').arrayAdd(clickValue).toValue(),
              current_actual_show_time: (info.current_actual_show_time ?? '[]').arrayAdd(currentActualShowTime).toValue(),
              next_plan_show_time: (info.next_plan_show_time ?? '[]').arrayAdd(buttonDataValue2NextShowTime.nextShowTime).toValue(),
              show_familiarity: (info.show_familiarity ?? '[]').arrayAdd(currentShowFamiliar).toValue(),
              syncTag: resetSyncTag,
            );
      },
      originalMemoryGroup: memoryGroupAb(),
      isNew: isNew,
      syncTag: null,
    );
    currentShowFamiliar = null;
    currentActualShowTime = null;
    currentButtonDataState.refreshEasy((oldValue) => null);
    currentPerformer.refreshEasy((oldValue) => null);
    if (isNew) {
      Aber.findOrNull<MemoryGroupGizmoEditPageAbController>()?.cWillNewLearnCountStorage.abValue.refreshEasy((oldValue) => oldValue - 1);
    }
    memoryGroupAb.refreshForce();
  }

  /// 完成当前表演，并进行下一次表演。
  Future<void> finishAndNext({required double clickValue}) async {
    await _finish(clickValue: clickValue);
    await _next();
  }

  /// 解析出当前展示熟练度。
  Future<double> _parseCurrentFamiliarity() async {
    final currentFamiliarity = await AlgorithmParser<FamiliarityState>().parse(
      state: FamiliarityState(
        useContent: memoryModelAb().familiarity_algorithm,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: InternalVariableStorage(),
            countAllIF: IvFilter(
              ivf: () async => await performerQuery.getCountAll(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            countNewIF: IvFilter(
              ivf: () async => await performerQuery.getCountNew(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            timesIF: IvFilter(
              ivf: () async => await performerQuery.getTimes(performer: currentPerformer()!),
              isReGet: false,
            ),
            currentActualShowTimeIF: IvFilter(
              ivf: () async => await performerQuery.getCurrentActualShowTimes(performer: currentPerformer()!, currentShowTime: currentActualShowTime!),
              isReGet: false,
            ),
            nextPlanedShowTimeIF: IvFilter(
              ivf: () async => await performerQuery.getNextPlanedShowTime(performer: currentPerformer()!, currentNextPlanedShowTime: null),
              isReGet: false,
            ),
            showFamiliarIF: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliar(performer: currentPerformer()!, currentShowFamiliar: null),
              isReGet: false,
            ),
            clickTimeIF: IvFilter(
              ivf: () async => await performerQuery.getClickTime(performer: currentPerformer()!, currentClickTime: null),
              isReGet: false,
            ),
            clickValueIF: IvFilter(
              ivf: () async => await performerQuery.getClickValue(performer: currentPerformer()!, currentClickValue: null),
              isReGet: false,
            ),
          );
        },
      ),
    );
    return await currentFamiliarity.handle(
      onSuccess: (FamiliarityState state) async {
        return state.result;
      },
      onError: (ExceptionContent ec) async {
        throw ec;
      },
    );
  }

  /// 解析按钮的数值数据。
  Future<ButtonDataState> _parseButtonData() async {
    final parseResult = await AlgorithmParser<ButtonDataState>().parse(
      state: ButtonDataState(
        useContent: memoryModelAb().button_algorithm,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: InternalVariableStorage(),
            countAllIF: IvFilter(
              ivf: () async => await performerQuery.getCountAll(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            countNewIF: IvFilter(
              ivf: () async => await performerQuery.getCountNew(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            timesIF: IvFilter(
              ivf: () async => await performerQuery.getTimes(performer: currentPerformer()!),
              isReGet: false,
            ),
            currentActualShowTimeIF: IvFilter(
              ivf: () async => await performerQuery.getCurrentActualShowTimes(performer: currentPerformer()!, currentShowTime: currentActualShowTime!),
              isReGet: false,
            ),
            nextPlanedShowTimeIF: IvFilter(
              ivf: () async => await performerQuery.getNextPlanedShowTime(performer: currentPerformer()!, currentNextPlanedShowTime: null),
              isReGet: false,
            ),
            showFamiliarIF: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliar(performer: currentPerformer()!, currentShowFamiliar: currentShowFamiliar),
              isReGet: false,
            ),
            clickTimeIF: IvFilter(
              ivf: () async => await performerQuery.getClickTime(performer: currentPerformer()!, currentClickTime: null),
              isReGet: false,
            ),
            clickValueIF: IvFilter(
              ivf: () async => await performerQuery.getClickValue(performer: currentPerformer()!, currentClickValue: null),
              isReGet: false,
            ),
          );
        },
      ),
    );
    return await parseResult.handle(
      onSuccess: (ButtonDataState state) async {
        return state;
      },
      onError: (ExceptionContent ec) async {
        throw ec;
      },
    );
  }

  /// 解析每个按钮的下一次展示时间。
  ///
  /// 解析出的值存放到 [buttonDataValue2NextShowTime] 中。
  Future<void> _parseNextShowTime({required ButtonDataValue2NextShowTime buttonDataValue2NextShowTime}) async {
    final parseResult = await AlgorithmParser<NextShowTimeState>().parse(
      state: NextShowTimeState(
        useContent: memoryModelAb().next_time_algorithm,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: InternalVariableStorage(),
            countAllIF: IvFilter(
              ivf: () async => await performerQuery.getCountAll(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            countNewIF: IvFilter(
              ivf: () async => await performerQuery.getCountNew(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            timesIF: IvFilter(
              ivf: () async => await performerQuery.getTimes(performer: currentPerformer()!),
              isReGet: false,
            ),
            currentActualShowTimeIF: IvFilter(
              ivf: () async => await performerQuery.getCurrentActualShowTimes(performer: currentPerformer()!, currentShowTime: currentActualShowTime!),
              isReGet: false,
            ),
            nextPlanedShowTimeIF: IvFilter(
              ivf: () async => await performerQuery.getNextPlanedShowTime(performer: currentPerformer()!, currentNextPlanedShowTime: null),
              isReGet: false,
            ),
            showFamiliarIF: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliar(performer: currentPerformer()!, currentShowFamiliar: currentShowFamiliar),
              isReGet: false,
            ),
            clickTimeIF: IvFilter(
              // TODO: 如何提示用户 currentClickTime 为 currentActualShowTime
              ivf: () async => await performerQuery.getClickTime(performer: currentPerformer()!, currentClickTime: currentActualShowTime),
              isReGet: false,
            ),
            clickValueIF: IvFilter(
              ivf: () async => await performerQuery.getClickValue(performer: currentPerformer()!, currentClickValue: buttonDataValue2NextShowTime.value),
              isReGet: false,
            ),
          );
        },
      ),
    );
    return await parseResult.handle(
      onSuccess: (NextShowTimeState state) async {
        buttonDataValue2NextShowTime.nextShowTime = state.result;
      },
      onError: (ExceptionContent ec) async {
        throw ec;
      },
    );
  }
}
