import 'dart:async';

import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class MemoryModelGizmoEditPageAbController extends AbController {
  MemoryModelGizmoEditPageAbController({required this.memoryModelGizmo, required this.editPageType});

  final Ab<MemoryModelGizmoEditPageType> editPageType;

  final Ab<MemoryModel>? memoryModelGizmo;

  final titleTextEditingController = TextEditingController();
  final title = ''.ab..initVerify({(v) async => v().trim() == '': '标题不能为空！'});

  final familiarityAlgorithmTextEditingController = TextEditingController();
  final familiarityAlgorithm = ''.ab..initVerify({(v) async => v().trim() == '': '熟悉度算法不能为空！'});

  final nextTimeAlgorithmTextEditingController = TextEditingController();
  final nextTimeAlgorithm = ''.ab..initVerify({(v) async => v().trim() == '': '下次展示时间点算法不能为空！'});

  final buttonDataTextEditingController = TextEditingController();
  final buttonData = ''.ab..initVerify({(v) async => v().trim() == '': '按钮数值分配不能为空！'});

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
  void dispose() {
    titleTextEditingController.dispose();
    familiarityAlgorithmTextEditingController.dispose();
    nextTimeAlgorithmTextEditingController.dispose();
    buttonDataTextEditingController.dispose();
    super.dispose();
  }

  @override
  Future<void> loadingFuture() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final mm = await DriftDb.instance.queryDAO.queryMemoryModelById(memoryModelId: memoryModelGizmo?.call().id);

    titleTextEditingController.text = mm?.title ?? '';
    title.refreshEasy((oldValue) => mm?.title ?? '');

    familiarityAlgorithmTextEditingController.text = mm?.familiarityAlgorithm ?? '';
    familiarityAlgorithm.refreshEasy((oldValue) => mm?.familiarityAlgorithm ?? '');

    nextTimeAlgorithmTextEditingController.text = mm?.nextTimeAlgorithm ?? '';
    nextTimeAlgorithm.refreshEasy((oldValue) => mm?.nextTimeAlgorithm ?? '');

    buttonDataTextEditingController.text = mm?.buttonData ?? '';
    buttonData.refreshEasy((oldValue) => mm?.buttonData ?? '');
  }

  @override
  Widget loadingWidget() {
    return const Material(
      child: Center(
        child: Text('加载中...'),
      ),
    );
  }

  Future<void> commit() async {
    Future<void> create() async {
      if (await verifyMany.isVerifyAllOk) {
        await DriftDb.instance.insertDAO.insertMemoryModel(
          WithCrts.memoryModelsCompanion(
            id: absent(),
            createdAt: absent(),
            updatedAt: absent(),
            title: () {
              title.refreshEasy((oldValue) => titleTextEditingController.text);
              return title();
            }(),
            familiarityAlgorithm: () {
              familiarityAlgorithm.refreshEasy((oldValue) => familiarityAlgorithmTextEditingController.text);
              return familiarityAlgorithm();
            }(),
            nextTimeAlgorithm: () {
              nextTimeAlgorithm.refreshEasy((oldValue) => nextTimeAlgorithmTextEditingController.text);
              return nextTimeAlgorithm();
            }(),
            buttonData: () {
              buttonData.refreshEasy((oldValue) => buttonDataTextEditingController.text);
              return buttonData();
            }(),
          ),
        );
        SmartDialog.showToast('创建成功');
        Navigator.pop(context);
      } else {
        SmartDialog.showToast(await verifyMany.failMessage);
      }
    }

    Future<void> modify({required bool isWithPop}) async {
      if (await verifyMany.isVerifyAllOk) {
        await memoryModelGizmo!.refreshComplex(
          (obj) async {
            await DriftDb.instance.updateDAO.resetMemoryModel(
              oldMemoryModelReset: (SyncTag resetSyncTag) async {
                await obj.reset(
                  id: absent(),
                  createdAt: absent(),
                  updatedAt: absent(),
                  title: () {
                    title.refreshEasy((oldValue) => titleTextEditingController.text);
                    return title().value();
                  }(),
                  familiarityAlgorithm: () {
                    familiarityAlgorithm.refreshEasy((oldValue) => familiarityAlgorithmTextEditingController.text);
                    return familiarityAlgorithm().value();
                  }(),
                  nextTimeAlgorithm: () {
                    nextTimeAlgorithm.refreshEasy((oldValue) => nextTimeAlgorithmTextEditingController.text);
                    return nextTimeAlgorithm().value();
                  }(),
                  buttonData: () {
                    buttonData.refreshEasy((oldValue) => buttonDataTextEditingController.text);
                    return buttonData().value();
                  }(),
                  writeSyncTag: await SyncTag.create(),
                );
              },
            );
            return true;
          },
        );

        SmartDialog.showToast('修改成功');
        if (isWithPop) Navigator.pop(context);
      } else {
        SmartDialog.showToast(await verifyMany.failMessage);
      }
    }

    await filterFuture(
      from: editPageType(),
      targets: {
        [MemoryModelGizmoEditPageType.create]: () async {
          await create();
        },
        [MemoryModelGizmoEditPageType.modify]: () async {
          await modify(isWithPop: false);
        },
      },
      orElse: null,
    );
  }

  void cancel({
    required FutureOr<void> Function()? onCancel,
    required FutureOr<void> Function()? onOk,
  }) {
    showOkAndCancel(
      context: context,
      title: '是否要丢弃？',
      okText: '丢弃',
      cancelText: '继续编辑',
      text: null,
      onOk: onOk,
      onCancel: onCancel,
    );
  }

  void changeTo({required MemoryModelGizmoEditPageType type}) {
    editPageType.refreshEasy((oldValue) => type);
  }
}
