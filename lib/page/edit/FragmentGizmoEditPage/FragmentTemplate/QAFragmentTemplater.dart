import 'dart:convert';

import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentGizmoEditPageAbController.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/FragmentTemplater.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/SingleEditableQuill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:tools/tools.dart';

class QAFragmentTemplater extends FragmentTemplater {
  QAFragmentTemplater() : super(FragmentTemplateType.questionAnswer);

  final question = SingleEditableQuill();
  final answer = SingleEditableQuill();

  @override
  FragmentTemplater empty() => QAFragmentTemplater();

  @override
  String getTitle() => question.quillController.document.toDelta().first.value.toString().trim();

  Map<String, dynamic> toJson() {
    return {
      "config": {
        "type": fragmentTemplateType.index,
      },
      "question": question.getContentJsonString(),
      "answer": answer.getContentJsonString(),
    };
  }

  void fromJson(Map<String, dynamic> json) {
    fragmentTemplateType = FragmentTemplateType.values[json["config"]!["type"]!];
    question.quillController.clear();
    question.quillController.document = Document.fromJson(jsonDecode(json["question"]));
    answer.quillController.clear();
    answer.quillController.document = Document.fromJson(jsonDecode(json["answer"]));
  }
}

class QAFragmentTemplateWidget extends StatefulWidget {
  const QAFragmentTemplateWidget({
    super.key,
    required this.qaFragmentTemplate,
    required this.fragmentPerformerType,
  });

  final QAFragmentTemplater qaFragmentTemplate;

  final FragmentPerformerType fragmentPerformerType;

  @override
  State<QAFragmentTemplateWidget> createState() => _QAFragmentTemplateWidgetState();
}

class _QAFragmentTemplateWidgetState extends State<QAFragmentTemplateWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuillEditor(
          scrollController: widget.qaFragmentTemplate.question.scrollController,
          scrollPhysics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          controller: widget.qaFragmentTemplate.question.quillController,
          readOnly: !widget.fragmentPerformerType.isOrTrue([FragmentPerformerType.editable]),
          showCursor: !widget.fragmentPerformerType.isOrTrue([FragmentPerformerType.editable]),
          autoFocus: true,
          expands: true,
          focusNode: FocusNode(),
          padding: const EdgeInsets.all(10),
          scrollable: true,
          embedBuilders: [
            ...FlutterQuillEmbeds.builders(),
          ],
        ),
      ],
    );
  }
}
