import 'dart:convert';

import 'package:aaa/algorithm_parser/AlgorithmException.dart';
import 'package:aaa/algorithm_parser/parser.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';

import '../edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplate.dart';
import 'PerformerDAO.dart';

class Performer {
  final Fragment fragment;
  final FragmentMemoryInfo fragmentMemoryInfo;
  late final FragmentTemplate fragmentTemplate;

  Performer({
    required this.fragment,
    required this.fragmentMemoryInfo,
  }) {
    fragmentTemplate = FragmentTemplate.newInstanceFromContent(fragment.content);
  }
}

class InAppStageAbController extends AbController {
  InAppStageAbController({required this.memoryGroupId});

  final int memoryGroupId;

  late final Ab<MemoryGroup> memoryGroupAb;

  late final Ab<MemoryModel> memoryModelAb;

  final performerQuery = PerformerQuery();

  /// 若为 true，则展示按钮数据值；
  /// 若为 false，则表示按钮天数值。
  final isButtonDataShowValue = false.ab;

  /// 每展示碎片时都会被重置。
  /// [PerformerQuery.getPerformer]
  final currentPerformer = Ab<Performer?>(null);

  /// 每展示碎片时都会被重置。
  final currentShowTime = Ab<int?>(null);

  /// 每展示碎片时都会被重置。
  final currentButtonDatas = <ButtonDataValue2NextShowTime>[].ab;

