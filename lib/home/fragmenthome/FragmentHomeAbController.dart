import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

enum FragmentPageType {
  fragment(text: "知识碎片"),
  note(text: "笔记");

  const FragmentPageType({required this.text});

  final String text;
}

class FragmentHomeAbController extends AbController {
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: FragmentPageType.values.length, vsync: Navigator.of(context));
  }
}
