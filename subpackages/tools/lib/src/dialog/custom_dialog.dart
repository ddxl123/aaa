import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/src/dialog/DialogWidget.dart';
import 'package:tools/src/dialog/OkAndCancelDialogWidget.dart';
import 'package:tools/src/dialog/TextField1DialogWidget.dart';

/// [builder] 请使用：
///  - [DialogWidget]
///  - [OkAndCancelDialogWidget]
///  - [TextField1DialogWidget]
///  ...
Future<void> showCustomDialog({
  required Widget Function(BuildContext context) builder,
  bool clickMaskDismiss = true,
  bool backDismiss = true,
}) async {
  return await SmartDialog.show(
    clickMaskDismiss: clickMaskDismiss,
    backDismiss: backDismiss,
    useSystem: true,
    builder: (_) => builder(_),
  );
}
