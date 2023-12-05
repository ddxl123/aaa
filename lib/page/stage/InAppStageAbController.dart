import 'dart:convert';

import 'package:aaa/algorithm_parser/AlgorithmException.dart';
import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';

import '../edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplate.dart';
import 'PerformerDAO.dart';

class Performer {
  final Fragment fragment;
  final FragmentMemoryInfo fragmentMemoryInfo;
  late final FragmentTemplate fragmentTemplate;
  final InAppStageAbController inAppStageAbController;

  Performer({
    required this.fragment,
    required this.fragmentMemoryInfo,
    required this.inAppStageAbController,
  }) {
    fragmentTemplate = FragmentTemplate.newInstanceFromContent(fragment.content);
    fragmentTemplate.inAppStageAbController = inAppStageAbController;
    inAppStageAbController.isShowBottomButtonAb.lateAssign(fragmentTemplate.initIsShowBottomButton);
  }
}

class InAppStageAbController extends AbController {
  InAppStageAbController({required this.memoryGroupId});

  final int memoryGroupId;

  final memoryGroupAb = Ab<MemoryGroup>.late();

  final memoryModelAb = Ab<MemoryModel>.late();

  final performerQuery = PerformerQuery();

  /// 若为 true，则展示按钮数据值；
  /// 若为 false，则表示按钮天数值。
  final isButtonDataShowValueAb = false.ab;

  /// 每展示碎片时都会被重置。
  /// [PerformerQuery.getPerformer]
  final currentPerformerAb = Ab<Performer?>(null);

  /// 每展示碎片时都会被重置。
  final currentShowTimeAb = Ab<int?>(null);

  /// 每展示碎片时都会被重置。
  final currentButtonDatasAb = <ButtonDataValue2NextShowTime>[].ab;

  /// 每展示碎片时都会被重置。
  final currentShowFamiliarityAb = Ab<double?>(null);

  /// 是否展示底部下次的按钮。
  final isShowBottomButtonAb = Ab<bool>.late();

  @override
  bool get isEnableLoading => true;

  @override
  Widget exceptionWidget(AbException exceptionContent) {
    final e = exceptionContent.error;
    if (e is AlgorithmException) {
      return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(e.error)]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text("点击此处查看算法"),
                  onPressed: () {
                    pushToMemoryModelGizmoEditPage(context: context, memoryModel: memoryModelAb());
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }
    return super.exceptionWidget(exceptionContent);
  }

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
    final mg = (await driftDb.generalQueryDAO.queryOrNullMemoryGroup(memoryGroupId: memoryGroupId))!;
    memoryGroupAb.lateAssign(mg);

    final mm = (await driftDb.generalQueryDAO.queryOrNullMemoryModel(memoryModelId: mg.memory_model_id!))!;
    memoryModelAb.lateAssign(mm);

