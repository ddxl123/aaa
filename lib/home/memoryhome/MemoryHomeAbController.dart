import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';

class MemoryHomeAbController extends AbController {
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: Navigator.of(context));
  }
}
