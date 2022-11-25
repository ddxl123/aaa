import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class FragmentHomeAbController extends AbController {
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: Navigator.of(context));
  }
}
