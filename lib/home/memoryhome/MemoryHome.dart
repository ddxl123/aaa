import 'package:aaa/home/memoryhome/MemoryHomeAbController.dart';
import 'package:aaa/page/list/ListPageType.dart';
import 'package:aaa/page/list/MemoryModeListPage.dart';
import 'package:tools/tools.dart';
import 'package:aaa/page/list/MemoryGroupListPage.dart';
import 'package:flutter/material.dart';

import '../../single_dialog/single_dialog.dart';

class MemoryHome extends StatefulWidget {
  const MemoryHome({Key? key}) : super(key: key);

  @override
  State<MemoryHome> createState() => _MemoryHomeState();
}

class _MemoryHomeState extends State<MemoryHome> {
  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryHomeAbController>(
      putController: MemoryHomeAbController(),
      builder: (putController, putAbw) {
        return Scaffold(
          appBar: CustomAppBar(
            tabController: putController.tabController,
            tabs: const [
              Tab(text: '记忆组'),
              Tab(text: '算法'),
              Tab(text: '统计'),
            ],
            otherWidgets: [
              CustomDropdownBodyButton(
                initValue: 0,
                primaryButton: const Icon(Icons.more_horiz),
                itemAlignment: Alignment.centerLeft,
                items: [
                  Item(value: 0, text: '创建记忆组'),
                ],
                onChanged: (v) {
                  showDialogForCreateMemoryGroup();
                },
              ),
            ],
          ),
          body: TabBarView(
            controller: putController.tabController,
            children: [
              KeepStateWidget(
                builder: (ctx) => const MemoryGroupListPage(),
              ),
              KeepStateWidget(
                builder: (_) => const MemoryModeListPage(listPageType: ListPageType.home),
              ),
              KeepStateWidget(
                builder: (_) => const Text('统计'),
              ),
            ],
          ),
        );
      },
    );
  }
}
