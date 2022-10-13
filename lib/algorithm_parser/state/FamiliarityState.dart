part of algorithm_parser;

class FamiliarityState extends ClassificationState {
  FamiliarityState({
    required super.content,
    required super.simulationType,
    required super.externalResultHandler,
  });

  late double result;

  @override
  FamiliarityState parse({required String content, required AlgorithmParser algorithmParser}) {
    result = algorithmParser.calculate(content);
    return this;
  }

  @override
  String toStringResult() => result.toString();

  @override
  Future<num?> syntaxCheckInternalVariablesResultHandler(InternalVariableAtom atom) async {
    const countCapping = 10000;
    // 5个月
    const timeCapping = 12960000;

    final countAll = Random().nextInt(countCapping);

    final planedShowTime = Random().nextInt(timeCapping);
    final actualShowTime = Random().nextInt(timeCapping);
    return await atom.filter(
      storage: internalVariableStorage,
      countAllIF: IvFilter(ivf: () async => countAll, isCover: true),
      countNewIF: IvFilter(ivf: () async => countCapping ~/ 2, isCover: true),
      timesIF: IvFilter(ivf: () async => Random().nextInt(9) + 1, isCover: true),
      actualShowTimeIF: IvFilter(ivf: () async => actualShowTime, isCover: true),
      planedShowTimeIF: IvFilter(ivf: () async => planedShowTime, isCover: true),
      showFamiliarIF: IvFilter(ivf: () async => Random().nextDouble() * 200, isCover: true),
      clickTimeIF: IvFilter(ivf: () async => actualShowTime + Random().nextInt(600), isCover: true),
      clickValueIF: IvFilter(ivf: () async => Random().nextDouble() * 200, isCover: true),
    );
  }
}
