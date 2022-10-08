import 'package:aaa/algorithm_parser/parser.dart';

class Simulator {
  static Future<void> auto({
    required String content,
  }) async {
    await AlgorithmParser().parse(
      state: ButtonDataState(
        content: content,
        simulationType: SimulationType.external,
        externalResultHandler: (InternalVariable internalVariable, NType? nType, int? number) async {},
      ),
    );
  }
}
