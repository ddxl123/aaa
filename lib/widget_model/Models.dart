import 'package:aaa/page/create/CreateFragmentGroupPage.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';

import 'FragmentGroupModel.dart';
import 'FragmentGroupModelAbController.dart';

class FragmentGroupModelForAdd extends StatelessWidget {
  const FragmentGroupModelForAdd({Key? key}) : super(key: key);

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
          _confirm(),
        ],
      ),
    );
  }

  Positioned _confirm() {
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
              // controller.addFragment('title');
            },
          ),
        ),
      ),
    );
  }
}
