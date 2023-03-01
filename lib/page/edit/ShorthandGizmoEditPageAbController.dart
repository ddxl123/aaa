import 'dart:convert';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../list/ShorthandListPageAbController.dart';

class ShorthandGizmoEditPageAbController extends AbController {
  ShorthandGizmoEditPageAbController({required this.initShorthand});

  final quillController = q.QuillController.basic();

  final Shorthand? initShorthand;

  String getCurrentContent() => jsonEncode(quillController.document.toDelta().toJson());

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
      await db.insertDAO.insertShorthand(
        shorthandsCompanion: Crt.shorthandsCompanion(
          content: getCurrentContent(),
          creator_user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
        ),
        syncTag: null,
      );
      await Aber.findOrNull<ShorthandListPageAbController>()?.refreshPage();
      SmartDialog.showToast("创建成功！");
    } else {
      if (getCurrentContent() != initShorthand!.content) {
        await db.updateDAO.resetShorthand(
          syncTag: null,
          originalShorthandReset: (SyncTag resetSyncTag) async {
            return await initShorthand!.reset(
              content: getCurrentContent().toValue(),
              creator_user_id: Aber.find<GlobalAbController>().loggedInUser()!.id.toValue(),
              syncTag: null,
            );
          },
        );
        await Aber.findOrNull<ShorthandListPageAbController>()?.refreshPage();
        SmartDialog.showToast("修改成功！");
      } else {
        SmartDialog.showToast("无修改！");
      }
    }
  }

  @override
  Future<bool> backListener(bool hasRoute) async {
    if (getCurrentContent() == initShorthand?.content) {
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
