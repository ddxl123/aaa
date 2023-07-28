import 'dart:convert';

import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/SingleEditableQuill.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:tools/tools.dart';

import '../../custom_embeds/DemoEmbed.dart';
import '../base/FragmentTemplate.dart';

class QAFragmentTemplate extends FragmentTemplate {
  @override
  FragmentTemplateType get fragmentTemplateType => FragmentTemplateType.questionAnswer;

  final question = SingleEditableQuill();
  final answer = SingleEditableQuill();

  /// 问题和答案是否可以互换。
  bool interchangeable = false;

  @override
  FragmentTemplate emptyInitInstance() => QAFragmentTemplate();

  @override
  FragmentTemplate emptyTransferableInstance() => QAFragmentTemplate()..interchangeable = interchangeable;

  @override
  String getTitle() => question.transferToTitle();

  @override
  List<SingleEditableQuill> getAllInitSingleEditableQuill() => [question, answer];

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": fragmentTemplateType.index,
      "interchangeable": interchangeable,
      "question": question.getContentJsonString(),
      "answer": answer.getContentJsonString(),
    };
  }

  @override
  void resetFromJson(Map<String, dynamic> json) {
    interchangeable = json["interchangeable"] as bool;
    question.resetContent(json["question"]);
    answer.resetContent(json["answer"]);
  }

  @override
  (bool, String) isMustContentEmpty() {
    if (question.isContentEmpty()) {
      return (true, "问题不能为空！");
    }
    if (answer.isContentEmpty()) {
      return (true, "答案不能为空！");
    }
    return (false, "...");
  }

  @override
  void dispose() {
    question.dispose();
    answer.dispose();
  }
}

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
