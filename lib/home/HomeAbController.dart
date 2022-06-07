import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';

class HomeAbController extends AbController {
  final pageController = PageController();
  final currentPageIndex = 0.ab;

  // 双击返回键才会退出应用。
  int? lastBackTime;

  Future<bool> onWillPop() async {
    // 双击返回键才会退出应用。
    int now = DateTime.now().millisecondsSinceEpoch;
    if (lastBackTime != null && now - lastBackTime! < 1500) {
      return true;
    }
    lastBackTime = now;
    Toaster.show(content: '再按一次退出！', milliseconds: 1500);
    await Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        lastBackTime = null;
      },
    );
    return false;
  }

  @override
  void onInit() {
    Toaster.init(context);
  }
}
