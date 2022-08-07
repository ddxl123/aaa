import 'package:aaa/home/memoryhome/MemoryHomeAbController.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/widget_wrapper/FloatingRoundCornerButton.dart';
import 'package:aaa/tool/widget_wrapper/KeepStateWidget.dart';
import 'package:aaa/widget_model/MemoryGroupPage.dart';
import 'package:flutter/material.dart';

class MemoryHome extends StatefulWidget {
  const MemoryHome({Key? key}) : super(key: key);

  @override
  State<MemoryHome> createState() => _MemoryHomeState();
}

class _MemoryHomeState extends State<MemoryHome> with SingleTickerProviderStateMixin<MemoryHome> {
  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryHomeAbController>(
      putController: MemoryHomeAbController(),
      builder: (putController, putAbw) {
        return Scaffold(
          appBar: TabBar(
            controller: putController.tabController,
            tabs: const [
              Tab(
                child: Text('记忆组', style: TextStyle(color: Colors.blue)),
              ),
              Tab(
                child: Text('统计', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          body: TabBarView(
            controller: putController.tabController,
            children: [
              KeepStateWidget(
                builder: (ctx) => const MemoryGroupPage(),
              ),
              const Tab(text: '111'),
            ],
          ),
          floatingActionButton: FloatingRoundCornerButton(
            text: '多组记忆',
            onPressed: () {},
          ),
          floatingActionButtonLocation: FloatingRoundCornerButtonLocation(context: context, offset: const Offset(0, -35)),
        );
      },
    );
  }
}
