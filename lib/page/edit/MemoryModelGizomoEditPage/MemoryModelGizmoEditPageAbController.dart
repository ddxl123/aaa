import 'dart:async';

import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

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

  final isAlgorithmKeyboard = false.ab;

  @override
  Future<bool> backListener(bool hasRoute) async {
    if (originalMemoryModelAb() == copyMemoryModelAb()) {
      return false;
    }
    await showCustomDialog(
      builder: (_) => OkAndCancelDialogWidget(
        title: '是否要丢弃？',
        okText: '丢弃',
        cancelText: '继续编辑',
        text: null,
        onOk: () async {
          // await db.updateDAO.resetMemoryModelOnlySave(originalMemoryModelReset: originalMemoryModelReset, syncTag: syncTag)
          originalMemoryModelAb.refreshForce();
        },
        onCancel: () {
          SmartDialog.dismiss();
        },
      ),
    );
    return true;
  }

  void changeKeyword() {
    isAlgorithmKeyboard.refreshEasy((oldValue) => !oldValue);
    final pf = FocusManager.instance.primaryFocus;
    if (pf == null) return;
    pf.unfocus();
    Future.delayed(const Duration(milliseconds: 100), () => pf.requestFocus());
  }
}
