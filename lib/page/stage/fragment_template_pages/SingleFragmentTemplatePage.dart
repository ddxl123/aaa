import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoiceFragmentTemplate.dart';
import 'package:flutter/material.dart';

import '../../edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplate.dart';
import '../../edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoiceFragmentTemplatePreviewWidget.dart';
import '../../edit/FragmentGizmoEditPage/FragmentTemplate/template/question_answer/QAFragmentTemplate.dart';
import '../../edit/FragmentGizmoEditPage/FragmentTemplate/template/question_answer/QAFragmentTemplatePreviewWidget.dart';
import '../../edit/FragmentGizmoEditPage/FragmentTemplate/template/single/SimpleFragmentTemplate.dart';
import '../../edit/FragmentGizmoEditPage/FragmentTemplate/template/single/SimpleFragmentTemplatePreviewWidget.dart';

class SingleFragmentTemplatePage extends StatefulWidget {
  const SingleFragmentTemplatePage({super.key, required this.fragmentTemplate});

  final FragmentTemplate fragmentTemplate;

  @override
  State<SingleFragmentTemplatePage> createState() => _SingleFragmentTemplatePageState();
}

class _SingleFragmentTemplatePageState extends State<SingleFragmentTemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("预览"),
      ),
      body: FragmentTemplate.templateSwitch(
        widget.fragmentTemplate.fragmentTemplateType,
        questionAnswer: () {
          return QAFragmentTemplatePreviewWidget(qaFragmentTemplate: widget.fragmentTemplate as QAFragmentTemplate);
        },
        choice: () {
          return ChoiceFragmentTemplatePreviewWidget(choiceFragmentTemplate: widget.fragmentTemplate as ChoiceFragmentTemplate);
        },
        simple: () {
          return SimpleFragmentTemplatePreviewWidget(simpleFragmentTemplate: widget.fragmentTemplate as SimpleFragmentTemplate);
        },
      ),
    );
  }
}
