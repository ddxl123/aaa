part of algorithm_parser;

class NextShowTimeState extends ClassificationState {
  NextShowTimeState({
    required super.content,
    required super.simulationType,
    required super.externalResultHandler,
  });

  late int result;

  @override
  NextShowTimeState parse({required String content, required AlgorithmParser algorithmParser}) {
    result = algorithmParser.calculate(content).toInt();
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
      countAllIF: IvFilter(ivf: () async => [countAll], isReGet: true),
      countNewIF: IvFilter(ivf: () async => [countCapping ~/ 2], isReGet: true),
      timesIF: IvFilter(ivf: () async => [Random().nextInt(9) + 1], isReGet: true),
      currentActualShowTimeIF: IvFilter(ivf: () async => [actualShowTime], isReGet: true),
      currentPlanedShowTimeIF: IvFilter(ivf: () async => [planedShowTime], isReGet: true),
      showFamiliarIF: IvFilter(ivf: () async => [Random().nextDouble() * 200], isReGet: true),
      clickTimeIF: IvFilter(ivf: () async => [actualShowTime + Random().nextInt(600)], isReGet: true),
      clickValueIF: IvFilter(ivf: () async => [Random().nextDouble() * 200], isReGet: true),
    );
  }
}
