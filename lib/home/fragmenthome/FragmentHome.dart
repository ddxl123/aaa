import 'package:aaa/home/fragmenthome/FragmentHomeAbController.dart';
import 'package:aaa/page/edit/FragmentGroupGizmoEditPage.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage.dart';
import 'package:tools/tools.dart';
import 'package:aaa/page/list/FragmentGroupListPage.dart';
import 'package:aaa/page/list/ListPageType.dart';
import 'package:aaa/page/list/MemoryModeListPage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class FragmentHome extends StatefulWidget {
  const FragmentHome({Key? key}) : super(key: key);

  @override
  State<FragmentHome> createState() => _FragmentHomeState();
}

class _FragmentHomeState extends State<FragmentHome> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AbBuilder<FragmentHomeAbController>(
      putController: FragmentHomeAbController(),
      builder: (putController, putAbw) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kMinInteractiveDimension),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TabBar(
                    isScrollable: true,
                    indicatorWeight: 5,
                    controller: putController.tabController,
                    tabs: const [
                      Tab(
                        text: '碎片',
                      ),
                      Tab(
                        text: '算法',
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          body: TabBarView(
            controller: putController.tabController,
            children: [
              KeepStateWidget(
                builder: (_) => const FragmentGroupListPage(listPageType: ListPageType.home),
              ),
              KeepStateWidget(
                builder: (_) => const MemoryModeListPage(listPageType: ListPageType.home),
              ),
            ],
          ),
        );
      },
    );
  }
}
