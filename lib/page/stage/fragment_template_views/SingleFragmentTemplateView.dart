import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/ChoiceFragmentTemplate.dart';
import 'package:flutter/material.dart';

import '../../edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplate.dart';
import '../../edit/FragmentGizmoEditPage/FragmentTemplate/template/QAFragmentTemplate.dart';

class SingleFragmentTemplateView extends StatefulWidget {
  const SingleFragmentTemplateView({super.key, required this.fragmentTemplate});

  final FragmentTemplate fragmentTemplate;

  @override
  State<SingleFragmentTemplateView> createState() => _SingleFragmentTemplateViewState();
}

class _SingleFragmentTemplateViewState extends State<SingleFragmentTemplateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("预览"),
      ),
      body: FragmentTemplate.templateSwitch(
        widget.fragmentTemplate.fragmentTemplateType,
        questionAnswer: () {
          return QAFragmentTemplateViewWidget(qaFragmentTemplate: widget.fragmentTemplate as QAFragmentTemplate);
        },
        choice: () {
          return ChoiceFragmentTemplateViewWidget(choiceFragmentTemplate: widget.fragmentTemplate as ChoiceFragmentTemplate);
        },
      ),
    );
  }
}
