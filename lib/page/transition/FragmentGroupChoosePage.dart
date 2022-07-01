import 'package:aaa/page/create/CreateFragmentGroupPage.dart';
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
          // _confirm(context),
        ],
      ),
    );
  }

// FloatingRoundCornerButton _confirm(BuildContext context) {
//   return FloatingRoundCornerButton(
//     text: '确认选择',
//     onPressed: () {
//       final c = Aber.find<CreateFragmentPageAbController>();
//       Aber.findLast<FragmentGroupModelAbController>().currentPart().addFragment(FragmentsCompanion()..title = c.title.toDriftValue());
//       SmartDialog.showToast('创建成功', displayTime: const Duration(milliseconds: 1000));
//       Navigator.pop(context);
//       Navigator.pop(context);
//     },
//   );
// }
}
