part of algorithm_parser;

class FamiliarityState extends ClassificationState {
  FamiliarityState({required super.content});

  late double result;

  @override
  FamiliarityState parse({required String content, required AlgorithmParser algorithmParser}) {
    result = algorithmParser.calculate(content);
    return this;
  }
}
