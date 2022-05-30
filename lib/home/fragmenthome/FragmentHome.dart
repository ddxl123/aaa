import 'dart:developer';

import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/home/fragmenthome/FragmentHomeGetController.dart';
import 'package:aaa/tool/Extensioner.dart';
import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/show/ShowWrapper.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../tool/CatchRollback.dart';

class FragmentHome extends StatefulWidget {
  const FragmentHome({Key? key}) : super(key: key);

  @override
  State<FragmentHome> createState() => _FragmentHomeState();
}

class _FragmentHomeState extends State<FragmentHome> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await showWrapperInput(
                title: '创建碎片组',
                context: context,
                textFields: [const DialogTextField(hintText: '碎片组名称')],
                okLabel: '创建',
                cancelLabel: '取消',
                firstHandle: (String firstContent) async {
                  await CatchRollback.call(
                    body: () async {
                      // await DriftDb.instance.singleDAO.insertFragmentGroup(FragmentGroupsCompanion(name: firstContent.toDriftValue()));
                      // await DriftDb.instance.singleDAO.updateFragmentGroup();
                      Toaster.show(content: '创建成功！', milliseconds: 2000);
                    },
                    rollback: () {
                      return '点击了创建';
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: AbBuilder(
        controller: FragmentHomeGetController(),
        builder: (FragmentHomeGetController controller, Abw<FragmentHomeGetController> abw) {
          return SmartRefresher(
            controller: controller.refreshController,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: controller.sections.get(abw).length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: AbBuilder<FragmentHomeGetController>(
                    builder: (c, cardAbw) {
                      print(index);
                      return Text(
                        controller.sections.get(abw).match<String, Ab<FragmentGroup>, Ab<Fragment>>(
                              index,
                              (a) => a.get(cardAbw).name.toString(),
                              (b) => b.get(cardAbw).id.toString(),
                            ),
                      );
                    },
                  ),
                );
              },
            ),
            onRefresh: () async {
              await CatchRollback.call(
                body: () async {
                  controller.refreshController.refreshCompleted();
                },
                rollback: () {},
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(100),
        child: FloatingActionButton(
          heroTag: 'ddddd',
          child: const Text('data'),
          onPressed: () {
            final con = Aber.find<FragmentHomeGetController>();
            con
                .sections(con)
                .value
                .first(con)
                .modify(con, (obj) => obj.value.id, (obj) => obj.value.id + 1, (obj, newValue) => obj.value.id = newValue)
                .refresh();
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
