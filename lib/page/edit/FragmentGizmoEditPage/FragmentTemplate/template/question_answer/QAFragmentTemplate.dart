import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/SingleQuillController.dart';
import '../../base/FragmentTemplate.dart';

/// 问答题模板的数据类。
class QAFragmentTemplate extends FragmentTemplate {
  @override
  FragmentTemplateType get fragmentTemplateType => FragmentTemplateType.questionAnswer;

  final question = SingleQuillController();
  final answer = SingleQuillController();

  /// 问题和答案是否可以互换。
  bool interchangeable = false;

  @override
  FragmentTemplate emptyInitInstance() => QAFragmentTemplate();

  @override
  FragmentTemplate emptyTransferableInstance() => QAFragmentTemplate()..interchangeable = interchangeable;

  @override
  String getTitle() => question.transferToTitle();

  @override
  List<SingleQuillController> listenSingleEditableQuill() => [question, answer];

  @override
  Map<String, dynamic> toJson() {
    final sp = super.toJson();
    return {
      "type": fragmentTemplateType.name,
      "interchangeable": interchangeable,
      "question": question.getContentJsonString(),
      "answer": answer.getContentJsonString(),
      sp.keys.first: sp.values.first,
    };
  }

  @override
  void resetFromJson(Map<String, dynamic> json) {
    interchangeable = json["interchangeable"] as bool;
    question.resetContent(json["question"]);
    answer.resetContent(json["answer"]);
    super.resetFromJson(json);
  }

  @override
  (bool, String) isMustContentEmpty() {
    if (question.isContentEmpty()) {
      return (true, "问题不能为空！");
    }
    return (false, "...");
  }

  @override
  void dispose() {
    question.dispose();
    answer.dispose();
  }

  @override
  bool get initIsShowBottomButton => false;
}
