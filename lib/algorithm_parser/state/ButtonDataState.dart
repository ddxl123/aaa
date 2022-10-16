part of algorithm_parser;

class ButtonDataValue2NextShowTime {
  final double value;

  /// 从 [NextShowTimeState] 解析结果中获取。
  int? time;

  String parseTime() {
    final t = time;
    if (t == null) throw '时间值为空！';
    int days = 0;
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    final d = Duration(seconds: t);
    days = d.inDays;
    hours = days == 0 ? d.inHours : d.inHours % 24;
    minutes = hours == 0 ? d.inMinutes : d.inMinutes % 60;
    seconds = minutes == 0 ? d.inSeconds : d.inSeconds % 60;
    return '${days == 0 ? '' : '$days天'}${hours == 0 ? '' : '$hours时'}${minutes == 0 ? '' : '$minutes分'}${seconds == 0 ? '' : '$seconds秒'}';
  }

  ButtonDataValue2NextShowTime({required this.value});
}

class ButtonDataState extends ClassificationState {
  ButtonDataState({
    required super.content,
    required super.simulationType,
    required super.externalResultHandler,
  });

  ButtonDataValue2NextShowTime? resultMin;
  ButtonDataValue2NextShowTime? resultMax;
  final List<ButtonDataValue2NextShowTime> resultButtonValues = [];

  bool get isSlidable => resultMin == null || resultMax == null;

  @override
  ButtonDataState parse({required String content, required AlgorithmParser algorithmParser}) {
    final trim = content.trim();
    final blank = trim.split(' ')..removeWhere((element) => element.trim() == '');
    if (blank.length == 1) {
      _parseComma(comma: blank.first, algorithmParser: algorithmParser);
    } else if (blank.length == 3) {
      resultMin = ButtonDataValue2NextShowTime(value: algorithmParser.calculate(blank.first));
      resultMax = ButtonDataValue2NextShowTime(value: algorithmParser.calculate(blank.last));
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
          return ButtonDataValue2NextShowTime(value: algorithmParser.calculate(e));
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
      currentActualShowTimeIF: IvFilter(ivf: () async => [actualShowTime], isReGet: true),
      currentPlanedShowTimeIF: IvFilter(ivf: () async => [planedShowTime], isReGet: true),
      showFamiliarIF: IvFilter(ivf: () async => [Random().nextDouble() * 200], isReGet: true),
      clickTimeIF: IvFilter(ivf: () async => [null], isReGet: true),
      clickValueIF: IvFilter(ivf: () async => [null], isReGet: true),
    );
  }
}
