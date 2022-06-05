import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';

class HomeAbController extends AbController {
  final pageController = PageController();
  final currentPageIndex = 0.ab;

  // 双击返回键才会退出应用。
  // int? lastBackTime;

  @override
  void onInit() {
    Toaster.init(context);
  }
}
