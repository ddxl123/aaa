import 'dart:async';

import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';

class MemoryModelGizmoEditPageAbController extends AbController {
  MemoryModelGizmoEditPageAbController({required this.memoryModelGizmo, required this.editPageType});

  final Ab<MemoryModelGizmoEditPageType> editPageType;

  final Ab<MemoryModel>? memoryModelGizmo;

  final title = ''.ab..initVerify({(v) async => v().trim() == '': '标题不能为空！'});
  String _title = '';
  final titleEditingController = TextEditingController();

  final familiarityAlgorithm = ''.ab..initVerify({(v) async => v().trim() == '': '熟悉度算法不能为空！'});
  String _familiarityAlgorithm = '';
  final familiarityAlgorithmEditingController = TextEditingController();

  final nextTimeAlgorithm = ''.ab..initVerify({(v) async => v().trim() == '': '下次展示时间点算法不能为空！'});
  String _nextTimeAlgorithm = '';
  final nextTimeAlgorithmEditingController = TextEditingController();

  final buttonData = ''.ab..initVerify({(v) async => v().trim() == '': '按钮数值分配不能为空！'});
  String _buttonData = '';
  final buttonDataEditingController = TextEditingController();

  VerifyMany get verifyMany {
    return filter(
      from: editPageType(),
      targets: {
        [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () => VerifyMany([title.verify]),
      },
      orElse: null,
    );
  }

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final mm = await DriftDb.instance.queryDAO.queryMemoryModelById(memoryModelId: memoryModelGizmo?.call().id);

    _title = mm?.title ?? '';
    _familiarityAlgorithm = mm?.familiarityAlgorithm ?? '';
    _nextTimeAlgorithm = mm?.nextTimeAlgorithm ?? '';
    _buttonData = mm?.buttonData ?? '';

    title.refreshEasy((oldValue) => _title);
    familiarityAlgorithm.refreshEasy((oldValue) => _familiarityAlgorithm);
    nextTimeAlgorithm.refreshEasy((oldValue) => _nextTimeAlgorithm);
    buttonData.refreshEasy((oldValue) => _buttonData);

    titleEditingController.text = _title;
    familiarityAlgorithmEditingController.text = _familiarityAlgorithm;
    nextTimeAlgorithmEditingController.text = _nextTimeAlgorithm;
    buttonDataEditingController.text = _buttonData;
  }

  @override
  Widget loadingWidget() {
    return const Material(
      child: Center(
        child: Text('加载中...'),
      ),
    );
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
          if (await verifyMany.isVerifyAllOk) {
            await DriftDb.instance.insertDAO.insertMemoryModel(
              WithCrts.memoryModelsCompanion(
                id: absent(),
                createdAt: absent(),
                updatedAt: absent(),
                title: title(),
                familiarityAlgorithm: familiarityAlgorithm(),
                nextTimeAlgorithm: nextTimeAlgorithm(),
                buttonData: buttonData(),
              ),
            );

            return Tuple2(t1: true, t2: '创建成功！');
          } else {
            return Tuple2(t1: false, t2: await verifyMany.failMessage);
          }
        },
        [MemoryModelGizmoEditPageType.modify]: () async {
          if (await verifyMany.isVerifyAllOk) {
            await memoryModelGizmo!.refreshComplex(
              (obj) async {
                await DriftDb.instance.updateDAO.resetMemoryModel(
                  oldMemoryModelReset: (SyncTag resetSyncTag) async {
                    await obj.reset(
                      id: absent(),
                      createdAt: absent(),
                      updatedAt: absent(),
                      title: title().value(),
                      familiarityAlgorithm: familiarityAlgorithm().value(),
                      nextTimeAlgorithm: nextTimeAlgorithm().value(),
                      buttonData: buttonData().value(),
                      writeSyncTag: await SyncTag.create(),
                    );
                  },
                );
                return true;
              },
            );

            return Tuple2(t1: true, t2: '修改成功！');
          } else {
            return Tuple2(t1: false, t2: await verifyMany.failMessage);
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
    buttonData.refreshEasy((oldValue) => _buttonData);

    titleEditingController.text = _title;
    familiarityAlgorithmEditingController.text = _familiarityAlgorithm;
    nextTimeAlgorithmEditingController.text = _nextTimeAlgorithm;
    buttonDataEditingController.text = _buttonData;
  }

  void changeTo({required MemoryModelGizmoEditPageType type}) {
    editPageType.refreshEasy((oldValue) => type);
  }
}
