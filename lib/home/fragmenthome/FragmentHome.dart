import 'package:aaa/home/fragmenthome/FragmentHomeAbController.dart';
import 'package:aaa/page/edit/FragmentGroupGizmoEditPage.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage.dart';
import 'package:aaa/page/list/FragmentGroupListPage.dart';
import 'package:tools/tools.dart';
import 'package:aaa/page/list/FragmentGroupListPage111.dart';
import 'package:aaa/page/list/ListPageType.dart';
import 'package:aaa/page/list/MemoryModeListPage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

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
          appBar: CustomAppBar(
            tabController: putController.tabController,
            tabs: const [
              Tab(
                text: '碎片',
              ),
              Tab(
                text: '笔记',
              ),
              Tab(
                text: '文档',
              ),
            ],
          ),
          body: TabBarView(
            controller: putController.tabController,
            children: [
              KeepStateWidget(
                builder: (_) => const FragmentGroupListPage(),
              ),
              KeepStateWidget(
                builder: (_) => const Text('笔记'),
              ),
              KeepStateWidget(
                builder: (_) => const Text('文档'),
              ),
            ],
          ),
        );
      },
    );
  }
}
