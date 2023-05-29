import 'package:aaa/algorithm_parser/AlgorithmException.dart';
import 'package:aaa/algorithm_parser/parser.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'MemoryModelGizmoEditPageAbController.dart';

class AlgorithmEditPageAbController extends AbController {
  final memoryModelGizmoEditPageAbController = Aber.findLast<MemoryModelGizmoEditPageAbController>();

  final freeBoxController = FreeBoxController();
  final currentAlgorithmWrapper = Ab<AlgorithmWrapper>.late();

  final isCurrentRaw = false.ab;
  FreeBoxCamera rawCamera = FreeBoxCamera(expectPosition: Offset(10, 10), expectScale: 1);
  FreeBoxCamera viewCamera = FreeBoxCamera(expectPosition: Offset(10, 10), expectScale: 1);
  final rawTextEditingController = TextEditingController();

  @override
  Future<bool> backListener(bool hasRoute) async {
    final empty = AlgorithmWrapper.emptyAlgorithmWrapper.toJsonString();
    final copyMAb = memoryModelGizmoEditPageAbController.copyMemoryModelAb;
    final current = currentAlgorithmWrapper().toJsonString();
    final isModified = filter(
      from: memoryModelGizmoEditPageAbController.enterType()!.algorithmType,
      targets: {
        [FamiliarityState]: () => filter(
              from: memoryModelGizmoEditPageAbController.enterType()!.algorithmUsageStatus,
              targets: {
                [AlgorithmUsageStatus.a]: () => !((copyMAb().familiarity_algorithm_a == null && current == empty) || copyMAb().familiarity_algorithm_a == current),
                [AlgorithmUsageStatus.b]: () => !((copyMAb().familiarity_algorithm_b == null && current == empty) || copyMAb().familiarity_algorithm_b == current),
                [AlgorithmUsageStatus.c]: () => !((copyMAb().familiarity_algorithm_c == null && current == empty) || copyMAb().familiarity_algorithm_c == current),
              },
              orElse: null,
            ),
        [ButtonDataState]: () => filter(
              from: memoryModelGizmoEditPageAbController.enterType()!.algorithmUsageStatus,
              targets: {
                [AlgorithmUsageStatus.a]: () => !((copyMAb().button_algorithm_a == null && current == empty) || copyMAb().button_algorithm_a == current),
                [AlgorithmUsageStatus.b]: () => !((copyMAb().button_algorithm_b == null && current == empty) || copyMAb().button_algorithm_b == current),
                [AlgorithmUsageStatus.c]: () => !((copyMAb().button_algorithm_c == null && current == empty) || copyMAb().button_algorithm_c == current),
              },
              orElse: null,
            ),
        [NextShowTimeState]: () => filter(
              from: memoryModelGizmoEditPageAbController.enterType()!.algorithmUsageStatus,
              targets: {
                [AlgorithmUsageStatus.a]: () => !((copyMAb().next_time_algorithm_a == null && current == empty) || copyMAb().next_time_algorithm_a == current),
                [AlgorithmUsageStatus.b]: () => !((copyMAb().next_time_algorithm_b == null && current == empty) || copyMAb().next_time_algorithm_b == current),
                [AlgorithmUsageStatus.c]: () => !((copyMAb().next_time_algorithm_c == null && current == empty) || copyMAb().next_time_algorithm_c == current),
              },
              orElse: null,
            ),
      },
      orElse: null,
    );
    if (!isModified) {
      return false;
    }
    bool isBack = false;
    await showCustomDialog(
      builder: (_) => OkAndCancelDialogWidget(
        title: '内容存在修改，是否要丢弃？',
        okText: '丢弃',
        cancelText: '继续编辑',
        text: null,
        onOk: () async {
          SmartDialog.dismiss();
          isBack = true;
        },
        onCancel: () {
          SmartDialog.dismiss();
        },
      ),
    );
    return !isBack;
  }

  @override
  void onInit() {
    super.onInit();
    currentAlgorithmWrapper.lateAssign(AlgorithmWrapper.fromJsonString(content()));
  }

