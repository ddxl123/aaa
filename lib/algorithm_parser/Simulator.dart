import 'package:aaa/algorithm_parser/parser.dart';

class Simulator {
  static Future<void> auto({
    required String content,
  }) async {
    await AlgorithmParser().parse(
      state: ButtonDataState(
        content: content,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariableConst internalVariable, NType? nType, int? number) async {},
      ),
    );
  }
}
