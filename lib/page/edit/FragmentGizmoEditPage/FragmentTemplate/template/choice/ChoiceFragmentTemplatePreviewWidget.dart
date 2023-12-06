import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoiceFragmentTemplateInAppStageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../base/FragmentTemplatePreviewWidget.dart';
import '../../base/SingleQuillPreviewWidget.dart';
import '../../base/TemplateViewChunkWidget.dart';
import 'ChoiceFragmentTemplate.dart';
import 'ChoicePrefixType.dart';

/// 选择题预览状态下的 Widget。
class ChoiceFragmentTemplatePreviewWidget extends StatefulWidget {
  const ChoiceFragmentTemplatePreviewWidget({
    super.key,
    required this.choiceFragmentTemplate,
  });

  final ChoiceFragmentTemplate choiceFragmentTemplate;

  @override
  State<ChoiceFragmentTemplatePreviewWidget> createState() => _ChoiceFragmentTemplatePreviewWidgetState();
}

class _ChoiceFragmentTemplatePreviewWidgetState extends State<ChoiceFragmentTemplatePreviewWidget> {

  @override
  Widget build(BuildContext context) {
    return ChoiceFragmentTemplateInAppStageWidget(
      choiceFragmentTemplate: widget.choiceFragmentTemplate,
    );
  }
}
