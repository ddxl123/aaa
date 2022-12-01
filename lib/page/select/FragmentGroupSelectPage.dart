import 'package:aaa/page/edit/FragmentGroupGizmoEditPage.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPageAbController.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../list/FragmentGroupListPage.dart';
import '../list/FragmentGroupListPageController.dart';

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
      body: FragmentGroupListPage(),
      floatingActionButton: FloatingRoundCornerButton(
        text: const Text('确认选择'),
        onPressed: () async {
          final c = Aber.find<FragmentGizmoEditPageAbController>();
          final clp = Aber.findLast<FragmentGroupListPageController>();
          // await clp.currentPart().addFragment(
          //       willFragment: WithCrts.fragmentsCompanion(
          //         fatherFragmentId: (clp.currentPart().fatherFragmentGroup?.call().id).toValue(),
          //         content: c.title,
          //       ),
          //     );
          SmartDialog.showToast('创建成功', displayTime: const Duration(milliseconds: 1000));
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingRoundCornerButtonLocation(context: context, offset: const Offset(0, -50)),
    );
  }
}
