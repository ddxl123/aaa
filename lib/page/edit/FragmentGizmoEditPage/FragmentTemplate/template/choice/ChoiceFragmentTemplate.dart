import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplate.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/SingleQuillController.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoicePrefixType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

/// 选择题模板的数据类。
class ChoiceFragmentTemplate extends FragmentTemplate {
  final question = SingleQuillController();
  final choices = <SingleQuillController>[];

  /// 选项始终使用数字字符表示（无论是ABC、序号，还是对错），与 [choices.index] 对应。
  final answers = <String>[];

  /// 选项前缀类型。
  ChoicePrefixType choicePrefixType = ChoicePrefixType.uppercaseLetter;

  /// 是否是多选。
  bool isMultipleChoice = false;

  /// [singleQuillController] 是否为正确选项。
  ///
  /// TODO: 在多选的情况下？？？
  bool isCorrect(SingleQuillController singleQuillController) {
    return answers.contains(choices.indexOf(singleQuillController).toString());
  }

  /// 取消对 [singleQuillController] 的选择。
  void cancelCorrect(SingleQuillController singleQuillController) {
    answers.remove(choices.indexOf(singleQuillController).toString());
  }

  /// 勾选对 [singleQuillController] 的选择。
  void chooseCorrect(SingleQuillController singleQuillController) {
    answers.add(choices.indexOf(singleQuillController).toString());
  }

  /// 对 [singleQuillController] 的反选。
  void invertCorrect(SingleQuillController singleQuillController) {
    if (isCorrect(singleQuillController)) {
      cancelCorrect(singleQuillController);
    } else {
      chooseCorrect(singleQuillController);
    }
  }

  /// 移除 [singleQuillController] 选项。
  void removeItem(SingleQuillController singleQuillController) {
    final cs = <SingleQuillController>[];
    for (var a in answers) {
      cs.add(choices[int.parse(a)]);
    }
    singleQuillController.dispose();
    choices.remove(singleQuillController);
    cs.remove(singleQuillController);
    answers.clear();
    answers.addAll(cs.map((e) => choices.indexOf(e).toString()));
  }

  /// 添加新选项。
  void addItem(SingleQuillController singleQuillController) {
    choices.add(singleQuillController);
    dynamicAddFocusListener(singleQuillController);
  }

  @override
  FragmentTemplateType get fragmentTemplateType => FragmentTemplateType.choice;

  @override
  void dispose() {
    question.dispose();
    for (var value in choices) {
      value.dispose();
    }
  }

  @override
  FragmentTemplate emptyInitInstance() => ChoiceFragmentTemplate();

  @override
  FragmentTemplate emptyTransferableInstance() => ChoiceFragmentTemplate();

  @override
  List<SingleQuillController> getAllInitSingleEditableQuill() => [question, ...choices];

  @override
  String getTitle() => question.transferToTitle();

  @override
  (bool, String) isMustContentEmpty() {
    if (question.isContentEmpty()) {
      return (true, "问题不能为空！");
    }
    if (choices.isEmpty) {
      return (true, "必须至少有两个选项");
    }
    for (var c in choices) {
      if (c.isContentEmpty()) {
        return (true, "选项内容不能为空！");
      }
    }
    if (answers.isEmpty) {
      return (true, "请至少选择一个正确选项！");
    }
    return (false, "...");
  }

  @override
  void resetFromJson(Map<String, dynamic> json) {
    question.resetContent(json["question"]);

    final choicesList = json["choices"] as List<dynamic>;
    choices.clear();
    for (var c in choicesList) {
      choices.add(SingleQuillController()..resetContent(c as String));
    }

    answers.clear();
    answers.addAll((json["answers"] as List<dynamic>).map((e) => e as String));

    choicePrefixType = ChoicePrefixType.values.firstWhere((element) => element.name == (json["choice_prefix_type"] as String));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": fragmentTemplateType.name,
      "question": question.getContentJsonString(),
      "choices": choices.map((e) => e.getContentJsonString()).toList(),
      "answers": answers,
      "choice_prefix_type": choicePrefixType.name,
    };
  }

  @override
  bool get initIsShowBottomButton => false;
}
