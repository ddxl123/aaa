import 'package:aaa/page/list/ListPageType.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:aaa/page/edit/FragmentGroupGizmoEditPage.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPageAbController.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/widget_wrapper/FloatingRoundCornerButton.dart';
import 'package:aaa/page/list/FragmentGroupListPage.dart';
import 'package:aaa/page/list/FragmentGroupListPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class FragmentGroupSelectPage extends StatelessWidget {
  const FragmentGroupSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('选择位置'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (mpr) => const FragmentGroupGizmoEditPage()));
            },
          ),
        ],
      ),
      body: const FragmentGroupListPage(listPageType: ListPageType.selectPath),
      floatingActionButton: FloatingRoundCornerButton(
        text: '确认选择',
        onPressed: () async {
          final c = Aber.find<FragmentGizmoEditPageAbController>();
          await Aber.findLast<FragmentGroupListPageAbController>().currentPart().addFragment(FragmentsCompanion()..title = c.title.value());
          SmartDialog.showToast('创建成功', displayTime: const Duration(milliseconds: 1000));
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingRoundCornerButtonLocation(context: context, offset: const Offset(0, -50)),
    );
  }
}