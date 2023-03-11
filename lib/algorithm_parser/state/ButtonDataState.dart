part of algorithm_parser;

/// String 类型时的 use 写法：
/// use: 1 2,3 4
/// 或
/// use: 2,3
class ButtonDataValue2NextShowTime {
  ButtonDataValue2NextShowTime({required this.value});

  /// 从 [ButtonDataState] 获取到的 use 中的单个数值。
  ///
  /// 只是按钮的数值而已，并非直接涉及时间。
  final double value;

  /// 从 [NextShowTimeState] 解析结果中获取。
  ///
  /// 真正的下次展示时间。
  int? nextShowTime;

  /// 将 [nextShowTime] 转换为以 天、时、分、秒 为单位的结果。
  ///
  /// 返回 null 表示时间小于等于 0。
  String? parseTime() {
    final t = nextShowTime;
    if (t == null) throw '时间值为空！';
    final result = time2TextTime(longSeconds: t);
    return result == null ? null : '$result后';
  }

  @override
  String toString() => 'ButtonDataValue2NextShowTime(value:$value,time:$nextShowTime)';
}

class ButtonDataState extends ClassificationState {
  ButtonDataState({
    required super.algorithmWrapper,
    required super.simulationType,
    required super.externalResultHandler,
  });

  ButtonDataValue2NextShowTime? resultMin;
  ButtonDataValue2NextShowTime? resultMax;
  final List<ButtonDataValue2NextShowTime> resultButtonValues = [];

  bool get isSlidable => resultMin == null || resultMax == null;

  @override
  ButtonDataState useParse({required String useContent}) {
    final trim = useContent.trim();
    final blank = trim.split(' ')..removeWhere((element) => element.trim() == '');
    if (blank.length == 1) {
      _parseComma(comma: blank.first);
    } else if (blank.length == 3) {
      resultMin = ButtonDataValue2NextShowTime(value: AlgorithmParser.calculate(blank.first));
      resultMax = ButtonDataValue2NextShowTime(value: AlgorithmParser.calculate(blank.last));
      _parseComma(comma: blank[1]);
    } else {
      throw '"use:$useContent" 内容书写不规范！';
    }
    return this;
  }

  void _parseComma({required String comma}) {
    final bvs = comma.split(',')..removeWhere((element) => element.trim() == '');
    resultButtonValues.addAll(
      bvs.map(
        (e) {
          return ButtonDataValue2NextShowTime(value: AlgorithmParser.calculate(e));
        },
      ),
    );
  }

  @override
  String toStringResult() => '${resultMin ?? ''} ${resultButtonValues.map((e) => e.toString()).join(',')} ${resultMax ?? ''}';

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
      clickTimeIF: IvFilter(ivf: () async => [null], isReGet: true),
      clickValueIF: IvFilter(ivf: () async => [null], isReGet: true),
    );
  }
}
