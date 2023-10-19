part of algorithm_parser;

/// 下一次展示时间的算法状态
///
/// [result] 距离记忆组启动的时间差(秒)。
///
/// String 类型时的 use 写法：
/// use: 123
///
/// 单位：秒
class NextShowTimeState extends ClassificationState {
  NextShowTimeState({
    required super.algorithmWrapper,
    required super.simulationType,
    required super.externalResultHandler,
  });

  static const name = "下次展示时间点算法";

  late int result;

  @override
  NextShowTimeState useParse({required String useContent}) {
    result = AlgorithmParser.calculate(useContent).toInt();
    return this;
  }

  @override
  String toStringResult() => result.toString();

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
