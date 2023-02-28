import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../page/list/FragmentGroupListPageController.dart';

class HomeAbController extends AbController {
  final pageController = PageController();
  final currentPageIndex = 0.ab;
  final iconDatas = [Icons.home, Icons.add, FontAwesomeIcons.tencentWeibo, Icons.add];
  final labels = ['首页', '记忆', '碎片', '我的'];

  final isShowFloating = true.ab;

  // 双击返回键才会退出应用。
  Timer? timer;

  @override
  Future<bool> backListener(bool hasRoute) async {
    void timerCancel() {
      timer?.cancel();
      timer = null;
    }

    if (hasRoute) {
      timerCancel();
      return false;
    }

    final groupChainC = Aber.findOrNullLast<FragmentGroupListPageController>();
    if (groupChainC != null && groupChainC.groupChain().length > 1) {
      await groupChainC.backGroup();
      return true;
    }

    // if (isFragmentSelecting() == true) {
    //   timerCancel();
    //   isFragmentSelecting.refreshEasy((oldValue) => false);
    //   return true;
    // }
    if (timer == null) {
      const time = Duration(milliseconds: 1000);
      SmartDialog.showToast('再按一次退出！', displayTime: time);
      timer = Timer(time, () => timerCancel());
      return true;
    } else {
      return false;
    }
  }

  // 0-30,00-40,000-50,0000-60,00000-70
  double selectedCountDistance(FragmentGroupListPageController controller, [Abw? abw]) {
    // final count = controller.selectedFragment(abw).length;
    // if (count <= 9) return -30;
    // if (count > 9 && count < 100) return -40;
    // if (count > 99 && count < 1000) return -50;
    // if (count > 999 && count < 10000) return -60;
    // if (count > 9999 && count < 100000) return -70;
    return -80;
  }
}
