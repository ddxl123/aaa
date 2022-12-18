import 'dart:async';

import 'package:flutter/material.dart';

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
    required this.cancelText,
    required this.okText,
    this.onCancel,
    this.onOk,
    this.topKeepWidget,
    this.bottomKeepWidget,
    this.crossAxisAlignment,
  }) : super(key: key);

  final String? title;
  final String? text;
  final Widget? topRightAction;
  final Widget? bottomLiftAction;
  final List<Widget>? columnChildren;
  final String cancelText;
  final String okText;
  final FutureOr<void> Function()? onCancel;
  final FutureOr<void> Function()? onOk;
  final Widget? topKeepWidget;
  final Widget? bottomKeepWidget;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: title,
      topRightAction: topRightAction,
      bottomLiftAction: bottomLiftAction,
      mainVerticalWidgets: [
        text == null ? Container() : const SizedBox(height: 10),
        text == null
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Expanded(child: Text(text!))],
              ),
        columnChildren == null ? Container() : const SizedBox(height: 10),
        ...(columnChildren ?? []),
      ],
      bottomHorizontalButtonWidgets: [
        TextButton(
          child: Text(cancelText),
          onPressed: () async {
            await onCancel?.call();
          },
        ),
        const SizedBox(width: 10),
        TextButton(
          child: Text(okText, style: const TextStyle(color: Colors.red)),
          onPressed: () async {
            await onOk?.call();
          },
        ),
      ],
      topKeepWidget: topKeepWidget,
      bottomKeepWidget: bottomKeepWidget,
      crossAxisAlignment: crossAxisAlignment,
    );
  }
}
