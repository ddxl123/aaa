import 'package:aaa/home/fragmenthome/FragmentHomeAbController.dart';
import 'package:aaa/page/list/ShorthandListPage.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';

import '../../page/list/FragmentGroupListSelfPage.dart';

class FragmentHome extends StatefulWidget {
  const FragmentHome({Key? key}) : super(key: key);

  @override
  State<FragmentHome> createState() => _FragmentHomeState();
}

class _FragmentHomeState extends State<FragmentHome> {
  @override
  Widget build(BuildContext context) {
    return AbBuilder<FragmentHomeAbController>(
      putController: FragmentHomeAbController(),
      builder: (putController, putAbw) {
        return Scaffold(
          appBar: CustomTabAppBar(
            tabController: putController.tabController,
            tabs: FragmentPageType.values.map(
              (e) {
                return Tab(text: e.text);
              },
            ).toList(),
          ),
          body: TabBarView(
            controller: putController.tabController,
            children: [
              KeepStateWidget(
                child: FragmentGroupListSelfPage(),
              ),
              KeepStateWidget(
                child: ShorthandListPage(),
              ),
            ],
          ),
        );
      },
    );
  }
}
