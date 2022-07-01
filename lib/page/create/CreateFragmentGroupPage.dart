import 'package:aaa/page/create/CreateFragmentGroupPageAbController.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateFragmentGroupPage extends StatelessWidget {
  const CreateFragmentGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<CreateFragmentGroupPageAbController>(
      putController: CreateFragmentGroupPageAbController(),
      builder: (controller, abw) {
        return WillPopScope(
          onWillPop: () {
            controller.cancel();
            return Future(() => false);
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('创建碎片组'),
              leading: IconButton(
                icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.red),
                onPressed: () {
                  controller.cancel();
                },
              ),
              actions: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.check, color: Colors.green),
                  onPressed: () {
                    controller.commit();
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
                    decoration: const InputDecoration(border: InputBorder.none, hintText: '碎片组名称'),
                    onChanged: (text) {
                      controller.title = text;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
