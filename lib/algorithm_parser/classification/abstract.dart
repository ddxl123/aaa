part of algorithm_parser;

abstract class ClassificationState {
  final String content;

  ClassificationState({required this.content});

  ClassificationState parse({required String content, required AlgorithmParser algorithmParser});
}
