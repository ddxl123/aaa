import 'dart:async';

import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class MemoryModelGizmoEditPageAbController extends AbController {
  MemoryModelGizmoEditPageAbController({required this.memoryModelAb});

  final Ab<MemoryModelGizmoEditPageType> editPageType = MemoryModelGizmoEditPageType.look.ab;

  final Ab<MemoryModel> memoryModelAb;

  /// [MemoryModels.title]
  final titleStorage = AbStorage<String>(abValue: ''.ab, tempValue: '');
  final titleEditingController = TextEditingController();

  /// [MemoryModels.familiarityAlgorithm]
  final familiarityAlgorithmStorage = AbStorage<String>(abValue: ''.ab, tempValue: '');
  final familiarityAlgorithmEditingController = TextEditingController();
  final familiarityAlgorithmFocusNode = FocusNode();

  /// [MemoryModels.nextTimeAlgorithm]
  final nextTimeAlgorithmStorage = AbStorage<String>(abValue: ''.ab, tempValue: '');
  final nextTimeAlgorithmEditingController = TextEditingController();

  /// [MemoryModels.buttonAlgorithm]
  final buttonAlgorithmStorage = AbStorage<String>(abValue: ''.ab, tempValue: '');
  final buttonAlgorithmEditingController = TextEditingController();

  final isAlgorithmKeyboard = false.ab;

  void initVerifies() {
    titleStorage.initVerify(
      verifyCallback: (v) async {
        if (v.trim() == '') {
          return '标题不能为空！';
        }
        return null;
      },
    );
    familiarityAlgorithmStorage.initVerify(
      verifyCallback: (v) async {
        final result = await AlgorithmParser<FamiliarityState>().parse(
          state: FamiliarityState(
            useContent: v,
            simulationType: SimulationType.syntaxCheck,
            externalResultHandler: null,
          ),
        );
        return await result.handle(
          onSuccess: (FamiliarityState state) async => null,
          onError: (ExceptionContent ec) async {
            return ec.error.toString();
          },
        );
      },
    );
    nextTimeAlgorithmStorage.initVerify(
      verifyCallback: (v) async {
        final result = await AlgorithmParser<NextShowTimeState>().parse(
          state: NextShowTimeState(
            useContent: v,
            simulationType: SimulationType.syntaxCheck,
            externalResultHandler: null,
          ),
        );
        return await result.handle(
          onSuccess: (NextShowTimeState state) async => null,
          onError: (ExceptionContent ec) async {
            return ec.error.toString();
          },
        );
      },
    );
    buttonAlgorithmStorage.initVerify(
      verifyCallback: (v) async {
        final result = await AlgorithmParser<ButtonDataState>().parse(
          state: ButtonDataState(
            useContent: v,
            simulationType: SimulationType.syntaxCheck,
            externalResultHandler: null,
          ),
        );
        return await result.handle(
          onSuccess: (ButtonDataState state) async => null,
          onError: (ExceptionContent ec) async {
            return ec.error.toString();
          },
        );
      },
    );
  }

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    await Future.delayed(const Duration(milliseconds: 200));
    // 再次查询。
    final mm = await db.generalQueryDAO.queryMemoryModelById(memoryModelId: memoryModelAb().id);

    titleStorage
      ..tempValue = mm.title
      ..abValue.refreshEasy((oldValue) => mm.title);

    familiarityAlgorithmStorage
      ..tempValue = mm.familiarity_algorithm
      ..abValue.refreshEasy((oldValue) => mm.familiarity_algorithm);

    nextTimeAlgorithmStorage
      ..tempValue = mm.next_time_algorithm
      ..abValue.refreshEasy((oldValue) => mm.next_time_algorithm);

    buttonAlgorithmStorage
      ..tempValue = mm.button_algorithm
      ..abValue.refreshEasy((oldValue) => mm.button_algorithm);

    titleEditingController.text = titleStorage.abValue();
    familiarityAlgorithmEditingController.text = familiarityAlgorithmStorage.abValue();
    nextTimeAlgorithmEditingController.text = nextTimeAlgorithmStorage.abValue();
    buttonAlgorithmEditingController.text = buttonAlgorithmStorage.abValue();

    initVerifies();
  }

  @override
  Widget loadingWidget() {
    return const Material(
      child: Center(
        child: Text('加载中...'),
      ),
    );
  }

  /// 返回是否验证成功。
  Future<bool> saveAnalyze() async {
    return await titleStorage.verify();
  }

  /// 返回是否验证成功。
  Future<bool> completeAnalyze() async {
    return boolAllTrue([
      await titleStorage.verify(),
      await familiarityAlgorithmStorage.verify(),
      await nextTimeAlgorithmStorage.verify(),
      await buttonAlgorithmStorage.verify(),
    ]);
  }

  void commit() {
    _commit().then(
      (value) {
        filter(
          from: editPageType(),
          targets: {
            [MemoryModelGizmoEditPageType.modify]: () {
              if (value.t1) {
                SmartDialog.showToast(value.t2);
                changeTo(type: MemoryModelGizmoEditPageType.look);
              } else {
                SmartDialog.showToast(value.t2);
              }
            }
          },
          orElse: null,
        );
      },
    );
  }

  /// 返回值：是否成功-消息。
  Future<Tuple2<bool, String>> _commit() async {
    return await filterFuture<MemoryModelGizmoEditPageType, Tuple2<bool, String>>(
      from: editPageType(),
      targets: {
        [MemoryModelGizmoEditPageType.modify]: () async {
          if (await saveAnalyze()) {
            await db.updateDAO.resetMemoryModelOnlySave(
              originalMemoryModelReset: (st) async {
                return await memoryModelAb().reset(
                  creator_user_id: toAbsent(),
                  father_memory_model_id: toAbsent(),
                  title: titleStorage.abValue().toValue(),
                  familiarity_algorithm: familiarityAlgorithmStorage.abValue().toValue(),
                  next_time_algorithm: nextTimeAlgorithmStorage.abValue().toValue(),
                  button_algorithm: buttonAlgorithmStorage.abValue().toValue(),
                  syncTag: st,
                );
              },
              syncTag: null,
            );
            memoryModelAb.refreshForce();
            return Tuple2(t1: true, t2: '修改成功！');
          } else {
            return Tuple2(t1: false, t2: '修改失败！');
          }
        },
      },
      orElse: null,
    );
  }

  void cancel() {
    showCustomDialog(
      builder: (_) => OkAndCancelDialogWidget(
        title: '是否要丢弃？',
        okText: '丢弃',
        cancelText: '继续编辑',
        text: null,
        onOk: () => filter(
          from: editPageType(),
          targets: {
            [MemoryModelGizmoEditPageType.modify]: () {
              recovery();
              SmartDialog.dismiss();
              changeTo(type: MemoryModelGizmoEditPageType.look);
            },
          },
          orElse: null,
        ),
        onCancel: () {
          SmartDialog.dismiss();
        },
      ),
    );
  }

  void recovery() {
    titleStorage.recovery();
    familiarityAlgorithmStorage.recovery();
    nextTimeAlgorithmStorage.recovery();
    buttonAlgorithmStorage.recovery();

    titleEditingController.text = titleStorage.tempValue;
    familiarityAlgorithmEditingController.text = familiarityAlgorithmStorage.tempValue;
    nextTimeAlgorithmEditingController.text = nextTimeAlgorithmStorage.tempValue;
    buttonAlgorithmEditingController.text = buttonAlgorithmStorage.tempValue;
  }

  void changeTo({required MemoryModelGizmoEditPageType type}) {
    editPageType.refreshEasy((oldValue) => type);
  }

  void changeKeyword() {
    isAlgorithmKeyboard.refreshEasy((oldValue) => !oldValue);
    final pf = FocusManager.instance.primaryFocus;
    if (pf == null) return;
    pf.unfocus();
    Future.delayed(const Duration(milliseconds: 100), () => pf.requestFocus());
  }
}
