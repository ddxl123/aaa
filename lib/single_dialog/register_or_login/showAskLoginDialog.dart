import 'package:aaa/push_page/push_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<void> showAskLoginDialog() async {
  await showCustomDialog(
    builder: (_) {
      return DialogWidget(
        mainVerticalWidgets: [
          Center(child: Text('     您还未登录       ', style: Theme.of(_).textTheme.titleLarge)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.tealAccent)),
                  child: const Text('登录'),
                  onPressed: () {
                    Navigator.pop(_);
                    pushToLoginPage(context: _);
                  },
                ),
              ),
            ],
          ),
          Center(
            child: TextButton(
              style: ButtonStyle(visualDensity: kMinVisualDensity),
              child: const Text('游客模式', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                SmartDialog.dismiss();
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
        bottomHorizontalButtonWidgets: const [],
      );
    },
  );
}
