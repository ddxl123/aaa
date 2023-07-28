import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/ChoiceFragmentTemplate.dart';
import 'package:flutter/material.dart';

import '../edit/FragmentGizmoEditPage/FragmentTemplate/template/QAFragmentTemplate.dart';

class SingleTemplateChoice extends StatelessWidget {
  const SingleTemplateChoice({super.key, required this.title, required this.onPressed});

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: TextButton(
              onPressed: onPressed,
              child: Text(title),
            ),
          ),
        ),
      ],
    );
  }
}

class TemplateChoice extends StatelessWidget {
  const TemplateChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("选择碎片制作模板"),
        actions: [TextButton(onPressed: () {}, child: const Text("请求制作"))],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SingleTemplateChoice(
              title: "问答",
              onPressed: () {
                Navigator.pop(context, QAFragmentTemplate());
              },
            ),
            SingleTemplateChoice(
              title: "选择",
              onPressed: () {
                Navigator.pop(context, ChoiceFragmentTemplate());
              },
            ),
          ],
        ),
      ),
    );
  }
}
