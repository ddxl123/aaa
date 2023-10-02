import 'dart:async';

import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
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
    required this.memoryModel,
  });

  final MemoryModel memoryModel;

  final titleEditingController = TextEditingController();

  final enterType = Ab<EnterType?>(null);

  final isAlgorithmKeyboard = false.ab;

  @override
  void onInit() {
    super.onInit();
    titleEditingController.text = memoryModel.title;
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
        [FamiliarityState]: familiarityStateFunc,
        [NextShowTimeState]: nextShowTimeStateFunc,
      },
      orElse: null,
    );
  }

  @override
  Future<bool> backListener(bool hasRoute) async {
    bool isBack = false;
    await showCustomDialog(
      builder: (_) => OkAndCancelDialogWidget(
        title: '若存在修改，则将其丢弃？',
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

  /// 将 [copyMemoryModelAb] 的数据传递给 [memoryModel]，并对数据库进行修改。
  Future<void> save() async {
    await requestSingleRowModify(
      isLoginRequired: true,
      singleRowModifyDto: SingleRowModifyDto(
        table_name: driftDb.memoryModels.actualTableName,
        row: memoryModel,
      ),
      onSuccess: (String showMessage, SingleRowModifyVo vo) async {
        SmartDialog.showToast("保存成功！");
        Navigator.pop(context);
      },
      onError: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );
  }

  void changeKeyword() {
    isAlgorithmKeyboard.refreshEasy((oldValue) => !oldValue);
    final pf = FocusManager.instance.primaryFocus;
    if (pf == null) return;
    pf.unfocus();
    Future.delayed(const Duration(milliseconds: 100), () => pf.requestFocus());
  }
}
