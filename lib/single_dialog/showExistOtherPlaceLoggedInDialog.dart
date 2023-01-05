import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 存在其他地方已登录。
///
/// 返回当前是否继续执行登录操作。
Future<bool> showExistOtherPlaceLoggedInDialog() async {
  bool isContinue = false;
  await showCustomDialog(
    clickMaskDismiss: false,
    builder: (_) => OkAndCancelDialogWidget(
      okText: "继续登录",
      title: "该用户已在其他地方登录！",
      text: "继续登录将会注销其他地方的登录",
      cancelText: "返回",
      onOk: () {
        isContinue = true;
        SmartDialog.dismiss();
      },
      onCancel: () {
        isContinue = false;
        SmartDialog.dismiss();
      },
    ),
  );
  return isContinue;
}
