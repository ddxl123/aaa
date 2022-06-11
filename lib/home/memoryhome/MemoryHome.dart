import 'package:aaa/home/memoryhome/MemoryHomeAbController.dart';
import 'package:aaa/page/create/CreateMemoryGroupPage.dart';
import 'package:aaa/tool/WidgetWrapper.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/MemoryGroupModel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
                builder: (ctx) => const MemoryGroupModel(),
              ),
              const Tab(text: '111'),
            ],
          ),
        );
      },
    );
  }
}
