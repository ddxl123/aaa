import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

/// 若 [okCallback] 为空，将触发两次pop。
Future<void> showDialogOkCancel({
  required BuildContext context,
  String? title,
  String? text,
  required String okText,
  required String cancelText,
  void Function()? okCallback,
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
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                                  : Text(
                                      title,
                                      style: TextStyle(fontSize: context.textTheme.titleMedium!.fontSize, fontWeight: FontWeight.bold),
                                    ),
                              const SizedBox(height: 10),
                              text == null
                                  ? Container()
                                  : Text(
                                      text,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(width: 50),
                          TextButton(
                            child: Text(cancelText),
                            onPressed: () {
                              SmartDialog.dismiss();
                            },
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            child: Text(okText, style: const TextStyle(color: Colors.red)),
                            onPressed: okCallback ??
                                () {
                                  SmartDialog.dismiss();
                                  Navigator.pop(context);
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
