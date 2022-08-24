import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';

enum OkBackType {
  none,
  onlyDismiss,
  dismissAndPop,
}

enum TitleSize {
  large,
  medium,
  small,
}

/// 对应的值为 null 时，将不会显示对应的 widget。
///
/// [customWidget] 在 [title]、[text] 下方。
///
/// [okBack] 在调用 back 之前调用。
Future<void> showDialogCustom({
  required BuildContext context,
  String? title,
  TitleSize titleSize = TitleSize.large,
  String? text,
  Widget? customWidget,
  String? okText,
  String? cancelText,
  required FutureOr<OkBackType> Function() okBack,
}) async {
  await SmartDialog.show(
    builder: (BuildContext _) {
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
                            children: [
                              title == null
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            title,
                                            style: TextStyle(
                                                fontSize: filter(
                                                  from: titleSize,
                                                  targets: {
                                                    [TitleSize.large]: () => Theme.of(context).textTheme.titleLarge!.fontSize,
                                                    [TitleSize.medium]: () => Theme.of(context).textTheme.titleMedium!.fontSize,
                                                    [TitleSize.small]: () => Theme.of(context).textTheme.titleSmall!.fontSize,
                                                  },
                                                  orElse: null,
                                                ),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                              text == null ? Container() : const SizedBox(height: 10),
                              text == null
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [Expanded(child: Text(text))],
                                    ),
                              customWidget == null && (title != null || text != null) ? Container() : const SizedBox(height: 10),
                              customWidget ?? Container(),
                            ],
                          ),
                        ),
                      ),
                      cancelText == null && okText == null
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(width: 50),
                                cancelText == null
                                    ? Container()
                                    : TextButton(
                                        child: Text(cancelText),
                                        onPressed: () {
                                          SmartDialog.dismiss();
                                        },
                                      ),
                                const SizedBox(width: 10),
                                okText == null
                                    ? Container()
                                    : TextButton(
                                        child: Text(okText, style: const TextStyle(color: Colors.red)),
                                        onPressed: () async {
                                          final result = await okBack.call();
                                          filter(
                                            from: result,
                                            targets: {
                                              [OkBackType.none]: () => null,
                                              [OkBackType.onlyDismiss]: () {
                                                SmartDialog.dismiss();
                                              },
                                              [OkBackType.dismissAndPop]: () {
                                                SmartDialog.dismiss();
                                                Navigator.pop(context);
                                              }
                                            },
                                            orElse: null,
                                          );
                                        },
                                      ),
                              ],
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