  String content() {
    final ea = AlgorithmWrapper.emptyAlgorithmWrapper.toJsonString();
    final copyMAb = memoryModelGizmoEditPageAbController.copyMemoryModelAb;
    return filter(
      from: memoryModelGizmoEditPageAbController.enterType()!.algorithmType,
      targets: {
        [FamiliarityState]: () => filter(
              from: memoryModelGizmoEditPageAbController.enterType()!.algorithmUsageStatus,
              targets: {
                [AlgorithmUsageStatus.a]: () => copyMAb().familiarity_algorithm_a ?? ea,
                [AlgorithmUsageStatus.b]: () => copyMAb().familiarity_algorithm_b ?? (copyMAb().familiarity_algorithm_a ?? ea),
                [AlgorithmUsageStatus.c]: () => copyMAb().familiarity_algorithm_c ?? (copyMAb().familiarity_algorithm_a ?? ea),
              },
              orElse: null,
            ),
        [ButtonDataState]: () => filter(
              from: memoryModelGizmoEditPageAbController.enterType()!.algorithmUsageStatus,
              targets: {
                [AlgorithmUsageStatus.a]: () => copyMAb().button_algorithm_a ?? ea,
                [AlgorithmUsageStatus.b]: () => copyMAb().button_algorithm_b ?? (copyMAb().button_algorithm_a ?? ea),
                [AlgorithmUsageStatus.c]: () => copyMAb().button_algorithm_c ?? (copyMAb().button_algorithm_a ?? ea),
              },
              orElse: null,
            ),
        [NextShowTimeState]: () => filter(
              from: memoryModelGizmoEditPageAbController.enterType()!.algorithmUsageStatus,
              targets: {
                [AlgorithmUsageStatus.a]: () => copyMAb().next_time_algorithm_a ?? ea,
                [AlgorithmUsageStatus.b]: () => copyMAb().next_time_algorithm_b ?? (copyMAb().next_time_algorithm_a ?? ea),
                [AlgorithmUsageStatus.c]: () => copyMAb().next_time_algorithm_c ?? (copyMAb().next_time_algorithm_a ?? ea),
              },
              orElse: null,
            ),
      },
      orElse: null,
    );
  }

  Future<void> save() async {
    rawToView();
    final copyMAb = memoryModelGizmoEditPageAbController.copyMemoryModelAb;
    filter(
      from: memoryModelGizmoEditPageAbController.enterType()!.algorithmType,
      targets: {
        [FamiliarityState]: () => filter(
              from: memoryModelGizmoEditPageAbController.enterType()!.algorithmUsageStatus,
              targets: {
                [AlgorithmUsageStatus.a]: () => copyMAb.refreshInevitable((obj) => obj..familiarity_algorithm_a = currentAlgorithmWrapper().toJsonString()),
                [AlgorithmUsageStatus.b]: () => copyMAb.refreshInevitable((obj) => obj..familiarity_algorithm_b = currentAlgorithmWrapper().toJsonString()),
                [AlgorithmUsageStatus.c]: () => copyMAb.refreshInevitable((obj) => obj..familiarity_algorithm_c = currentAlgorithmWrapper().toJsonString()),
              },
              orElse: null,
            ),
        [ButtonDataState]: () => filter(
              from: memoryModelGizmoEditPageAbController.enterType()!.algorithmUsageStatus,
              targets: {
                [AlgorithmUsageStatus.a]: () => copyMAb.refreshInevitable((obj) => obj..button_algorithm_a = currentAlgorithmWrapper().toJsonString()),
                [AlgorithmUsageStatus.b]: () => copyMAb.refreshInevitable((obj) => obj..button_algorithm_b = currentAlgorithmWrapper().toJsonString()),
                [AlgorithmUsageStatus.c]: () => copyMAb.refreshInevitable((obj) => obj..button_algorithm_c = currentAlgorithmWrapper().toJsonString()),
              },
              orElse: null,
            ),
        [NextShowTimeState]: () => filter(
              from: memoryModelGizmoEditPageAbController.enterType()!.algorithmUsageStatus,
              targets: {
                [AlgorithmUsageStatus.a]: () => copyMAb.refreshInevitable((obj) => obj..next_time_algorithm_a = currentAlgorithmWrapper().toJsonString()),
                [AlgorithmUsageStatus.b]: () => copyMAb.refreshInevitable((obj) => obj..next_time_algorithm_b = currentAlgorithmWrapper().toJsonString()),
                [AlgorithmUsageStatus.c]: () => copyMAb.refreshInevitable((obj) => obj..next_time_algorithm_c = currentAlgorithmWrapper().toJsonString()),
              },
              orElse: null,
            ),
      },
      orElse: null,
    );
    await memoryModelGizmoEditPageAbController.save();
  }

