import 'package:aaa/algorithm_parser/AlgorithmException.dart';
import 'package:aaa/algorithm_parser/parser.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'MemoryModelGizmoEditPageAbController.dart';

class AlgorithmEditPageAbController extends AbController {
  AlgorithmEditPageAbController();

  final memoryModelGizmoEditPageAbController = Aber.findLast<MemoryModelGizmoEditPageAbController>();

  final freeBoxController = FreeBoxController();
  final currentAlgorithmWrapper = Ab<AlgorithmWrapper>.late();

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
    currentAlgorithmWrapper.lateAssign(AlgorithmWrapper(customVariables: [], ifUseElseWrapper: AlgorithmBidirectionalParsing.parseFromString()!));
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
    currentAlgorithmWrapper().cancelAllException();
    await filterFuture(
      from: memoryModelGizmoEditPageAbController.enterType()!.algorithmType,
      targets: {
        [FamiliarityState]: () async => await AlgorithmParser.parse(
              state: FamiliarityState(
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
              state: ButtonDataState(
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
              state: NextShowTimeState(
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
}
