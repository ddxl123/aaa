import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class FindHomeAbController extends AbController {
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: Navigator.of(context));
  }
}
