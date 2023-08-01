import 'dart:convert';

import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/SingleEditableQuill.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:tools/tools.dart';

import '../../../custom_embeds/DemoEmbed.dart';
import '../../base/FragmentTemplate.dart';

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