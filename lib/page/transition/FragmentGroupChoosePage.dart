import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/page/create/CreateFragmentGroupPage.dart';
import 'package:aaa/page/create/CreateFragmentPageAbController.dart';
import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/FragmentGroupModel.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
import 'package:flutter/material.dart';

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
      body: Stack(
        children: [
          const FragmentGroupModel(modelType: FragmentGroupModelType.add),
          _confirm(context),
        ],
      ),
    );
  }

  Positioned _confirm(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.tealAccent),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
            ),
            child: const Text('确认选择'),
            onPressed: () {
              final c = Aber.find<CreateFragmentPageAbController>();
              Aber.findLast<FragmentGroupModelAbController>().currentPart().addFragment(FragmentsCompanion()..title = c.title.toDriftValue());
              Toaster.show(content: '创建成功', milliseconds: 1000);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