    await _executeNext();
  }

  /// 仅获取下一个 [Performer]。
  Future<void> _executeNext() async {
    final performer = await performerQuery.getPerformer(mg: memoryGroupAb(), inAppStageAbController: this);
    currentPerformerAb.refreshInevitable((obj) => performer);
    // 说明没有下一个了。
    if (currentPerformerAb() == null) return;

    // 必须按照顺序进行获取，否则要么没有对应的值，要么可能会使用上一次的值。
    currentShowTimeAb.refreshEasy((oldValue) => timeDifference(target: DateTime.now(), start: memoryGroupAb().start_time!));
    await _parseStartFamiliarity();

    final pbd = await _parseStartButtonDatas();
    for (var element in pbd.resultButtonValues) {
      await _parseSingleButtonNextShowTime(buttonDataValue2NextShowTime: element);
    }
    currentButtonDatasAb.refreshEasy((oldValue) => oldValue
      ..clear()
      ..addAll(pbd.resultButtonValues));
  }

  /// 仅完成当前表演。
  ///
  /// 点击数值按钮后进行调用。
  Future<void> _executeFinish({required double clickValue, required List<String> contentValue}) async {
    if (currentPerformerAb() == null) {
      throw "没有下一个碎片了，却仍然请求了下一个碎片！";
    }
    final targetButtonDataValue2NextShowTime = ButtonDataValue2NextShowTime(value: clickValue, explain: null);

    await _parseSingleButtonNextShowTime(buttonDataValue2NextShowTime: targetButtonDataValue2NextShowTime);
    final currentClickFamiliarity = await _parseClickFamiliarity(targetButtonDataValue2NextShowTime);
    if (currentClickFamiliarity == null) {
      throw "解析熟悉度失败！";
    }

    final info = currentPerformerAb()!.fragmentMemoryInfo;
    if (info.study_status == StudyStatus.never) {
      memoryGroupAb.refreshInevitable((obj) => obj..will_new_learn_count -= 1);
    }
    info
      ..click_time = info.click_time.arrayAdd<int>(timeDifference(target: DateTime.now(), start: memoryGroupAb().start_time!))
      ..click_value = info.click_value.arrayAdd<double>(clickValue)
      ..actual_show_time = info.actual_show_time.arrayAdd<int>(currentShowTimeAb()!)
      ..next_plan_show_time = info.next_plan_show_time.arrayAdd<int>(targetButtonDataValue2NextShowTime.nextShowTime!)
      ..show_familiarity = info.show_familiarity.arrayAdd<double>(currentShowFamiliarityAb()!)
      ..click_familiarity = info.click_familiarity.arrayAdd<double>(currentClickFamiliarity)
      ..button_values = info.button_values.arrayAdd<List<double>>(currentButtonDatasAb().map((e) => e.value).toList())
      ..content_value = info.content_value.arrayAdd<List<String>>(contentValue)
      ..study_status = StudyStatus.review;

    await driftDb.updateDAO.resetMemoryGroupAutoSyncVersion(entity: memoryGroupAb());
    await driftDb.updateDAO.resetMemoryInfoAutoSyncVersion(entity: info);

    currentButtonDatasAb.refreshInevitable((obj) => obj..clear());
    currentShowFamiliarityAb.refreshEasy((oldValue) => null);
    currentShowTimeAb.refreshEasy((oldValue) => null);
    currentPerformerAb.refreshEasy((oldValue) => null);
  }

  /// 完成当前表演，并进行下一次表演。
  Future<void> finishAndNext({required double clickValue, required List<String> contentValue}) async {
    await _executeFinish(clickValue: clickValue, contentValue: contentValue);
    await _executeNext();
  }

  /// 解析出当前展示熟练度。
  Future<void> _parseStartFamiliarity() async {
    await AlgorithmParser.parse<FamiliarityState, void>(
      stateFunc: () => FamiliarityState(
        algorithmWrapper: AlgorithmWrapper.fromJsonString(memoryModelAb().familiarity_algorithm),
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: InternalVariableStorage(),
            k1countAllConst: IvFilter(
              ivf: () async => await performerQuery.getCountAll(memoryGroupId: memoryGroupId),
              isReGet: false,
            ),
            k2CountNeverConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.never),
              isReGet: false,
            ),
            k2CountReviewConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.review),
              isReGet: false,
            ),
            k2CountCompleteConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.complete),
              isReGet: false,
            ),
            k2CountStopConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.stop),
              isReGet: false,
            ),
            k3StudiedTimesConst: IvFilter(
              ivf: () async => await performerQuery.getStudiedTimes(performer: currentPerformerAb()!),
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
              ivf: () async => await performerQuery.getActualShowTime(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i2NextPlanShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getNextPlanedShowTime(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i3ShowFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliarity(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i4ClickFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getClickFamiliarity(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i5ClickTimeConst: IvFilter(
              ivf: () async => await performerQuery.getClickTime(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i6ClickValueConst: IvFilter(
              ivf: () async => await performerQuery.getClickValue(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i7ButtonValuesConst: IvFilter(
              ivf: () async => await performerQuery.getButtonValues(performer: currentPerformerAb()!),
              isReGet: false,
            ),
          );
        },
      ),
      onSuccess: (FamiliarityState state) async {
        currentShowFamiliarityAb.refreshEasy((oldValue) => state.result);
      },
      onError: (AlgorithmException ec) async {
        throw ec;
      },
    );
  }

  /// 解析出指定按钮的展示熟练度。
  ///
  /// 返回 null 表示发生异常。
  Future<double?> _parseClickFamiliarity(ButtonDataValue2NextShowTime buttonDataValue2NextShowTime) async {
    return await AlgorithmParser.parse<FamiliarityState, double?>(
      stateFunc: () => FamiliarityState(
        algorithmWrapper: AlgorithmWrapper.fromJsonString(memoryModelAb().familiarity_algorithm),
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: InternalVariableStorage(),
            k1countAllConst: IvFilter(
              ivf: () async => await performerQuery.getCountAll(memoryGroupId: memoryGroupId),
              isReGet: false,
            ),
            k2CountNeverConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.never),
              isReGet: false,
            ),
            k2CountReviewConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.review),
              isReGet: false,
            ),
            k2CountCompleteConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.complete),
              isReGet: false,
            ),
            k2CountStopConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.stop),
              isReGet: false,
            ),
            k3StudiedTimesConst: IvFilter(
              ivf: () async => await performerQuery.getStudiedTimes(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            k4CurrentShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getCurrentShowTime(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            k5CurrentShowFamiliarityConst: IvFilter(
              ivf: () async => currentShowFamiliarityAb()!,
              isReGet: false,
            ),
            k6CurrentButtonValuesConst: IvFilter(
              ivf: () async => currentButtonDatasAb().map((e) => e.value).toList(),
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
              ivf: () async => await performerQuery.getActualShowTime(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i2NextPlanShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getNextPlanedShowTime(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i3ShowFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliarity(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i4ClickFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getClickFamiliarity(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i5ClickTimeConst: IvFilter(
              ivf: () async => await performerQuery.getClickTime(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i6ClickValueConst: IvFilter(
              ivf: () async => await performerQuery.getClickValue(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i7ButtonValuesConst: IvFilter(
              ivf: () async => await performerQuery.getButtonValues(performer: currentPerformerAb()!),
              isReGet: false,
            ),
          );
        },
      ),
      onSuccess: (FamiliarityState state) async {
        return state.result;
      },
      onError: (AlgorithmException ec) async {
        throw ec;
      },
    );
  }

  /// 解析全部按钮的原始数值，并非解析的时间。
  ///
  /// 返回 null 表示发生异常。
  Future<ButtonDataState> _parseStartButtonDatas() async {
    return await AlgorithmParser.parse<ButtonDataState, ButtonDataState>(
      stateFunc: () => ButtonDataState(
        algorithmWrapper: AlgorithmWrapper.fromJsonString(memoryModelAb().button_algorithm),
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: InternalVariableStorage(),
            k1countAllConst: IvFilter(
              ivf: () async => await performerQuery.getCountAll(memoryGroupId: memoryGroupId),
              isReGet: false,
            ),
            k2CountNeverConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.never),
              isReGet: false,
            ),
            k2CountReviewConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.review),
              isReGet: false,
            ),
            k2CountCompleteConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.complete),
              isReGet: false,
            ),
            k2CountStopConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.stop),
              isReGet: false,
            ),
            k3StudiedTimesConst: IvFilter(
              ivf: () async => await performerQuery.getStudiedTimes(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            k4CurrentShowTimeConst: IvFilter(
              ivf: () async => performerQuery.getCurrentShowTime(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            k5CurrentShowFamiliarityConst: IvFilter(
              ivf: () async => currentShowFamiliarityAb()!,
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
              ivf: () async => await performerQuery.getActualShowTime(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i2NextPlanShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getNextPlanedShowTime(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i3ShowFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliarity(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i4ClickFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getClickFamiliarity(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i5ClickTimeConst: IvFilter(
              ivf: () async => await performerQuery.getClickTime(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i6ClickValueConst: IvFilter(
              ivf: () async => await performerQuery.getClickValue(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i7ButtonValuesConst: IvFilter(
              ivf: () async => await performerQuery.getButtonValues(performer: currentPerformerAb()!),
              isReGet: false,
            ),
          );
        },
      ),
      onSuccess: (ButtonDataState state) async {
        return state;
      },
      onError: (AlgorithmException ec) async {
        throw ec;
      },
    );
  }

  /// 根据已解析过的全部按钮数据，解析单个按钮的下一次展示时间。
  ///
  /// 解析出的值存放到 [buttonDataValue2NextShowTime] 中。
  Future<void> _parseSingleButtonNextShowTime({required ButtonDataValue2NextShowTime buttonDataValue2NextShowTime}) async {
    await AlgorithmParser.parse<NextShowTimeState, void>(
      stateFunc: () => NextShowTimeState(
        algorithmWrapper: AlgorithmWrapper.fromJsonString(memoryModelAb().next_time_algorithm),
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom atom) async {
          return await atom.filter(
            storage: InternalVariableStorage(),
            k1countAllConst: IvFilter(
              ivf: () async => await performerQuery.getCountAll(memoryGroupId: memoryGroupId),
              isReGet: false,
            ),
            k2CountNeverConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.never),
              isReGet: false,
            ),
            k2CountReviewConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.review),
              isReGet: false,
            ),
            k2CountCompleteConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.complete),
              isReGet: false,
            ),
            k2CountStopConst: IvFilter(
              ivf: () async => await performerQuery.queryFragmentCountByStudyStatus(memoryGroupId: memoryGroupId, studyStatus: StudyStatus.stop),
              isReGet: false,
            ),
            k3StudiedTimesConst: IvFilter(
              ivf: () async => await performerQuery.getStudiedTimes(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            k4CurrentShowTimeConst: IvFilter(
              ivf: () async => performerQuery.getCurrentShowTime(memoryGroup: memoryGroupAb()),
              isReGet: false,
            ),
            k5CurrentShowFamiliarityConst: IvFilter(
              ivf: () async => currentShowFamiliarityAb()!,
              isReGet: false,
            ),
            k6CurrentButtonValuesConst: IvFilter(
              ivf: () async => currentButtonDatasAb().map((e) => e.value).toList(),
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
              ivf: () async => await performerQuery.getActualShowTime(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i2NextPlanShowTimeConst: IvFilter(
              ivf: () async => await performerQuery.getNextPlanedShowTime(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i3ShowFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getShowFamiliarity(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i4ClickFamiliarityConst: IvFilter(
              ivf: () async => await performerQuery.getClickFamiliarity(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i5ClickTimeConst: IvFilter(
              ivf: () async => await performerQuery.getClickTime(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i6ClickValueConst: IvFilter(
              ivf: () async => await performerQuery.getClickValue(performer: currentPerformerAb()!),
              isReGet: false,
            ),
            i7ButtonValuesConst: IvFilter(
              ivf: () async => await performerQuery.getButtonValues(performer: currentPerformerAb()!),
              isReGet: false,
            ),
          );
        },
      ),
      onSuccess: (NextShowTimeState state) async {
        buttonDataValue2NextShowTime.nextShowTime = state.result;
      },
      onError: (AlgorithmException ec) async {
        throw ec;
      },
    );
  }
}
