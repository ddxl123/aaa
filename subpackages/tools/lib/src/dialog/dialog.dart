import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

void showTextField1({
  required BuildContext context,
  required String? title,
  required String? text,
  required String hintText,
  required String cancelText,
  required String okText,
  required FutureOr<void> Function(TextEditingController tec)? onOk,
  required FutureOr<void> Function()? onCancel,
}) {
  final tec = TextEditingController();
  showDialogCustom(
    context: context,
    textsBody: [
      ..._titleAndTextList(context: context, title: title, text: text),
      Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: FocusNode()..requestFocus(),
              controller: tec,
              decoration: InputDecoration(hintText: hintText),
            ),
          ),
        ],
      ),
    ],
    buttonsBody: [
      ..._okAndCancelButtonList(
        cancelText: cancelText,
        okText: okText,
        onOk: () async {
          await onOk?.call(tec);
          tec.dispose();
        },
        onCancel: () async {
          await onCancel?.call();
          tec.dispose();
        },
      ),
    ],
  );
}

void showOkAndCancel({
  required BuildContext context,
  required String? title,
  required String? text,
  required String cancelText,
  required String okText,
  required FutureOr<void> Function()? onCancel,
  required FutureOr<void> Function()? onOk,
}) {
  showDialogCustom(
    context: context,
    textsBody: [..._titleAndTextList(context: context, title: title, text: text)],
    buttonsBody: [..._okAndCancelButtonList(cancelText: cancelText, okText: okText, onOk: onOk, onCancel: onCancel)],
  );
}

void showDialogCustom({
  required BuildContext context,
  required List<Widget> textsBody,
  required List<Widget> buttonsBody,
}) {
  SmartDialog.show(
    backDismiss: false,
    builder: (_) {
      return Builder(
        builder: (ctx) {
          return AnimatedPadding(
            padding: MediaQuery.of(ctx).viewInsets + MediaQuery.of(context).padding,
            duration: const Duration(milliseconds: 100),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              constraints: const BoxConstraints(maxHeight: 800, maxWidth: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(spreadRadius: -5, offset: Offset(3, 3), blurRadius: 8)],
              ),
              child: IntrinsicHeight(
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // 文字部分
                            children: textsBody,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // 按钮部分
                        children: buttonsBody,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

List<Widget> _titleAndTextList({
  required BuildContext context,
  required String? title,
  required String? text,
}) {
  return [
    title == null ? Container() : _titleWidget(context: context, title: title),
    text == null ? Container() : const SizedBox(height: 10),
    text == null ? Container() : _textWidget(context: context, text: text),
  ];
}

Widget _titleWidget({
  required BuildContext context,
  required String title,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          title,
          style: TextStyle(fontSize: Theme.of(context).textTheme.titleMedium!.fontSize, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

Widget _textWidget({
  required BuildContext context,
  required String text,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [Expanded(child: Text(text))],
  );
}

List<Widget> _okAndCancelButtonList({
  required String cancelText,
  required String okText,
  required FutureOr<void> Function()? onCancel,
  required FutureOr<void> Function()? onOk,
}) {
  return [
    const SizedBox(width: 50),
    _cancelButtonWidget(cancelText: cancelText, onCancel: onCancel),
    const SizedBox(width: 10),
    _okButtonWidget(okText: okText, onOk: onOk),
  ];
}

Widget _cancelButtonWidget({
  required String cancelText,
  required FutureOr<void> Function()? onCancel,
}) {
  return TextButton(
    child: Text(cancelText),
    onPressed: () async {
      await onCancel?.call();
    },
  );
}

Widget _okButtonWidget({
  required String okText,
  required FutureOr<void> Function()? onOk,
}) {
  return TextButton(
    child: Text(okText, style: const TextStyle(color: Colors.red)),
    onPressed: () async {
      await onOk?.call();
    },
  );
}
