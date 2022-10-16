import 'dart:async';

import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';

class MemoryModelGizmoEditPageAbController extends AbController {
  MemoryModelGizmoEditPageAbController({required this.memoryModelGizmo, required this.editPageType});

  final Ab<MemoryModelGizmoEditPageType> editPageType;

  final Ab<MemoryModel?> memoryModelGizmo;

  /// [MemoryModels.title]
  final title = ''.ab;
  String _title = '';
  final titleEditingController = TextEditingController();

  /// [MemoryModels.familiarityAlgorithm]
  final familiarityAlgorithm = ''.ab;
  String _familiarityAlgorithm = '';
  final familiarityAlgorithmEditingController = TextEditingController();
  final familiarityAlgorithmFocusNode = FocusNode();

  String get hint => '';

  /// [MemoryModels.nextTimeAlgorithm]
  final nextTimeAlgorithm = ''.ab;
  String _nextTimeAlgorithm = '';
  final nextTimeAlgorithmEditingController = TextEditingController();

  /// [MemoryModels.buttonAlgorithm]
  final buttonDataAlgorithm = ''.ab;
  String _buttonDataAlgorithm = '';
  final buttonDataAlgorithmEditingController = TextEditingController();

  final allCheck = Ab(null);

  @override
  void initComplexVerifies() {
    title.initVerify(
      (abV) async {
        if (abV().trim() == '') {
          return VerifyResult(isOk: false, message: '标题不能为空！');
        }
        return null;
      },
    );
    familiarityAlgorithm.initVerify(
      (abV) async {
        final result = await AlgorithmParser().parse(
          state: FamiliarityState(
            content: familiarityAlgorithm(),
            simulationType: SimulationType.syntaxCheck,
            externalResultHandler: null,
          ),
        );
        if (result.throwMessage != null) return VerifyResult(isOk: false, message: result.throwMessage);
        return null;
      },
    );
    nextTimeAlgorithm.initVerify(
      (abV) async {
        final result = await AlgorithmParser().parse(
          state: NextShowTimeState(
            content: nextTimeAlgorithm(),
            simulationType: SimulationType.syntaxCheck,
            externalResultHandler: null,
          ),
        );
        if (result.throwMessage != null) return VerifyResult(isOk: false, message: result.throwMessage);
        return null;
      },
    );
    buttonDataAlgorithm.initVerify(
      (abV) async {
        final result = await AlgorithmParser().parse(
          state: ButtonDataState(
            content: buttonDataAlgorithm(),
            simulationType: SimulationType.syntaxCheck,
            externalResultHandler: null,
          ),
        );
        if (result.throwMessage != null) return VerifyResult(isOk: false, message: result.throwMessage);
        return null;
      },
    );
    allCheck.initVerify(
      (abV) async {
        await Simulator.auto(content: 'content');
      },
    );
  }

  Future<bool> get commitVerify {
    return filterFuture(
      from: editPageType(),
      targets: {
        [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () async => await AbVerify.checkMany(
              [
                title.verify,
              ],
            ),
      },
      orElse: null,
    );
  }

  Future<bool> get analyzeVerify async => await AbVerify.checkMany(
        [
          title.verify,
          familiarityAlgorithm.verify,
          nextTimeAlgorithm.verify,
          buttonDataAlgorithm.verify,
        ],
      );

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final mm = await DriftDb.instance.generalQueryDAO.queryMemoryModelById(memoryModelId: memoryModelGizmo()?.id);

    _title = mm?.title ?? '';
    _familiarityAlgorithm = mm?.familiarityAlgorithm ?? '';
    _nextTimeAlgorithm = mm?.nextTimeAlgorithm ?? '';
    _buttonDataAlgorithm = mm?.buttonAlgorithm ?? '';

    title.refreshEasy((oldValue) => _title);
    familiarityAlgorithm.refreshEasy((oldValue) => _familiarityAlgorithm);
    nextTimeAlgorithm.refreshEasy((oldValue) => _nextTimeAlgorithm);
    buttonDataAlgorithm.refreshEasy((oldValue) => _buttonDataAlgorithm);

    titleEditingController.text = _title;
    familiarityAlgorithmEditingController.text = _familiarityAlgorithm;
    nextTimeAlgorithmEditingController.text = _nextTimeAlgorithm;
    buttonDataAlgorithmEditingController.text = _buttonDataAlgorithm;
  }

