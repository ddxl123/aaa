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
  final iconDatas = [Icons.home, FontAwesomeIcons.tencentWeibo, Icons.add, Icons.add];
  final labels = ['首页', '碎片', '记忆', '我的'];

  final isShowFloating = true.ab;

  // 双击返回键才会退出应用。
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    BackButtonInterceptor.add(_homeBack, context: context);
  }

  @override
  void onDispose() {
    BackButtonInterceptor.remove(_homeBack);
    super.onDispose();
  }

  /// 注意按照顺序。
  ///
  /// 返回 true 则拦截，否则不拦截，拦截意味着当前 route 不触发 pop。
  Future<bool> _homeBack(bool stopDefaultButtonEvent, RouteInfo routeInfo) async {
    void timerCancel() {
      timer?.cancel();
      timer = null;
    }

    // 如果一个对话框(或任何其他路由)是打开的，则不拦截。
    if (routeInfo.ifRouteChanged(context)) {
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
    final count = controller.selectedFragment(abw).length;
    if (count <= 9) return -30;
    if (count > 9 && count < 100) return -40;
    if (count > 99 && count < 1000) return -50;
    if (count > 999 && count < 10000) return -60;
    if (count > 9999 && count < 100000) return -70;
    return -80;
  }
}
