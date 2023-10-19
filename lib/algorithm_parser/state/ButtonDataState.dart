part of algorithm_parser;

/// String 类型时的 use 写法：
/// use: 2,3
/// 或
/// use: 2,3;按钮描述1,按钮描述2
class ButtonDataValue2NextShowTime {
  ButtonDataValue2NextShowTime({
    required this.value,
    required this.explain,
  });

  /// 从 [ButtonDataState] 获取到的 use 中的单个数值。
  ///
  /// 只是按钮的数值而已，并非直接涉及时间。
  final double value;

  /// 按钮显示文字
  final String? explain;

  /// 从 [NextShowTimeState] 解析结果中获取。
  ///
  /// 从碎片组开始时间到下一次展示时间的时间差。
  ///
  /// 真正的下次展示时间。
  int? nextShowTime;

  /// 将 [nextShowTime] (从碎片组开始时间到下一次展示时间的时间差)转换成从现在到下一次展示时间的时间差，为以 天、时、分、秒 为单位的结果。
  ///
  /// 返回 null 表示时间小于等于 0。
  String? parseTimeToFixView(DateTime startTime) {
    int? t = nextShowTime;
    if (t == null) throw '时间值为空！';
    t = t - timeDifference(target: DateTime.now(), start: startTime);
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

  static const name = "按钮数值分配算法";
  final List<ButtonDataValue2NextShowTime> resultButtonValues = [];

  @override
  ButtonDataState useParse({required String useContent}) {
    final sp = useContent.split(";");
    final explain = <String>[];
    if (sp.length > 1) {
      explain.addAll(sp.last.split(",").map((e) => e.trim()));
    }
    _parseComma(comma: sp.first, explains: explain);
    return this;
  }

  void _parseComma({required String comma, required List<String> explains}) {
    final bvs = comma.split(',');
    if (bvs.length != explains.length) {
      throw KnownAlgorithmException("按钮个数与解释个数不匹配！");
    }
    for (int i = 0; i < bvs.length; i++) {
      resultButtonValues.add(ButtonDataValue2NextShowTime(value: AlgorithmParser.calculate(bvs[i]), explain: explains[i]));
    }
  }

  @override
  String toStringResult() => '${resultButtonValues.map((e) => e.toString()).join(',')}';

  @override
  Future<AtomResultOrNull> syntaxCheckInternalVariablesResultHandler(InternalVariableAtom atom) async {
    return await atom.filter(
      storage: internalVariableStorage,
      k1countAllConst: IvFilter(ivf: () async => 1, isReGet: true),
      k2CountStopConst: IvFilter(ivf: () async => 1, isReGet: true),
      k2CountCompleteConst: IvFilter(ivf: () async => 1, isReGet: true),
      k2CountReviewConst: IvFilter(ivf: () async => 1, isReGet: true),
      k2CountNeverConst: IvFilter(ivf: () async => 1, isReGet: true),
      k3StudiedTimesConst: IvFilter(ivf: () async => math.Random().nextInt(9) + 1, isReGet: true),
      k4CurrentShowTimeConst: IvFilter(ivf: () async => 1, isReGet: true),
      k5CurrentShowFamiliarityConst: IvFilter(ivf: () async => math.Random().nextDouble() * 200, isReGet: true),
      k6CurrentButtonValuesConst: IvFilter(ivf: () async => [1, 2, 3], isReGet: true),
      k6CurrentButtonValueConst: IvFilter(ivf: () async => 1, isReGet: true),
      k7CurrentClickTimeConst: IvFilter(ivf: () async => 1, isReGet: true),
      i1ActualShowTimeConst: IvFilter(ivf: () async => [1, 1, 1], isReGet: true),
      i2NextPlanShowTimeConst: IvFilter(ivf: () async => [1, 2, 3], isReGet: true),
      i3ShowFamiliarityConst: IvFilter(ivf: () async => [1, 2, 3], isReGet: true),
      i4ClickFamiliarityConst: IvFilter(ivf: () async => [1, 2, 3], isReGet: true),
      i5ClickTimeConst: IvFilter(ivf: () async => [1, 2, 3], isReGet: true),
      i6ClickValueConst: IvFilter(ivf: () async => [1, 2, 3], isReGet: true),
      i7ButtonValuesConst: IvFilter(
          ivf: () async => [
                [1],
                [2],
                [3]
              ],
          isReGet: true),
    );
  }
}
