import 'dart:async';

import 'package:aaa/home/fragmenthome/FragmentHomeAbController.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../page/list/FragmentGroupListPageController.dart';

enum PageType {
  home(text: "首页", icon: FontAwesomeIcons.fortAwesomeAlt),
  memory(text: "记忆", icon: FontAwesomeIcons.fantasyFlightGames),
  fragment(text: "碎片", icon: FontAwesomeIcons.puzzlePiece),
  mine(text: "我的", icon: FontAwesomeIcons.userAstronaut);

  const PageType({required this.text, required this.icon});

  final String text;
  final IconData icon;
}

class HomeAbController extends AbController {
  final pageController = PageController();
  final currentPageType = PageType.home.ab;
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

    if (currentPageType() == PageType.fragment && FragmentPageType.values[Aber.find<FragmentHomeAbController>().tabController.index] == FragmentPageType.fragment) {
      final groupChainC = Aber.findOrNullLast<FragmentGroupListPageController>();
      if (groupChainC != null && groupChainC.groupChain().length > 1) {
        await groupChainC.backGroup();
        return true;
      }

      if (groupChainC?.isUnitSelecting() == true) {
        timerCancel();
        groupChainC?.isUnitSelecting.refreshEasy((oldValue) => false);
        isShowFloating.refreshEasy((oldValue) => true);
        return true;
      }
    }

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
