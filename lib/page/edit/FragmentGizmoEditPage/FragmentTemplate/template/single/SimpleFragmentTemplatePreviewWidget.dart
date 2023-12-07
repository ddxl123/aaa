import 'package:flutter/material.dart';

import '../../base/FragmentTemplatePreviewWidget.dart';
import '../../base/SingleQuillPreviewWidget.dart';
import '../../base/TemplateViewChunkWidget.dart';
import 'SimpleFragmentTemplate.dart';
import 'SimpleFragmentTemplateInAppStageWidget.dart';

/// 单面模板预览状态下的 Widget。
class SimpleFragmentTemplatePreviewWidget extends StatefulWidget {
  const SimpleFragmentTemplatePreviewWidget({super.key, required this.simpleFragmentTemplate});

  final SimpleFragmentTemplate simpleFragmentTemplate;

  @override
  State<SimpleFragmentTemplatePreviewWidget> createState() => _SimpleFragmentTemplatePreviewWidgetState();
}

class _SimpleFragmentTemplatePreviewWidgetState extends State<SimpleFragmentTemplatePreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return SimpleFragmentTemplateInAppStageWidget(
      simpleFragmentTemplate: widget.simpleFragmentTemplate,
    );
  }
}
