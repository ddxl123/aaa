part of algorithm_parser;

typedef ResultHandler = Future<num?> Function(InternalVariable internalVariable, NType? nType, int? number);

abstract class ClassificationState {
  ClassificationState({
    required this.content,
    required this.simulationType,
    required this.externalResultHandler,
  });

  final String content;
  final SimulationType simulationType;

  /// 若 [simulationType] 为 [SimulationType.external]，则 [externalResultHandler] 不能为 null。
  ///
  /// 可以使用 [InternalVariable.filter] 进行筛选。
  ResultHandler? externalResultHandler;

  Type get getStateType => runtimeType;

  /// 返回 String 类型的 result。
  String toStringResult();

  /// 当前状态类的 use 的解析方式。
  ClassificationState parse({required String content, required AlgorithmParser algorithmParser});

  /// 处理 if-else-use 已使用的内置变量。
  ///
  /// 根据 [SimulationType] 进行扩展。
  Future<num?> internalVariablesResultHandler(InternalVariable internalVariable, NType? nType, int? number) async {
    if (!internalVariable.usableStateTypes.contains(getStateType)) {
      throw '该算法内容不能使用 ${getNameOrNumber(internalVariable, nType, number)} 内置变量！';
    }

    if (simulationType == SimulationType.syntaxCheck) {
      return await syntaxCheckInternalVariablesResultHandler(internalVariable, nType, number);
    } else if (simulationType == SimulationType.external) {
      return await externalInternalVariablesResultHandler(internalVariable, nType, number);
    }
    throw '未处理模拟类型：$simulationType';
  }

  /// 语法分析。
  ///
  /// 可以使用 [InternalVariable.filter] 进行筛选。
  Future<num?> syntaxCheckInternalVariablesResultHandler(InternalVariable internalVariable, NType? nType, int? number);

  /// 外部处理。
  ///
  /// 可以使用 [InternalVariable.filter] 进行筛选。
  Future<num?> externalInternalVariablesResultHandler(InternalVariable internalVariable, NType? nType, int? number) async {
    if (externalResultHandler == null) throw '当为 autoSimulation 类型时，autoSimulationResultHandler 不能为 null！';
    return await externalResultHandler!(internalVariable, nType, number);
  }
}
