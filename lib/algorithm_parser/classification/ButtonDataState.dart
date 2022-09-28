part of algorithm_parser;

class ButtonDataState extends ClassificationState {
  ButtonDataState({required super.content, required super.simulationType});

  double? resultMin;
  double? resultMax;
  final List<double> resultButtonValues = [];

  bool get isSlidable => resultMin == null || resultMax == null;

  @override
  ButtonDataState parse({required String content, required AlgorithmParser algorithmParser}) {
    final trim = content.trim();
    final blank = trim.split(' ')..removeWhere((element) => element.trim() == '');
    if (blank.length == 1) {
      _parseComma(comma: blank.first, algorithmParser: algorithmParser);
    } else if (blank.length == 3) {
      resultMin = algorithmParser.calculate(blank.first);
      resultMax = algorithmParser.calculate(blank.last);
      _parseComma(comma: blank[1], algorithmParser: algorithmParser);
    } else {
      throw '"use:$content" 内容书写不规范！';
    }
    return this;
  }

  void _parseComma({required String comma, required AlgorithmParser algorithmParser}) {
    final bvs = comma.split(',')..removeWhere((element) => element.trim() == '');
    resultButtonValues.addAll(
      bvs.map(
        (e) {
          return algorithmParser.calculate(e);
        },
      ),
    );
  }

  @override
  String toStringResult() => '${resultMin ?? ''} ${resultButtonValues.map((e) => e.toString()).join(',')} ${resultMax ?? ''}';

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
    throw notProcessIvThrow(internalVariable: internalVariable, number: number);
  }
}
