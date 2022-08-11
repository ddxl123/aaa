import 'package:aaa/page/edit/FragmentGizmoEditPageAbController.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FragmentGizmoEditPage extends StatelessWidget {
  const FragmentGizmoEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<FragmentGizmoEditPageAbController>(
      putController: FragmentGizmoEditPageAbController(),
      builder: (controller, abw) {
        return WillPopScope(
          onWillPop: () {
            controller.cancel();
            return Future(() => false);
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('创建碎片'),
              leading: IconButton(
                icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.red),
                onPressed: () {
                  controller.cancel();
                },
              ),
              actions: [
                TextButton(onPressed: () {}, child: const Text('存草稿')),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.tealAccent)),
                      child: const Text('创建'),
                      onPressed: () {
                        controller.commit();
                      },
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                // 屏幕高度-状态栏高度-appBar-padding
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - 20,
                child: Column(
                  children: [
                    TextField(
                      minLines: null,
                      maxLines: null,
                      autofocus: true,
                      style: const TextStyle(fontSize: 24),
                      decoration: const InputDecoration(border: InputBorder.none, hintText: '标题'),
                      onChanged: (value) {
                        controller.title = value;
                      },
                    ),
                    Expanded(
                      child: TextField(
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        decoration: const InputDecoration(border: InputBorder.none, hintText: '请输入内容'),
                        onChanged: (value) {
                          controller.content = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 100)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
