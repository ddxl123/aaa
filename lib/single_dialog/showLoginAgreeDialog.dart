import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<void> showLoginAgreeDialog({required Ab<bool> isAgree}) async {
  await showCustomDialog(
    builder: (_) {
      return DialogWidget(
        mainVerticalWidgets: [
          const Center(child: Text('请阅读并同意以下条款')),
          const SizedBox(height: 20),
          Row(
            children: [
              TextButton(
                style: const ButtonStyle(
                  visualDensity: VisualDensity(vertical: VisualDensity.minimumDensity, horizontal: VisualDensity.minimumDensity),
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                ),
                child: const Text('《xxx协议》'),
                onPressed: () {},
              ),
              TextButton(
                style: const ButtonStyle(
                  visualDensity: VisualDensity(vertical: VisualDensity.minimumDensity, horizontal: VisualDensity.minimumDensity),
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                ),
                child: const Text('《个人信息保护指引》'),
                onPressed: () {},
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.tealAccent)),
                  child: const Text('同意并继续'),
                  onPressed: () {
                    isAgree.refreshEasy((oldValue) => true);
                    SmartDialog.dismiss();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
        bottomHorizontalButtonWidgets: const [],
      );
    },
  );
}
