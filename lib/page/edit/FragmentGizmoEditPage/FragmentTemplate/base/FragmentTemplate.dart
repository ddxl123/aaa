import 'dart:convert';

import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoiceFragmentTemplate.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../template/question_answer/QAFragmentTemplate.dart';
import 'SingleEditableQuill.dart';

enum FragmentTemplateType {
  /// 问答
  questionAnswer,

  /// 选择
  choice,
}

abstract class FragmentTemplate {
  FragmentTemplate() {
    getAllInitSingleEditableQuill().forEach(
      (e) {
        e.focusNode.addListener(
          () {
            if (e.focusNode.hasFocus) {
              currentFocusSingleEditableQuill.value = e;
            }
          },
        );
      },
    );
  }

  FragmentTemplateType get fragmentTemplateType;

  /// 哪个 [SingleEditableQuill] 获取了焦点。
  ///
  /// 若为 null, 则无焦点。
  final currentFocusSingleEditableQuill = ValueNotifier<SingleEditableQuill?>(null);

  /// 内容数据。
  ///
  /// 每次操作碎片记忆信息时会使用，而不是针对当前碎片本身的属性。不会保存在 [toJson] 或者 [resetFromJson] 中。
  final contentValue = <String>[];

  void dynamicAddFocusListener(SingleEditableQuill singleEditableQuill) {
    singleEditableQuill.focusNode.addListener(
      () {
        if (singleEditableQuill.focusNode.hasFocus) {
          currentFocusSingleEditableQuill.value = singleEditableQuill;
        }
      },
    );
  }

  String getTitle();

  /// 创建当前对象的崭新的空实例。
  FragmentTemplate emptyInitInstance();

  /// 创建当前对象的可传递空实例。
  FragmentTemplate emptyTransferableInstance();

  Map<String, dynamic> toJson();

  void resetFromJson(Map<String, dynamic> json);

  /// 返回值第一个参数：必须不为空的内容是否为空
  /// 返回值第二个参数：为空的信息
  (bool, String) isMustContentEmpty();

  void dispose();

  /// 比较两者的 [toJson] 是否完全相同。
  static bool equalFrom(FragmentTemplate a, FragmentTemplate b) => const DeepCollectionEquality().equals(a.toJson(), b.toJson());

  List<SingleEditableQuill> getAllInitSingleEditableQuill();

  static FragmentTemplate newInstanceFromContent(String content) {
    final Map<String, dynamic> contentJson = jsonDecode(content);
    // 出现 type 异常有可能是 toJson 时没有写 type 字段。
    final type = FragmentTemplateType.values[contentJson["type"] as int];
    return templateSwitch(
      type,
      questionAnswer: () => QAFragmentTemplate()..resetFromJson(contentJson),
      choice: () => ChoiceFragmentTemplate()..resetFromJson(contentJson),
    );
  }

  static R templateSwitch<R>(FragmentTemplateType type, {required R Function() questionAnswer, required R Function() choice}) {
    switch (type) {
      case FragmentTemplateType.questionAnswer:
        return questionAnswer();
      case FragmentTemplateType.choice:
        return choice();
      default:
        throw "未处理类型：$type";
    }
  }

  static Future<R> templateSwitchFuture<R>(FragmentTemplateType type, {required Future<R> Function() questionAnswer, required Future<R> Function() choice}) async {
    switch (type) {
      case FragmentTemplateType.questionAnswer:
        return await questionAnswer();
      case FragmentTemplateType.choice:
        return await choice();
      default:
        throw "未处理类型：$type";
    }
  }
}
