import 'package:aaa/algorithm_parser/parser.dart';

abstract class AbstractAlgorithmContent {
  AbstractAlgorithmContent({
    required this.content,
    required this.algorithmContentType,
  });

  final String content;

  final AlgorithmContentType algorithmContentType;
}

class FamiliarityAlgorithmContent extends AbstractAlgorithmContent {
  FamiliarityAlgorithmContent({required String content})
      : super(
          content: content,
          algorithmContentType: AlgorithmContentType.familiarity,
        );
}

class NextTimeAlgorithmContent extends AbstractAlgorithmContent {
  NextTimeAlgorithmContent({required String content})
      : super(
          content: content,
          algorithmContentType: AlgorithmContentType.nextTime,
        );
}

class ButtonDataAlgorithmContent extends AbstractAlgorithmContent {
  ButtonDataAlgorithmContent({required String content})
      : super(
          content: content,
          algorithmContentType: AlgorithmContentType.buttonData,
        );
}
