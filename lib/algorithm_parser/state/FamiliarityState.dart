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
  Future<num?> syntaxCheckInternalVariablesResultHandler(InternalVariable internalVariable, NType? nType, int? number) async {
    const countCapping = 10000;
    // 5个月
    const timeCapping = 12960000;

    final countAll = Random().nextInt(countCapping);

    final planedShowTime = Random().nextInt(timeCapping);
    final actualShowTime = Random().nextInt(timeCapping);
    return await InternalVariable.filter(
      iv: internalVariable,
      nType: nType,
      number: number,
      ivgCountAll: () async => countAll,
      ivsCountNew: () async => countCapping ~/ 2,
      ivsTimes: () async => Random().nextInt(9) + 1,
      ivsActualShowTime: () async => actualShowTime,
      ivsPlanedShowTime: () async => planedShowTime,
      ivsShowFamiliar: () async => Random().nextDouble() * 200,
      ivcClickTime: () async => actualShowTime + Random().nextInt(600),
      ivcClickValue: () async => Random().nextDouble() * 200,
    );
  }
}
