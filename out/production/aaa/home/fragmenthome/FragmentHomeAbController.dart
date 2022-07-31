import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FragmentHomeAbController extends AbController {
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: Navigator.of(context));
  }
}