  @override
  Widget loadingWidget() {
    return const Material(
      child: Center(
        child: Text('加载中...'),
      ),
    );
  }

  Future<bool> onlyAnalyze() async => await analyzeVerify;

  Future<void> analyzeWithHandle() async {
    if (await analyzeVerify) {
      SmartDialog.showToast('分析成功！');
    } else {
      SmartDialog.showToast('分析失败！');
    }
  }

  void commit() {
    _commit().then(
      (value) {
        filter(
          from: editPageType(),
          targets: {
            [MemoryModelGizmoEditPageType.create]: () {
              if (value.t1) {
                SmartDialog.showToast(value.t2);
                Navigator.pop(context);
              } else {
                SmartDialog.showToast(value.t2);
              }
            },
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
        [MemoryModelGizmoEditPageType.create]: () async {
          if (await commitVerify) {
            await DriftDb.instance.insertDAO.insertMemoryModel(
              WithCrts.memoryModelsCompanion(
                id: absent(),
                createdAt: absent(),
                updatedAt: absent(),
                title: title(),
                familiarityAlgorithm: familiarityAlgorithm(),
                nextTimeAlgorithm: nextTimeAlgorithm(),
                buttonAlgorithm: buttonDataAlgorithm(),
                // TODO
                applicableGroups: '',
                applicableFields: '',
                stimulateAlgorithm: '',
              ),
            );

            return Tuple2(t1: true, t2: '创建成功！');
          } else {
            return Tuple2(t1: false, t2: '创建失败！');
          }
        },
        [MemoryModelGizmoEditPageType.modify]: () async {
          if (await commitVerify) {
            await memoryModelGizmo.refreshComplex(
              (obj) async {
                await DriftDb.instance.updateDAO.resetMemoryModel(
                  oldMemoryModelReset: (SyncTag resetSyncTag) async {
                    await obj!.reset(
                      id: absent(),
                      createdAt: absent(),
                      updatedAt: absent(),
                      title: title().value(),
                      familiarityAlgorithm: familiarityAlgorithm().value(),
                      nextTimeAlgorithm: nextTimeAlgorithm().value(),
                      buttonAlgorithm: buttonDataAlgorithm().value(),
                      writeSyncTag: await SyncTag.create(),
                      // TODO
                      applicableGroups: ''.value(),
                      applicableFields: ''.value(),
                      stimulateAlgorithm: ''.value(),
                    );
                  },
                );
                return true;
              },
            );

            return Tuple2(t1: true, t2: '修改成功！');
          } else {
            return Tuple2(t1: false, t2: '修改失败');
          }
        },
      },
      orElse: null,
    );
  }

  void cancel() {
    showOkAndCancel(
      context: context,
      title: '是否要丢弃？',
      okText: '丢弃',
      cancelText: '继续编辑',
      text: null,
      onOk: () => filter(
        from: editPageType(),
        targets: {
          [MemoryModelGizmoEditPageType.create]: () {
            SmartDialog.dismiss();
            Navigator.pop(context);
          },
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
    );
  }

  void recovery() {
    title.refreshEasy((oldValue) => _title);
    familiarityAlgorithm.refreshEasy((oldValue) => _familiarityAlgorithm);
    nextTimeAlgorithm.refreshEasy((oldValue) => _nextTimeAlgorithm);
    buttonDataAlgorithm.refreshEasy((oldValue) => _buttonDataAlgorithm);

    titleEditingController.text = _title;
    familiarityAlgorithmEditingController.text = _familiarityAlgorithm;
    nextTimeAlgorithmEditingController.text = _nextTimeAlgorithm;
    buttonDataAlgorithmEditingController.text = _buttonDataAlgorithm;
  }

  void changeTo({required MemoryModelGizmoEditPageType type}) {
    editPageType.refreshEasy((oldValue) => type);
  }
}
