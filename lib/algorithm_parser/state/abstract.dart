part of algorithm_parser;

typedef ResultHandler = Future<num?> Function(InternalVariableAtom internalVariableExtend);

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
  /// 可以使用 [InternalVariableStorage.filterStorage] 进行筛选。
  ResultHandler? externalResultHandler;

  InternalVariableStorage internalVariableStorage = InternalVariableStorage();

  Type get getStateType => runtimeType;

  /// 返回 String 类型的 result。
  String toStringResult();

  /// 当前状态类的 use 的解析方式。
  ClassificationState parse({required String content, required AlgorithmParser algorithmParser});

  /// 处理 if-else-use 已使用的内置变量。
  ///
  /// 根据 [SimulationType] 进行扩展。
  Future<num?> internalVariablesResultHandler(InternalVariableAtom internalVariableExtend) async {
    if (!internalVariableExtend.internalVariableConst.usableStateTypes.contains(getStateType)) {
      throw '该算法内容不能使用 ${internalVariableExtend.getCombineName} 内置变量！';
    }
    if (internalVariableExtend.internalVariableConst.whenAvailable == WhenAvailable.global && internalVariableExtend.nTypeNumber != null) {
      throw '${internalVariableExtend.internalVariableConst.name} 变量不支持 "_xxn" 后缀！';
    }

    if (simulationType == SimulationType.syntaxCheck) {
      return await syntaxCheckInternalVariablesResultHandler(internalVariableExtend);
    } else if (simulationType == SimulationType.external) {
      return await externalInternalVariablesResultHandler(internalVariableExtend);
    }
    throw '未处理模拟类型：$simulationType';
  }

  /// 语法分析。
  ///
  /// 可以使用 [InternalVariableConst.filterStorage] 进行筛选。
  Future<num?> syntaxCheckInternalVariablesResultHandler(InternalVariableAtom internalVariableExtend);

  /// 外部处理。
  ///
  /// 可以使用 [InternalVariableConst.filterStorage] 进行筛选。
  Future<num?> externalInternalVariablesResultHandler(InternalVariableAtom internalVariableExtend) async {
    if (externalResultHandler == null) throw '当为 autoSimulation 类型时，autoSimulationResultHandler 不能为 null！';
    return await externalResultHandler!(internalVariableExtend);
  }
}
