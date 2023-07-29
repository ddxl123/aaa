import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

import '../../base/FragmentTemplate.dart';
import '../../base/FragmentTemplateEditWidget.dart';
import '../../base/QuillEditableWidget.dart';
import '../../base/SingleFragmentTemplateChunk.dart';
import 'QAFragmentTemplate.dart';

class QAFragmentTemplateEditWidget extends StatefulWidget {
  const QAFragmentTemplateEditWidget({
    super.key,
    required this.qaFragmentTemplate,
    required this.isEditable,
  });

  final QAFragmentTemplate qaFragmentTemplate;

  final bool isEditable;

  @override
  State<QAFragmentTemplateEditWidget> createState() => _QAFragmentTemplateEditWidgetState();
}

class _QAFragmentTemplateEditWidgetState extends State<QAFragmentTemplateEditWidget> {
  @override
  Widget build(BuildContext context) {
    return FragmentTemplateEditWidget(
      fragmentTemplate: widget.qaFragmentTemplate,
      isEditable: widget.isEditable,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              style: ButtonStyle(visualDensity: kMinVisualDensity),
              child: Row(
                children: [
                  const Text("问答可交换"),
                  Checkbox(
                    visualDensity: kMinVisualDensity,
                    value: widget.qaFragmentTemplate.interchangeable,
                    onChanged: (v) {
                      if (widget.isEditable) {
                        setState(() {
                          widget.qaFragmentTemplate.interchangeable = !widget.qaFragmentTemplate.interchangeable;
                        });
                      } else {
                        logger.outNormal(show: "只有在编辑状态才能修改！");
                      }
                    },
                  ),
                ],
              ),
              onPressed: () {
                if (widget.isEditable) {
                  setState(() {
                    widget.qaFragmentTemplate.interchangeable = !widget.qaFragmentTemplate.interchangeable;
                  });
                } else {
                  logger.outNormal(show: "只有在编辑状态才能修改！");
                }
              },
            ),
          ],
        ),
        SingleFragmentTemplateChunk(
          chunkTitle: "问题",
          children: [
            QuillEditableWidget(
              singleEditableQuill: widget.qaFragmentTemplate.question,
              isEditable: widget.isEditable,
            ),
          ],
        ),
        SingleFragmentTemplateChunk(
          chunkTitle: "答案",
          children: [
            QuillEditableWidget(
              singleEditableQuill: widget.qaFragmentTemplate.answer,
              isEditable: widget.isEditable,
            ),
          ],
        ),
      ],
    );
  }
}
