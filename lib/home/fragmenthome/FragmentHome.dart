import 'package:aaa/home/fragmenthome/FragmentHomeAbController.dart';
import 'package:aaa/page/list/FragmentGroupListPage.dart';
import 'package:tools/tools.dart';
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
          appBar: CustomTabAppBar(
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
                child: FragmentGroupListPage(),
              ),
              KeepStateWidget(
                child: const Text('笔记'),
              ),
              KeepStateWidget(
                child: const Text('文档'),
              ),
            ],
          ),
        );
      },
    );
  }
}
