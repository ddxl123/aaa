import 'package:flutter/material.dart';

import '../edit/FragmentGizmoEditPage/FragmentTemplate/QAFragmentTemplate.dart';

class TemplateChoice extends StatelessWidget {
  const TemplateChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("选择碎片制作模板"),
        actions: [TextButton(onPressed: () {}, child: Text("请求制作"))],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextButton(
                      child: Text("问答"),
                      onPressed: () {
                        Navigator.pop(context, QAFragmentTemplate());
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextButton(
                      child: Text("选择"),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
