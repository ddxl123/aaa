import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/SingleQuillController.dart';
import '../../base/FragmentTemplate.dart';

/// 单面模板
class SimpleFragmentTemplate extends FragmentTemplate {
  @override
  FragmentTemplateType get fragmentTemplateType => FragmentTemplateType.single;

  final simple = SingleQuillController();

  @override
  bool isHideExtendChunkTypeOption() => true;

  @override
  FragmentTemplate emptyInitInstance() => SimpleFragmentTemplate();

  @override
  FragmentTemplate emptyTransferableInstance() => SimpleFragmentTemplate();

  @override
  String getTitle() => simple.transferToTitle();

  @override
  List<SingleQuillController> listenSingleEditableQuill() => [simple];

  @override
  Map<String, dynamic> toJson() {
    final sp = super.toJson();
    return {
      "type": fragmentTemplateType.name,
      "simple": simple.getContentJsonString(),
      sp.keys.first: sp.values.first,
    };
  }

  @override
  void resetFromJson(Map<String, dynamic> json) {
    simple.resetContent(json["simple"]);
    super.resetFromJson(json);
  }

  @override
  (bool, String) isMustContentEmpty() {
    if (simple.isContentEmpty()) {
      return (true, "主内容不能为空！");
    }
    return (false, "...");
  }

  @override
  void dispose() {
    simple.dispose();
  }

  @override
  bool get initIsShowBottomButton => true;
}
