import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'DialogWidget.dart';

/// 请结合 [showCustomDialog] 使用。
///
/// 带有 ok 和 cancel 的对话框。
class OkAndCancelDialogWidget extends StatelessWidget {
  const OkAndCancelDialogWidget({
    Key? key,
    this.title,
    this.text,
    this.columnChildren,
    this.topRightAction,
    this.bottomLiftAction,
    this.cancelLeftText,
    this.cancelText,
    this.okText,
    this.onCancelLeft,
    this.onCancel,
    this.onOk,
    this.topKeepWidget,
    this.bottomKeepWidget,
    this.crossAxisAlignment,
    this.dialogSize,
  }) : super(key: key);

  final String? title;
  final String? text;
  final Widget? topRightAction;
  final Widget? bottomLiftAction;
  final List<Widget>? columnChildren;
  final String? cancelLeftText;
  final String? cancelText;
  final String? okText;
  final FutureOr<void> Function()? onCancelLeft;
  final FutureOr<void> Function()? onCancel;
  final FutureOr<void> Function()? onOk;
  final Widget? topKeepWidget;
  final Widget? bottomKeepWidget;
  final CrossAxisAlignment? crossAxisAlignment;
  final DialogSize? dialogSize;

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: title,
      topRightAction: topRightAction,
      bottomLiftAction: bottomLiftAction,
      dialogSize: dialogSize,
      mainVerticalWidgets: [
        text == null ? Container() : const SizedBox(height: 10),
        text == null
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Expanded(child: Text(text!))],
              ),
        columnChildren == null ? Container() : const SizedBox(height: 5),
        ...(columnChildren ?? []),
      ],
      bottomHorizontalButtonWidgets: [
        cancelLeftText == null
            ? Container()
            : TextButton(
                child: Text(cancelLeftText!),
                onPressed: () async {
                  await onCancelLeft?.call();
                },
              ),
        cancelText == null
            ? Container()
            : TextButton(
                child: Text(cancelText!),
                onPressed: () async {
                  if (onCancel == null) {
                    SmartDialog.dismiss(status: SmartStatus.dialog);
                  } else {
                    await onCancel!.call();
                  }
                },
              ),
        cancelText == null ? Container() : const SizedBox(width: 10),
        okText == null
            ? Container()
            : TextButton(
                child: Text(okText!, style: const TextStyle(color: Colors.red)),
                onPressed: () async {
                  await onOk?.call();
                },
              ),
      ],
      topKeepWidget: topKeepWidget,
      bottomKeepWidget: bottomKeepWidget,
      allCrossAxisAlignment: crossAxisAlignment,
    );
  }
}
