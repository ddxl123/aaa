part of algorithm_parser;

/// String 类型时的 use 写法：
/// use: 123
class FamiliarityState extends ClassificationState {
  FamiliarityState({
    required super.ifElseUseWrapper,
    required super.simulationType,
    required super.externalResultHandler,
  });

  late double result;

  @override
  FamiliarityState useParse({required String useContent, required AlgorithmParser algorithmParser}) {
    result = algorithmParser.calculate(useContent);
    return this;
  }

  @override
  String toStringResult() => result.toString();

  @override
  Future<NumberOrNull> syntaxCheckInternalVariablesResultHandler(InternalVariableAtom atom) async {
    const countCapping = 10000;
    // 5个月
    const timeCapping = 12960000;

    final countAll = math.Random().nextInt(countCapping);

    final planedShowTime = math.Random().nextInt(timeCapping);
    final actualShowTime = math.Random().nextInt(timeCapping);
    return await atom.filter(
      storage: internalVariableStorage,
      countAllIF: IvFilter(ivf: () async => [countAll], isReGet: true),
      countNewIF: IvFilter(ivf: () async => [countCapping ~/ 2], isReGet: true),
      timesIF: IvFilter(ivf: () async => [math.Random().nextInt(9) + 1], isReGet: true),
      currentActualShowTimeIF: IvFilter(ivf: () async => [actualShowTime], isReGet: true),
      nextPlanedShowTimeIF: IvFilter(ivf: () async => [planedShowTime], isReGet: true),
      showFamiliarIF: IvFilter(ivf: () async => [math.Random().nextDouble() * 200], isReGet: true),
      clickTimeIF: IvFilter(ivf: () async => [actualShowTime + math.Random().nextInt(600)], isReGet: true),
      clickValueIF: IvFilter(ivf: () async => [math.Random().nextDouble() * 200], isReGet: true),
    );
  }
}
