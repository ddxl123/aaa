import 'dart:convert';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../list/ShorthandListPageAbController.dart';

class ShorthandGizmoEditPageAbController extends AbController {
  ShorthandGizmoEditPageAbController({required this.initShorthand});

  final user = Aber.find<GlobalAbController>().loggedInUser()!;

  final quillController = q.QuillController.basic();

  /// 为 null 则为插入。
  final Shorthand? initShorthand;

  String getCurrentContentJsonString() => jsonEncode(quillController.document.toDelta().toJson());

  @override
  void onInit() {
    super.onInit();
    if (initShorthand != null) {
      quillController.document = q.Document.fromJson(jsonDecode(initShorthand!.content));
    }
  }

  @override
  void onDispose() {
    quillController.dispose();
    super.onDispose();
  }

  Future<void> save() async {
    if (initShorthand == null) {
      await requestSingleRowInsert(
        isLoginRequired: true,
        singleRowInsertDto: SingleRowInsertDto(
          table_name: driftDb.shorthands.actualTableName,
          row: Crt.shorthandEntity(
            content: getCurrentContentJsonString(),
            creator_user_id: user.id,
          ),
        ),
        onSuccess: (String showMessage, SingleRowInsertVo vo) async {
          SmartDialog.showToast("保存成功！");
        },
        onError: (a, b, c) async {
          logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
        },
      );
    } else {
      await requestSingleRowModify(
        isLoginRequired: true,
        singleRowModifyDto: SingleRowModifyDto(
          table_name: driftDb.shorthands.actualTableName,
          row: initShorthand!..content = getCurrentContentJsonString(),
        ),
        onSuccess: (String showMessage, SingleRowModifyVo vo) async {
          SmartDialog.showToast("保存成功！");
        },
        onError: (a, b, c) async {
          logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
        },
      );
    }
  }

  @override
  Future<bool> backListener(bool hasRoute) async {
    if (getCurrentContentJsonString() == initShorthand?.content) {
      SmartDialog.showToast("无修改！");
      return false;
    }
    if (initShorthand == null && quillController.document.toPlainText().trim() == "") {
      return false;
    }
    bool isPop = false;
    await showCustomDialog(
      builder: (_) => OkAndCancelDialogWidget(
        title: "存在修改未保存，是否要保存？",
        cancelText: "不保存",
        okText: "保存并返回",
        onOk: () async {
          await save();
          SmartDialog.dismiss(status: SmartStatus.dialog);
          isPop = true;
        },
        onCancel: () {
          SmartDialog.dismiss(status: SmartStatus.dialog);
          isPop = true;
        },
      ),
    );
    return !isPop;
  }
}