  Future<void> analysis() async {
    changeRawOrView(false);
    rawToView();
    currentAlgorithmWrapper().cancelAllException();
    await filterFuture(
      from: memoryModelGizmoEditPageAbController.enterType()!.algorithmType,
      targets: {
        [FamiliarityState]: () async => await AlgorithmParser.parse(
              stateFunc: () => FamiliarityState(
                algorithmWrapper: currentAlgorithmWrapper(),
                simulationType: SimulationType.syntaxCheck,
                externalResultHandler: null,
              ),
              onSuccess: (FamiliarityState state) async {
                SmartDialog.showToast("语法分析正确");
              },
              onError: (AlgorithmException ec) async {
                SmartDialog.showToast("语法分析异常：${ec.error}");
              },
            ),
        [ButtonDataState]: () async => await AlgorithmParser.parse(
              stateFunc: () => ButtonDataState(
                algorithmWrapper: currentAlgorithmWrapper(),
                simulationType: SimulationType.syntaxCheck,
                externalResultHandler: null,
              ),
              onSuccess: (ButtonDataState state) async {
                SmartDialog.showToast("语法分析正确");
              },
              onError: (AlgorithmException ec) async {
                SmartDialog.showToast("语法分析异常：${ec.error}");
              },
            ),
        [NextShowTimeState]: () async => await AlgorithmParser.parse(
              stateFunc: () => NextShowTimeState(
                algorithmWrapper: currentAlgorithmWrapper(),
                simulationType: SimulationType.syntaxCheck,
                externalResultHandler: null,
              ),
              onSuccess: (NextShowTimeState state) async {
                SmartDialog.showToast("语法分析正确");
              },
              onError: (AlgorithmException ec) async {
                SmartDialog.showToast("语法分析异常：${ec.error}");
              },
            ),
      },
      orElse: null,
    );
  }

  /// 若 [isToRaw] 为 null，则 raw - view 自动相互切换
  void changeRawOrView(bool? isToRaw) {
    rawToView();

    void toView() {
      rawCamera.changeFrom(freeBoxController.freeBoxCamera);
      rawTextEditingController.text = "";
      freeBoxController.targetSlide(targetCamera: viewCamera, rightNow: false);
    }

    void toRaw() {
      viewCamera.changeFrom(freeBoxController.freeBoxCamera);
      rawTextEditingController.text = AlgorithmBidirectionalParsing.parseFromAlgorithmWrapper(currentAlgorithmWrapper());
      freeBoxController.targetSlide(targetCamera: rawCamera, rightNow: false);
    }

    if (isToRaw == null) {
      if (isCurrentRaw()) {
        toView();
      } else {
        toRaw();
      }
      isCurrentRaw.refreshEasy((oldValue) => !oldValue);
    } else {
      if (isToRaw) {
        isCurrentRaw.refreshEasy((oldValue) => true);
        toRaw();
      } else {
        isCurrentRaw.refreshEasy((oldValue) => false);
        toView();
      }
    }
  }

  /// raw 转 view，以便模式切换、分析、存储等
  void rawToView() {
    if (isCurrentRaw()) {
      currentAlgorithmWrapper.refreshInevitable((obj) => AlgorithmBidirectionalParsing.parseFromString(rawTextEditingController.text));
    }
  }

  /// raw 格式化
  void rawFormatting() {
    rawTextEditingController.text = AlgorithmBidirectionalParsing.parseFromAlgorithmWrapper(
      AlgorithmBidirectionalParsing.parseFromString(rawTextEditingController.text),
    );
  }

  void defaultToPaste(String rawContent) {
    if (isCurrentRaw()) {
      rawTextEditingController.text = rawContent;
    } else {
      currentAlgorithmWrapper.refreshEasy((oldValue) => AlgorithmBidirectionalParsing.parseFromString(rawContent));
    }
    Navigator.pop(context);
    SmartDialog.showToast("替换成功！");
  }

  /// TODO: 把 raw 模式设置成富文本编辑器模式，来提供撤销功能。
}
