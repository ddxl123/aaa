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
  Future<num?> syntaxCheckInternalVariablesResultHandler(InternalVariableAtom internalVariableExtend) async {
    const countCapping = 10000;
    // 5个月
    const timeCapping = 12960000;

    final countAll = Random().nextInt(countCapping);

    final planedShowTime = Random().nextInt(timeCapping);
    final actualShowTime = Random().nextInt(timeCapping);
    return await internalVariableStorage.filterStorage(
      internalVariableExtend: internalVariableExtend,
      ivgCountAllIF: IvFilter(ivf: () async => countAll, isCoverResult: true),
      ivsCountNewIF: IvFilter(ivf: () async => countCapping ~/ 2, isCoverResult: true),
      ivsTimesIF: IvFilter(ivf: () async => Random().nextInt(9) + 1, isCoverResult: true),
      ivsActualShowTimeIF: IvFilter(ivf: () async => actualShowTime, isCoverResult: true),
      ivsPlanedShowTimeIF: IvFilter(ivf: () async => planedShowTime, isCoverResult: true),
      ivsShowFamiliarIF: IvFilter(ivf: () async => Random().nextDouble() * 200, isCoverResult: true),
      ivcClickTimeIF: IvFilter(ivf: () async => actualShowTime + Random().nextInt(600), isCoverResult: true),
      ivcClickValueIF: IvFilter(ivf: () async => Random().nextDouble() * 200, isCoverResult: true),
    );
  }
}
