import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:aaa/tool/dialog.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';

class MemoryModelGizmoEditPageAbController extends AbController {
  MemoryModelGizmoEditPageAbController({required this.memoryModelGizmo, required this.editPageType});

  final MemoryModelGizmoEditPageType editPageType;

  final Ab<MemoryModel>? memoryModelGizmo;

  final titleTextEditingController = TextEditingController();
  final title = ''.ab..initVerify({(v) async => v().trim() == '': '标题不能为空！'});

  final familiarityAlgorithmTextEditingController = TextEditingController();
  final familiarityAlgorithm = ''.ab..initVerify({(v) async => v().trim() == '': '熟悉度算法不能为空！'});

  final nextTimeAlgorithmTextEditingController = TextEditingController();
  final nextTimeAlgorithm = ''.ab..initVerify({(v) async => v().trim() == '': '下次展示时间点算法不能为空！'});

  final buttonDataTextEditingController = TextEditingController();
  final buttonData = ''.ab..initVerify({(v) async => v().trim() == '': '按钮数值分配不能为空！'});

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final mm = await DriftDb.instance.singleDAO.queryMemoryModelById(memoryModelId: memoryModelGizmo?.call().id);

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

  VerifyMany get verifyMany {
    return filter(
      from: editPageType,
      targets: {
        [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () => VerifyMany(verifyMany: [title.verify]),
      },
      orElse: null,
    );
  }

  Future<void> commit() async {
    await filterFuture(
      from: editPageType,
      targets: {
        [MemoryModelGizmoEditPageType.create]: () async {
          if (await verifyMany.isVerifyAllOk) {
            await DriftDb.instance.singleDAO.insertMemoryModel(
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
            SmartDialog.showToast('创建成功');
            Navigator.pop(context);
          } else {
            SmartDialog.showToast(await verifyMany.failMessage);
          }
        },
        [MemoryModelGizmoEditPageType.modify]: () async {
          SmartDialog.showToast('无业务');
        },
      },
      orElse: null,
    );
  }

  void cancel() {
    showDialogCustom(
      context: context,
      title: '是否要丢弃？',
      okText: '丢弃',
      cancelText: '继续编辑',
      okBack: () => OkBackType.dismissAndPop,
    );
  }
}
