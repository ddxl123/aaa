import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<T?> showWrapperInput<T>({
  required BuildContext context,
  required List<DialogTextField> textFields,
  String? title,
  String? message,
  required String? okLabel,
  required String? cancelLabel,
  required FutureOr<T> Function(String firstContent) firstHandle,
  FutureOr<T> Function()? cancelHandle,
}) async {
  final List<String>? result = await showTextInputDialog(
    context: context,
    textFields: textFields,
    title: title,
    message: message,
    okLabel: okLabel,
    cancelLabel: cancelLabel,
    isDestructiveAction: true,
  );
  if (result != null && result.isNotEmpty && result.first.trim().isNotEmpty) {
    return firstHandle(result.first);
  }
  await cancelHandle?.call();
  return null;
}