  /// 每展示碎片时都会被重置。
  final currentShowFamiliarity = Ab<double?>(null);

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
    await _init();
  }

  Future<void> _init() async {
    throw "TODO";
    // final mg = await db.generalQueryDAO.queryMemoryGroupById(id: memoryGroupId);
    // memoryGroupAb = mg!.ab;
    //
    // final mm = await db.generalQueryDAO.queryMemoryModelInMemoryGroup(memoryGroup: memoryGroupAb());
    // if (mm == null) {
    //   SmartDialog.showToast("未对该碎片组分配算法模型！");
    //   Navigator.pop(context);
    //   return;
    // }
    // memoryModelAb = mm.ab;
    //
    // await _next();
  }

  /// 仅获取下一个 [Performer]。
  Future<void> _next() async {
    final performer = await performerQuery.getPerformer(mg: memoryGroupAb());
    currentPerformer.refreshInevitable((obj) => performer);
    // 说明没有下一个了。
    if (currentPerformer() == null) return;

    // 必须按照顺序进行获取，否则要么没有对应的值，要么可能会使用上一次的值。
    currentShowTime.refreshEasy((oldValue) => timeDifference(target: DateTime.now(), start: memoryGroupAb().start_time!));
    await _parseStartFamiliarity();

    final pbd = await _parseStartButtonDatas();
    if (pbd != null) {
      for (var element in pbd.resultButtonValues) {
        await _parseSingleButtonNextShowTime(buttonDataValue2NextShowTime: element);
      }
      currentButtonDatas.refreshEasy((oldValue) => oldValue
        ..clear()
        ..addAll(pbd.resultButtonValues));
    } else {
      throw "解析按钮数据失败！";
    }
  }

  /// 仅完成当前表演。
  ///
  /// 点击数值按钮后进行调用。
  Future<void> _finish({required double clickValue, required List<String> contentValue}) async {
    throw "TODO";
    // if (currentPerformer() == null) {
    //   throw "没有下一个碎片了，却仍然请求了下一个碎片！";
    // }
    //
    // final targetButtonDataValue2NextShowTime = ButtonDataValue2NextShowTime(value: clickValue, explain: null);
    // await _parseSingleButtonNextShowTime(buttonDataValue2NextShowTime: targetButtonDataValue2NextShowTime);
    //
    // final currentClickFamiliarity = await _parseClickFamiliarity(targetButtonDataValue2NextShowTime);
    // if (currentClickFamiliarity == null) {
    //   throw "解析熟悉度失败！";
    // }
    //
    // final info = currentPerformer()!.fragmentMemoryInfo;
    //
    // final st = await SyncTag.create();
    // await performerQuery.finish(
    //   originalFragmentMemoryInfoReset: () async {
    //     await info.reset(
    //       creator_user_id: toAbsent(),
    //       fragment_id: toAbsent(),
    //       memory_group_id: toAbsent(),
    //       click_time: info.click_time.arrayAdd<int>(timeDifference(target: DateTime.now(), start: memoryGroupAb().start_time!)).toValue(),
    //       click_value: info.click_value.arrayAdd<double>(clickValue).toValue(),
    //       actual_show_time: info.actual_show_time.arrayAdd<int>(currentShowTime()!).toValue(),
    //       next_plan_show_time: info.next_plan_show_time.arrayAdd<int>(targetButtonDataValue2NextShowTime.nextShowTime!).toValue(),
    //       show_familiarity: info.show_familiarity.arrayAdd<double>(currentShowFamiliarity()!).toValue(),
    //       click_familiarity: info.click_familiarity.arrayAdd<double>(currentClickFamiliarity).toValue(),
    //       button_values: info.button_values.arrayAdd<List<double>>(currentButtonDatas().map((e) => e.value).toList()).toValue(),
    //       content_value: info.content_value.arrayAdd<List<String>>(contentValue).toValue(),
    //       study_status: StudyStatus.review.toValue(),
    //       syncTag: st,
    //       isCloudTableWithSync: true,
    //     );
    //   },
    //   // 若为新的，则会自动将 [MemoryGroup.willNewLearnCount] 减去 1。
    //   originalMemoryGroup: memoryGroupAb(),
    //   fragmentMemoryInfo: info,
    //   syncTag: st,
    // );
    // currentButtonDatas.refreshInevitable((obj) => obj..clear());
    // currentShowFamiliarity.refreshEasy((oldValue) => null);
    // currentShowTime.refreshEasy((oldValue) => null);
    // currentPerformer.refreshEasy((oldValue) => null);
    //
    // memoryGroupAb.refreshInevitable((obj) => obj..will_new_learn_count = obj.will_new_learn_count - 1);
  }

  /// 完成当前表演，并进行下一次表演。
  Future<void> finishAndNext({required double clickValue, required List<String> contentValue}) async {
    await _finish(clickValue: clickValue, contentValue: contentValue);
    await _next();
  }

  /// 解析出当前展示熟练度。
  Future<void> _parseStartFamiliarity() async {
    await AlgorithmParser.parse<FamiliarityState, void>(
      stateFunc: () => FamiliarityState(
        algorithmWrapper: AlgorithmWrapper.fromJsonString(memoryModelAb().familiarity_algorithm_a!),
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: InternalVariableStorage(),
            k1countAllConst: IvFilter(
              ivf: () async => await performerQuery.getCountAll(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            k2CountNeverConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.never),
              isReGet: false,
            ),
            k2CountReviewConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.review),
              isReGet: false,
            ),
            k2CountCompleteConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.complete),
              isReGet: false,
            ),
            k2CountStopConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.stop),
              isReGet: false,
            ),
            k3StudiedTimesConst: IvFilter(
              ivf: () async => await performerQuery.getStudiedTimes(performer: currentPerformer()!),
              isReGet: false,
            ),
            k4CurrentShowTimeConst: IvFilter(
              ivf: () async => performerQuery.getCurrentShowTime(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            k5CurrentShowFamiliarityConst: IvFilter(
              ivf: () => throw KnownAlgorithmException("解析当前展示时的熟练度时，不能使用 ${atom.internalVariableConstant.name} 变量"),
              isReGet: false,
            ),
            k6CurrentButtonValuesConst: IvFilter(
              ivf: () => throw KnownAlgorithmException("解析当前展示时的熟练度时，不能使用 ${atom.internalVariableConstant.name} 变量"),
              isReGet: false,
            ),
            k6CurrentButtonValueConst: IvFilter(
              ivf: () => throw KnownAlgorithmException("解析当前展示时的熟练度时，不能使用 ${atom.internalVariableConstant.name} 变量"),
              isReGet: false,
            ),
            k7CurrentClickTimeConst: IvFilter(
              ivf: () => throw KnownAlgorithmException("解析当前展示时的熟练度时，不能使用 ${atom.internalVariableConstant.name} 变量"),
              isReGet: false,
            ),
            i1ActualShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getActualShowTime(performer: currentPerformer()!),
              isReGet: false,
            ),
            i2NextPlanShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getNextPlanedShowTime(performer: currentPerformer()!),
              isReGet: false,
            ),
            i3ShowFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliarity(performer: currentPerformer()!),
              isReGet: false,
            ),
            i4ClickFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getClickFamiliarity(performer: currentPerformer()!),
              isReGet: false,
            ),
            i5ClickTimeConst: IvFilter(
              ivf: () async => await performerQuery.getClickTime(performer: currentPerformer()!),
              isReGet: false,
            ),
            i6ClickValueConst: IvFilter(
              ivf: () async => await performerQuery.getClickValue(performer: currentPerformer()!),
              isReGet: false,
            ),
            i7ButtonValuesConst: IvFilter(
              ivf: () async => await performerQuery.getButtonValues(performer: currentPerformer()!),
              isReGet: false,
            ),
          );
        },
      ),
      onSuccess: (FamiliarityState state) async {
        currentShowFamiliarity.refreshEasy((oldValue) => state.result);
      },
      onError: (AlgorithmException ec) async {
        // throw ec;
      },
    );
  }

  /// 解析出指定按钮的展示熟练度。
  ///
  /// 返回 null 表示发生异常。
  Future<double?> _parseClickFamiliarity(ButtonDataValue2NextShowTime buttonDataValue2NextShowTime) async {
    return await AlgorithmParser.parse<FamiliarityState, double?>(
      stateFunc: () => FamiliarityState(
        algorithmWrapper: AlgorithmWrapper.fromJsonString(memoryModelAb().familiarity_algorithm_a!),
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: InternalVariableStorage(),
            k1countAllConst: IvFilter(
              ivf: () async => await performerQuery.getCountAll(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            k2CountNeverConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.never),
              isReGet: false,
            ),
            k2CountReviewConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.review),
              isReGet: false,
            ),
            k2CountCompleteConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.complete),
              isReGet: false,
            ),
            k2CountStopConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.stop),
              isReGet: false,
            ),
            k3StudiedTimesConst: IvFilter(
              ivf: () async => await performerQuery.getStudiedTimes(performer: currentPerformer()!),
              isReGet: false,
            ),
            k4CurrentShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getCurrentShowTime(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            k5CurrentShowFamiliarityConst: IvFilter(
              ivf: () async => currentShowFamiliarity()!,
              isReGet: false,
            ),
            k6CurrentButtonValuesConst: IvFilter(
              ivf: () async => currentButtonDatas().map((e) => e.value).toList(),
              isReGet: false,
            ),
            k6CurrentButtonValueConst: IvFilter(
              ivf: () async => buttonDataValue2NextShowTime.value,
              isReGet: false,
            ),
            k7CurrentClickTimeConst: IvFilter(
              ivf: () => throw KnownAlgorithmException("解析每个按钮的展示熟练度，不能使用 ${atom.internalVariableConstant.name} 变量"),
              isReGet: false,
            ),
            i1ActualShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getActualShowTime(performer: currentPerformer()!),
              isReGet: false,
            ),
            i2NextPlanShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getNextPlanedShowTime(performer: currentPerformer()!),
              isReGet: false,
            ),
            i3ShowFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliarity(performer: currentPerformer()!),
              isReGet: false,
            ),
            i4ClickFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getClickFamiliarity(performer: currentPerformer()!),
              isReGet: false,
            ),
            i5ClickTimeConst: IvFilter(
              ivf: () async => await performerQuery.getClickTime(performer: currentPerformer()!),
              isReGet: false,
            ),
            i6ClickValueConst: IvFilter(
              ivf: () async => await performerQuery.getClickValue(performer: currentPerformer()!),
              isReGet: false,
            ),
            i7ButtonValuesConst: IvFilter(
              ivf: () async => await performerQuery.getButtonValues(performer: currentPerformer()!),
              isReGet: false,
            ),
          );
        },
      ),
      onSuccess: (FamiliarityState state) async {
        return state.result;
      },
      onError: (AlgorithmException ec) async {
        // throw ec;
        return null;
      },
    );
  }

  /// 解析全部按钮的原始数值，并非解析的时间。
  ///
  /// 返回 null 表示发生异常。
  Future<ButtonDataState?> _parseStartButtonDatas() async {
    return await AlgorithmParser.parse<ButtonDataState, ButtonDataState?>(
      stateFunc: () => ButtonDataState(
        algorithmWrapper: AlgorithmWrapper.fromJsonString(memoryModelAb().button_algorithm_a!),
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: InternalVariableStorage(),
            k1countAllConst: IvFilter(
              ivf: () async => await performerQuery.getCountAll(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            k2CountNeverConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.never),
              isReGet: false,
            ),
            k2CountReviewConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.review),
              isReGet: false,
            ),
            k2CountCompleteConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.complete),
              isReGet: false,
            ),
            k2CountStopConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.stop),
              isReGet: false,
            ),
            k3StudiedTimesConst: IvFilter(
              ivf: () async => await performerQuery.getStudiedTimes(performer: currentPerformer()!),
              isReGet: false,
            ),
            k4CurrentShowTimeConst: IvFilter(
              ivf: () async => performerQuery.getCurrentShowTime(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            k5CurrentShowFamiliarityConst: IvFilter(
              ivf: () async => currentShowFamiliarity()!,
              isReGet: false,
            ),
            k6CurrentButtonValuesConst: IvFilter(
              ivf: () => throw KnownAlgorithmException("解析全部按钮的原始数值时，不能使用 ${atom.internalVariableConstant.name} 变量"),
              isReGet: false,
            ),
            k6CurrentButtonValueConst: IvFilter(
              ivf: () => throw KnownAlgorithmException("解析全部按钮的原始数值时，不能使用 ${atom.internalVariableConstant.name} 变量"),
              isReGet: false,
            ),
            k7CurrentClickTimeConst: IvFilter(
              ivf: () => throw KnownAlgorithmException("解析全部按钮的原始数值时，不能使用 ${atom.internalVariableConstant.name} 变量"),
              isReGet: false,
            ),
            i1ActualShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getActualShowTime(performer: currentPerformer()!),
              isReGet: false,
            ),
            i2NextPlanShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getNextPlanedShowTime(performer: currentPerformer()!),
              isReGet: false,
            ),
            i3ShowFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliarity(performer: currentPerformer()!),
              isReGet: false,
            ),
            i4ClickFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getClickFamiliarity(performer: currentPerformer()!),
              isReGet: false,
            ),
            i5ClickTimeConst: IvFilter(
              ivf: () async => await performerQuery.getClickTime(performer: currentPerformer()!),
              isReGet: false,
            ),
            i6ClickValueConst: IvFilter(
              ivf: () async => await performerQuery.getClickValue(performer: currentPerformer()!),
              isReGet: false,
            ),
            i7ButtonValuesConst: IvFilter(
              ivf: () async => await performerQuery.getButtonValues(performer: currentPerformer()!),
              isReGet: false,
            ),
          );
        },
      ),
      onSuccess: (ButtonDataState state) async {
        return state;
      },
      onError: (AlgorithmException ec) async {
        // throw ec;
        return null;
      },
    );
  }

  /// 根据已解析过的全部按钮数据，解析单个按钮的下一次展示时间。
  ///
  /// 解析出的值存放到 [buttonDataValue2NextShowTime] 中。
  Future<void> _parseSingleButtonNextShowTime({required ButtonDataValue2NextShowTime buttonDataValue2NextShowTime}) async {
    await AlgorithmParser.parse<NextShowTimeState, void>(
      stateFunc: () => NextShowTimeState(
        algorithmWrapper: AlgorithmWrapper.fromJsonString(memoryModelAb().next_time_algorithm_a!),
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: InternalVariableStorage(),
            k1countAllConst: IvFilter(
              ivf: () async => await performerQuery.getCountAll(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            k2CountNeverConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.never),
              isReGet: false,
            ),
            k2CountReviewConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.review),
              isReGet: false,
            ),
            k2CountCompleteConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.complete),
              isReGet: false,
            ),
            k2CountStopConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.stop),
              isReGet: false,
            ),
            k3StudiedTimesConst: IvFilter(
              ivf: () async => await performerQuery.getStudiedTimes(performer: currentPerformer()!),
              isReGet: false,
            ),
            k4CurrentShowTimeConst: IvFilter(
              ivf: () async => performerQuery.getCurrentShowTime(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            k5CurrentShowFamiliarityConst: IvFilter(
              ivf: () async => currentShowFamiliarity()!,
              isReGet: false,
            ),
            k6CurrentButtonValuesConst: IvFilter(
              ivf: () async => currentButtonDatas().map((e) => e.value).toList(),
              isReGet: false,
            ),
            k6CurrentButtonValueConst: IvFilter(
              ivf: () async => buttonDataValue2NextShowTime.value,
              isReGet: false,
            ),
            k7CurrentClickTimeConst: IvFilter(
              ivf: () async => timeDifference(target: DateTime.now(), start: memoryGroupAb().start_time!),
              isReGet: false,
            ),
            i1ActualShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getActualShowTime(performer: currentPerformer()!),
              isReGet: false,
            ),
            i2NextPlanShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getNextPlanedShowTime(performer: currentPerformer()!),
              isReGet: false,
            ),
            i3ShowFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliarity(performer: currentPerformer()!),
              isReGet: false,
            ),
            i4ClickFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getClickFamiliarity(performer: currentPerformer()!),
              isReGet: false,
            ),
            i5ClickTimeConst: IvFilter(
              ivf: () async => await performerQuery.getClickTime(performer: currentPerformer()!),
              isReGet: false,
            ),
            i6ClickValueConst: IvFilter(
              ivf: () async => await performerQuery.getClickValue(performer: currentPerformer()!),
              isReGet: false,
            ),
            i7ButtonValuesConst: IvFilter(
              ivf: () async => await performerQuery.getButtonValues(performer: currentPerformer()!),
              isReGet: false,
            ),
          );
        },
      ),
      onSuccess: (NextShowTimeState state) async {
        buttonDataValue2NextShowTime.nextShowTime = state.result;
      },
      onError: (AlgorithmException ec) async {
        // throw ec;
      },
    );
  }
}
