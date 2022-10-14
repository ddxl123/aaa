part of algorithm_parser;

class ButtonDataState extends ClassificationState {
  ButtonDataState({
    required super.content,
    required super.simulationType,
    required super.externalResultHandler,
  });

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
      actualShowTimeIF: IvFilter(ivf: () async => [actualShowTime], isReGet: true),
      planedShowTimeIF: IvFilter(ivf: () async => [planedShowTime], isReGet: true),
      showFamiliarIF: IvFilter(ivf: () async => [Random().nextDouble() * 200], isReGet: true),
      clickTimeIF: IvFilter(ivf: () async => [null], isReGet: true),
      clickValueIF: IvFilter(ivf: () async => [null], isReGet: true),
    );
  }
}
