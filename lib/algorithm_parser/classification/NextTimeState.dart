part of algorithm_parser;

class NextTimeState extends ClassificationState {
  NextTimeState({required super.content});

  late double result;

  @override
  NextTimeState parse({required String content, required AlgorithmParser algorithmParser}) {
    result = algorithmParser.calculate(content);
    return this;
  }
}
