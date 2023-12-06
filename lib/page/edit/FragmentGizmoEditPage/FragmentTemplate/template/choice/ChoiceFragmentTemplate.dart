import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplate.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/SingleQuillController.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoicePrefixType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

enum ChoiceType {
  /// 单选，只有已选选项与答案相匹配的才是正确的，否则是错误的。
  simple,

  /// 多选-完全匹配，只有已选选项完全与答案相匹配的才是正确的，否则是错误的。
  multiple_perfect_match,
}

/// 选择题模板的数据类。
class ChoiceFragmentTemplate extends FragmentTemplate {
  final question = SingleQuillController();
  final choices = <SingleQuillController>[];

  /// 选项始终使用数字字符表示（无论是ABC、序号，还是对错），与 [choices.index] 对应。
  final answers = <String>[];

  /// 选择类型。
  ChoiceType choiceType = ChoiceType.simple;

  /// 选项前缀类型。
  ChoicePrefixType choicePrefixType = ChoicePrefixType.uppercaseLetter;

  /// [singleQuillController] 是否为正确选项。
  ///
  /// 在多选的情况下，只要答案包含了 [singleQuillController]，返回的也是 true。
  bool isCorrect(SingleQuillController singleQuillController) {
    return answers.contains(choices.indexOf(singleQuillController).toString());
  }

  /// 取消勾选对 [singleQuillController] 的选择。
  void cancelCorrect(SingleQuillController singleQuillController) {
    answers.remove(choices.indexOf(singleQuillController).toString());
  }

  /// 取消勾选全部已选。
  void cancelAllCorrect() {
    answers.clear();
  }

  /// 勾选对 [singleQuillController] 的选择。
  void chooseCorrect(SingleQuillController singleQuillController) {
    final currentStr = choices.indexOf(singleQuillController).toString();
    if (choiceType == ChoiceType.simple) {
      answers.clear();
      answers.add(currentStr);
      return;
    } else if (choiceType == ChoiceType.multiple_perfect_match) {
      if (!answers.contains(currentStr)) {
        answers.add(currentStr);
      }
    } else {
      throw "未知 $choiceType";
    }
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

    choiceType = ChoiceType.values.firstWhere((element) => element.name == (json["choice_type"] as String));

    choicePrefixType = ChoicePrefixType.values.firstWhere((element) => element.name == (json["choice_prefix_type"] as String));

    super.resetFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final sp = super.toJson();
    return {
      "type": fragmentTemplateType.name,
      "question": question.getContentJsonString(),
      "choices": choices.map((e) => e.getContentJsonString()).toList(),
      "answers": answers,
      "choice_type": choiceType.name,
      "choice_prefix_type": choicePrefixType.name,
      sp.keys.first: sp.values.first,
    };
  }

  @override
  bool get initIsShowBottomButton => false;
}
