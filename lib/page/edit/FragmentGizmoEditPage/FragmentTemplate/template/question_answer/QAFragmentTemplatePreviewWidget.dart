import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/question_answer/QAFragmentTemplateInAppStageWidget.dart';
import 'package:flutter/material.dart';

import '../../base/FragmentTemplatePreviewWidget.dart';
import '../../base/SingleQuillPreviewWidget.dart';
import '../../base/TemplateViewChunkWidget.dart';
import 'QAFragmentTemplate.dart';

/// 问答题预览状态下的 Widget。
class QAFragmentTemplatePreviewWidget extends StatefulWidget {
  const QAFragmentTemplatePreviewWidget({super.key, required this.qaFragmentTemplate});

  final QAFragmentTemplate qaFragmentTemplate;

  @override
  State<QAFragmentTemplatePreviewWidget> createState() => _QAFragmentTemplatePreviewWidgetState();
}

class _QAFragmentTemplatePreviewWidgetState extends State<QAFragmentTemplatePreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return QAFragmentTemplateInAppStageWidget(
      qaFragmentTemplate: widget.qaFragmentTemplate,
    );
  }
}
