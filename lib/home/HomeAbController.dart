import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
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

  // 0-30,00-40,000-50,0000-60,00000-70
  double selectedCountDistance(FragmentGroupModelAbController controller, [Abw<FragmentGroupModelAbController>? abw]) {
    final count = controller.selectedFragmentIds(abw).length;
    if (count <= 9) return -30;
    if (count > 9 && count < 100) return -40;
    if (count > 99 && count < 1000) return -50;
    if (count > 999 && count < 10000) return -60;
    if (count > 9999 && count < 100000) return -70;
    return -80;
  }

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
