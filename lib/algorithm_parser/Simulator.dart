part of algorithm_parser;

class Simulator {
  static Future<void> auto({
    required String content,
  }) async {
    await AlgorithmParser().parse(
      state: ButtonDataState(
        content: content,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableAtom internalVariableExtend) async {},
      ),
    );
  }
}
