import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeAbController extends AbController {
  final pageController = PageController();
  final currentPageIndex = 0.ab;
  final iconDatas = [Icons.home, FontAwesomeIcons.tencentWeibo, Icons.add, Icons.add];
  final labels = ['首页', '碎片', '记忆', '我的'];

  final isFragmentSelecting = false.ab;

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
