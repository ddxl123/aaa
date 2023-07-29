import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplateInAppStageWidget.dart';
import 'package:flutter/material.dart';

import '../../base/FragmentTemplateViewWidget.dart';
import '../../base/QuillEditViewWidget.dart';
import '../../base/SingleFragmentTemplateChunk.dart';
import 'QAFragmentTemplate.dart';

class QAFragmentTemplateInAppStageWidget extends StatefulWidget {
  const QAFragmentTemplateInAppStageWidget({super.key, required this.qaFragmentTemplate});

  final QAFragmentTemplate qaFragmentTemplate;

  @override
  State<QAFragmentTemplateInAppStageWidget> createState() => _QAFragmentTemplateInAppStageWidgetState();
}

class _QAFragmentTemplateInAppStageWidgetState extends State<QAFragmentTemplateInAppStageWidget> {
  @override
  Widget build(BuildContext context) {
    return FragmentTemplateInAppStageWidget(
      fragmentTemplate: widget.qaFragmentTemplate,
      frontChildren: [
        SingleFragmentTemplateChunk(
          chunkTitle: "问题",
          children: [
            QuillEditViewWidget(singleEditableQuill: widget.qaFragmentTemplate.question),
          ],
        ),
      ],
      backChildren: [
        SingleFragmentTemplateChunk(
          chunkTitle: "问题",
          children: [
            QuillEditViewWidget(singleEditableQuill: widget.qaFragmentTemplate.question),
          ],
        ),
        SingleFragmentTemplateChunk(
          chunkTitle: "答案",
          children: [
            QuillEditViewWidget(singleEditableQuill: widget.qaFragmentTemplate.answer),
          ],
        ),
      ],
    );
  }
}
