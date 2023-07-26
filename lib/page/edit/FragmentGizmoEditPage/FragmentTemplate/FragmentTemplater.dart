enum FragmentTemplateType {
  /// 问答
  questionAnswer,
}

abstract class FragmentTemplater {
  FragmentTemplater(this.fragmentTemplateType);

  late FragmentTemplateType fragmentTemplateType;

  String getTitle();

  FragmentTemplater empty();
}
