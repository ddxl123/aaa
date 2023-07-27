import 'dart:convert';

import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/SingleEditableQuill.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:tools/tools.dart';

import 'FragmentTemplate.dart';

class QAFragmentTemplate extends FragmentTemplate {
  QAFragmentTemplate() : super(FragmentTemplateType.questionAnswer);

  final question = SingleEditableQuill();
  final answer = SingleEditableQuill();

  /// 问题和答案是否可以互换。
  bool interchangeable = false;

  @override
  FragmentTemplate emptyInitInstance() => QAFragmentTemplate();

  @override
  FragmentTemplate emptyTransferableInstance() => QAFragmentTemplate()
    ..fragmentTemplateType = fragmentTemplateType
    ..interchangeable = interchangeable;

  @override
  String getTitle() => question.quillController.document.toDelta().first.value.toString().trim();

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
    fragmentTemplateType = FragmentTemplateType.values[json["type"]!];
    interchangeable = json["interchangeable"] as bool;
    question.quillController.clear();
    question.quillController.document = q.Document.fromJson(jsonDecode(json["question"]));
    answer.quillController.clear();
    answer.quillController.document = q.Document.fromJson(jsonDecode(json["answer"]));
  }

  @override
  bool isContentEmpty() {
    final que = jsonEncode(question.quillController.document.toDelta().toJson()) == FragmentTemplate.emptyContentJsonString();
    final ans = jsonEncode(question.quillController.document.toDelta().toJson()) == FragmentTemplate.emptyContentJsonString();
    return que || ans;
  }
}

class QAFragmentTemplateEditWidget extends StatefulWidget {
  const QAFragmentTemplateEditWidget({
    super.key,
    required this.qaFragmentTemplater,
    required this.isEditable,
  });

  final QAFragmentTemplate qaFragmentTemplater;

  final bool isEditable;

  @override
  State<QAFragmentTemplateEditWidget> createState() => _QAFragmentTemplateEditWidgetState();
}

class _QAFragmentTemplateEditWidgetState extends State<QAFragmentTemplateEditWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    value: widget.qaFragmentTemplater.interchangeable,
                    onChanged: (v) {
                      if (widget.isEditable) {
                        setState(() {
                          widget.qaFragmentTemplater.interchangeable = !widget.qaFragmentTemplater.interchangeable;
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
                    widget.qaFragmentTemplater.interchangeable = !widget.qaFragmentTemplater.interchangeable;
                  });
                } else {
                  logger.outNormal(show: "只有在编辑状态才能修改！");
                }
              },
            ),
          ],
        ),
        Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("问题", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 10),
                q.QuillEditor(
                  placeholder: "请输入...",
                  customStyles: q.DefaultStyles(
                    placeHolder: q.DefaultTextBlockStyle(
                      TextStyle(color: Colors.grey),
                      q.VerticalSpacing(0, 0),
                      q.VerticalSpacing(0, 0),
                      BoxDecoration(),
                    ),
                  ),
                  scrollController: widget.qaFragmentTemplater.question.scrollController,
                  // scrollPhysics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  controller: widget.qaFragmentTemplater.question.quillController,
                  readOnly: !widget.isEditable,
                  showCursor: widget.isEditable,
                  autoFocus: true,
                  expands: false,
                  focusNode: FocusNode(),
                  padding: const EdgeInsets.all(0),
                  scrollable: false,
                  embedBuilders: [
                    ...FlutterQuillEmbeds.builders(),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("答案", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 10),
                q.QuillEditor(
                  placeholder: "请输入...",
                  customStyles: q.DefaultStyles(
                    placeHolder: q.DefaultTextBlockStyle(
                      TextStyle(color: Colors.grey),
                      q.VerticalSpacing(0, 0),
                      q.VerticalSpacing(0, 0),
                      BoxDecoration(),
                    ),
                  ),
                  scrollController: widget.qaFragmentTemplater.answer.scrollController,
                  // scrollPhysics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  controller: widget.qaFragmentTemplater.answer.quillController,
                  readOnly: !widget.isEditable,
                  showCursor: widget.isEditable,
                  autoFocus: true,
                  expands: false,
                  focusNode: FocusNode(),
                  padding: const EdgeInsets.all(0),
                  scrollable: false,
                  embedBuilders: [
                    ...FlutterQuillEmbeds.builders(),
                  ],
                ),
              ],
            ),
          ),
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
    return FlipCard(
      alignment: Alignment.topLeft,
      speed: 350,
      front: _front([]),
      back: _front(
        [
          Row(
            children: [Text("答案")],
          ),
          SizedBox(height: 10),
          q.QuillEditor(
            enableInteractiveSelection: false,
            scrollController: widget.qaFragmentTemplate.answer.scrollController,
            controller: widget.qaFragmentTemplate.answer.quillController,
            readOnly: true,
            showCursor: false,
            autoFocus: false,
            expands: false,
            focusNode: FocusNode(),
            padding: const EdgeInsets.all(0),
            scrollable: false,
            embedBuilders: [
              ...FlutterQuillEmbeds.builders(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _front(List<Widget> children) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [Text("问题")],
                  ),
                  SizedBox(height: 10),
                  q.QuillEditor(
                    enableInteractiveSelection: false,
                    scrollController: widget.qaFragmentTemplate.question.scrollController,
                    controller: widget.qaFragmentTemplate.question.quillController,
                    readOnly: true,
                    showCursor: false,
                    autoFocus: false,
                    expands: false,
                    focusNode: FocusNode(),
                    padding: const EdgeInsets.all(0),
                    scrollable: false,
                    embedBuilders: [
                      ...FlutterQuillEmbeds.builders(),
                    ],
                  ),
                  SizedBox(height: 20),
                  ...children,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
