import 'package:flutter/material.dart';

import '../../base/FragmentTemplate.dart';
import '../../base/FragmentTemplateViewWidget.dart';
import '../../base/QuillEditViewWidget.dart';
import '../../base/SingleFragmentTemplateChunk.dart';
import 'QAFragmentTemplate.dart';

class QAFragmentTemplateViewWidget extends StatefulWidget {
  const QAFragmentTemplateViewWidget({super.key, required this.qaFragmentTemplate});

  final QAFragmentTemplate qaFragmentTemplate;

  @override
  State<QAFragmentTemplateViewWidget> createState() => _QAFragmentTemplateViewWidgetState();
}

class _QAFragmentTemplateViewWidgetState extends State<QAFragmentTemplateViewWidget> {
  @override
  Widget build(BuildContext context) {
    return FragmentTemplateViewWidget(
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
