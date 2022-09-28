part of algorithm_parser;

class NextTimeState extends ClassificationState {
  NextTimeState({required super.content, required super.simulationType});

  late double result;

  @override
  NextTimeState parse({required String content, required AlgorithmParser algorithmParser}) {
    result = algorithmParser.calculate(content);
    return this;
  }

  @override
  String toStringResult() => result.toString();

  @override
  @override
  Future<double?> autoSimulationInternalVariablesResultHandler(InternalVariable internalVariable, int? number) async {}

  @override
  Future<double?> manualSimulationInternalVariablesResultHandler(InternalVariable internalVariable, int? number) async {}

  @override
  Future<double?> syntaxCheckInternalVariablesResultHandler(InternalVariable internalVariable, int? number) async {
    if (internalVariable == InternalVariable.ivgCountAll) return 5000;
    if (internalVariable == InternalVariable.ivgStartTime) return 0;

    if (internalVariable == InternalVariable.ivsPlanedShowTime) return 120;
    if (internalVariable == InternalVariable.ivsActualShowTime) return 100;
    if (internalVariable == InternalVariable.ivsShowFamiliar) return 20;
    if (internalVariable == InternalVariable.ivsCountNew) return 2500;
    if (internalVariable == InternalVariable.ivsTimes) return 5;

    if (internalVariable == InternalVariable.ivcClickTime) return 140;
    if (internalVariable == InternalVariable.ivcClickValue) return 20;
    throw notProcessIvThrow(internalVariable: internalVariable, number: number);
  }
}
