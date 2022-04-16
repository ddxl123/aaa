import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toaster {
  static final FToast _fToast = FToast();

  static void init(BuildContext context) {
    _fToast.init(context);
  }

  static void show({required String content, required int milliseconds}) {
    Widget toastWidget = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 12.0),
          Text(content),
        ],
      ),
    );

    _fToast.showToast(child: toastWidget, toastDuration: Duration(milliseconds: milliseconds), gravity: ToastGravity.TOP);
  }
}
