import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/page/create/CreateFragmentGroupPage.dart';
import 'package:aaa/page/create/CreateFragmentPageAbController.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/widget_wrapper/FloatingRoundCornerButton.dart';
import 'package:aaa/widget_model/FragmentGroupModel.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class FragmentGroupChoosePage extends StatelessWidget {
  const FragmentGroupChoosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('选择位置'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (mpr) => const CreateFragmentGroupPage()));
            },
          ),
        ],
      ),
      body: const FragmentGroupModel(modelType: FragmentGroupModelType.add),
      floatingActionButton: FloatingRoundCornerButton(
        text: '确认选择',
        onPressed: () async {
          final c = Aber.find<CreateFragmentPageAbController>();
          await Aber.findLast<FragmentGroupModelAbController>().currentPart().addFragment(FragmentsCompanion()..title = c.title.toDriftValue());
          SmartDialog.showToast('创建成功', displayTime: const Duration(milliseconds: 1000));
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingRoundCornerButtonLocation(context: context, offset: const Offset(0, -50)),
    );
  }
}
