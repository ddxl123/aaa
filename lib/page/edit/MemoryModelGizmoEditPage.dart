import 'package:aaa/page/edit/MemoryModelGizmoEditPageAbController.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MemoryModelGizmoEditPage extends StatelessWidget {
  const MemoryModelGizmoEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      putController: MemoryModelGizmoEditPageAbController(),
      builder: (putController, putAbw) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.red),
              onPressed: () {
                putController.cancel();
              },
            ),
            title: const Text('创建记忆规则'),
            actions: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.check, color: Colors.green),
                onPressed: () {
                  putController.commit();
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              children: [
                TextField(
                  minLines: null,
                  maxLines: null,
                  autofocus: true,
                  decoration: const InputDecoration(border: InputBorder.none, hintText: '记忆规则名称'),
                  onChanged: (text) {
                    putController.title = text;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
