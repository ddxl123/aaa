import 'dart:async';

import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class EnterType{
  final Type algorithmType;
  final
}

class MemoryModelGizmoEditPageAbController extends AbController {
  MemoryModelGizmoEditPageAbController({
    required this.originalMemoryModelAb,
  }) {
    copyMemoryModelAb = originalMemoryModelAb().copyWith().ab;
    titleEditingController.text = copyMemoryModelAb().title;
  }

  final Ab<MemoryModel> originalMemoryModelAb;

  late final Ab<MemoryModel> copyMemoryModelAb;

  final titleEditingController = TextEditingController();

  final currentEnterAlgorithmEditPageType = Ab<Type>(ButtonDataState);

  final isAlgorithmKeyboard = false.ab;

  T filterForEnterType<T>({
    required T Function() buttonDataState,
    required T Function() familiarityState,
    required T Function() nextShowTimeState,
    Abw? abw,
  }) {
    return filter(
      from: currentEnterAlgorithmEditPageType(abw),
      targets: {
        [ButtonDataState]: buttonDataState,
        [FamiliarityState]: buttonDataState,
        [NextShowTimeState]: nextShowTimeState,
      },
      orElse: null,
    );
  }

  @override
  Future<bool> backListener(bool hasRoute) async {
    if (originalMemoryModelAb() == copyMemoryModelAb()) {
      return false;
    }
    bool isBack = false;
    await showCustomDialog(
      builder: (_) => OkAndCancelDialogWidget(
        title: '是否要丢弃？',
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

  Future<void> save() async {
    final st = await SyncTag.create();
    await db.updateDAO.resetMemoryModel(
      originalMemoryModelReset: () async {
        await originalMemoryModelAb().resetByEntity(memoryModel: copyMemoryModelAb(), syncTag: st);
      },
      syncTag: st,
    );
    originalMemoryModelAb.refreshForce();
    SmartDialog.showToast("保存成功！");
  }

  void changeKeyword() {
    isAlgorithmKeyboard.refreshEasy((oldValue) => !oldValue);
    final pf = FocusManager.instance.primaryFocus;
    if (pf == null) return;
    pf.unfocus();
    Future.delayed(const Duration(milliseconds: 100), () => pf.requestFocus());
  }
}
