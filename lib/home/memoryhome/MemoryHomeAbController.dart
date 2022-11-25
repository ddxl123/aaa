import 'package:tools/tools.dart';
import 'package:flutter/material.dart';

class MemoryHomeAbController extends AbController {
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: Navigator.of(context));
  }
}
