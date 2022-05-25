import 'dart:developer';

import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/home/fragmenthome/FragmentHomeGetController.dart';
import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/Extensioner.dart';
import 'package:aaa/tool/show/ShowWrapper.dart';
import 'package:aaa/tool/show/ShowXDialog.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:catcher/catcher.dart';
import 'package:drift/drift.dart';
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
  final FragmentHomeGetController _fragmentHomeGetController = Get.put(FragmentHomeGetController());

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
      body: SmartRefresher(
        controller: _fragmentHomeGetController.refreshController,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: _fragmentHomeGetController.fragments.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Text('_fragmentHomeGetController.fragmentOrGroupVOs[index]'),
            );
          },
        ),
        onRefresh: () async {
          await CatchRollback.call(
            body: () async {
              _fragmentHomeGetController.refreshController.refreshCompleted();
            },
            rollback: () {},
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
