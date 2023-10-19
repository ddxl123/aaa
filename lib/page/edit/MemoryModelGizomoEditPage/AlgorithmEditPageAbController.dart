import 'package:aaa/algorithm_parser/AlgorithmException.dart';
import 'package:aaa/algorithm_parser/parser.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'MemoryModelGizmoEditPageAbController.dart';

class AlgorithmEditPageAbController extends AbController {
  AlgorithmEditPageAbController({required this.name});

  final String name;
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
    final mm = memoryModelGizmoEditPageAbController.memoryModel;
    final current = currentAlgorithmWrapper().toJsonString();
    final isModified = filter(
      from: name,
      targets: {
        [FamiliarityState.name]: () => !((mm.familiarity_algorithm == null && current == empty) || mm.familiarity_algorithm == current),
        [ButtonDataState.name]: () => !((mm.button_algorithm == null && current == empty) || mm.button_algorithm == current),
        [NextShowTimeState.name]: () => !((mm.next_time_algorithm == null && current == empty) || mm.next_time_algorithm == current),
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
    final mm = memoryModelGizmoEditPageAbController.memoryModel;
    return filter(
      from: name,
      targets: {
        [FamiliarityState.name]: () => mm.familiarity_algorithm ?? ea,
        [ButtonDataState.name]: () => mm.button_algorithm ?? ea,
        [NextShowTimeState.name]: () => mm.next_time_algorithm ?? ea,
      },
      orElse: null,
    );
  }

  Future<void> save() async {
    rawToView();
    final mm = memoryModelGizmoEditPageAbController.memoryModel;
    filter(
      from: name,
      targets: {
        [FamiliarityState.name]: () => mm..familiarity_algorithm = currentAlgorithmWrapper().toJsonString(),
        [ButtonDataState.name]: () => mm..button_algorithm = currentAlgorithmWrapper().toJsonString(),
        [NextShowTimeState.name]: () => mm..next_time_algorithm = currentAlgorithmWrapper().toJsonString(),
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
      from: name,
      targets: {
        [FamiliarityState.name]: () async => await AlgorithmParser.parse(
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
        [ButtonDataState.name]: () async => await AlgorithmParser.parse(
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
        [NextShowTimeState.name]: () async => await AlgorithmParser.parse(
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
