import 'dart:async';

import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class EnterType {
  EnterType({
    required this.algorithmType,
    required this.algorithmUsageStatus,
  });

  final Type algorithmType;
  final AlgorithmUsageStatus algorithmUsageStatus;
}

class MemoryModelGizmoEditPageAbController extends AbController {
  MemoryModelGizmoEditPageAbController({
    required this.originalMemoryModelAb,
  });

  final Ab<MemoryModel> originalMemoryModelAb;

  late final Ab<MemoryModel> copyMemoryModelAb;

  final titleEditingController = TextEditingController();

  final enterType = Ab<EnterType?>(null);

  final isAlgorithmKeyboard = false.ab;

  @override
  void onInit() {
    super.onInit();
    copyMemoryModelAb = originalMemoryModelAb().copyWith().ab;
    titleEditingController.text = copyMemoryModelAb().title;
  }

  T filterForStatus<T>({
    required AlgorithmUsageStatus algorithmUsageStatus,
    required T Function() aFunc,
    required T Function() bFunc,
    required T Function() cFunc,
    Abw? abw,
  }) {
    return filter(
      from: algorithmUsageStatus,
      targets: {
        [AlgorithmUsageStatus.a]: aFunc,
        [AlgorithmUsageStatus.b]: bFunc,
        [AlgorithmUsageStatus.c]: cFunc,
      },
      orElse: null,
    );
  }

  T filterForType<T>({
    required Type algorithmType,
    required T Function() buttonDataStateFunc,
    required T Function() familiarityStateFunc,
    required T Function() nextShowTimeStateFunc,
    Abw? abw,
  }) {
    return filter(
      from: algorithmType,
      targets: {
        [ButtonDataState]: buttonDataStateFunc,
        [FamiliarityState]: buttonDataStateFunc,
        [NextShowTimeState]: nextShowTimeStateFunc,
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

  /// 将 [copyMemoryModelAb] 的数据传递给 [originalMemoryModelAb]，并对数据库进行修改。
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
