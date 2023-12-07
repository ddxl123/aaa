import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoiceFragmentTemplate.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/single/SimpleFragmentTemplate.dart';
import 'package:flutter/material.dart';

import '../edit/FragmentGizmoEditPage/FragmentTemplate/template/question_answer/QAFragmentTemplate.dart';

class SingleTemplateChoicePage extends StatelessWidget {
  const SingleTemplateChoicePage({
    super.key,
    required this.title,
    required this.explain,
    required this.onTap,
  });

  final String title;
  final String explain;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(height: 5),
                    Text(explain, style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
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
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("请选择一种模板"),
        actions: [TextButton(onPressed: () {}, child: const Text("求助制作"))],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SingleTemplateChoicePage(
              title: "单面碎片",
              explain: "只有一面",
              onTap: () {
                Navigator.pop(context, SimpleFragmentTemplate());
              },
            ),
            SingleTemplateChoicePage(
              title: "问答题",
              explain: "有问有答",
              onTap: () {
                Navigator.pop(context, QAFragmentTemplate());
              },
            ),
            SingleTemplateChoicePage(
              title: "选择题",
              explain: "单选或多选",
              onTap: () {
                Navigator.pop(context, ChoiceFragmentTemplate());
              },
            ),
            SingleTemplateChoicePage(
              title: "判断题",
              explain: "只有对与错",
              onTap: () {
                Navigator.pop(context, ChoiceFragmentTemplate());
              },
            ),
            SingleTemplateChoicePage(
              title: "填空题",
              explain: "将挖空部分隐藏",
              onTap: () {
                Navigator.pop(context, ChoiceFragmentTemplate());
              },
            ),
          ],
        ),
      ),
    );
  }
}
