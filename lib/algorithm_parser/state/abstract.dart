part of algorithm_parser;

typedef ResultHandler = Future<num?> Function(InternalVariableAtom atom);

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
  Future<num?> internalVariablesResultHandler(InternalVariableAtom atom) async {
    if (simulationType == SimulationType.syntaxCheck) {
      return await syntaxCheckInternalVariablesResultHandler(atom);
    } else if (simulationType == SimulationType.external) {
      return await externalInternalVariablesResultHandler(atom);
    }
    throw '未处理模拟类型：$simulationType';
  }

  /// 语法分析。
  Future<num?> syntaxCheckInternalVariablesResultHandler(InternalVariableAtom atom);

  /// 外部处理。
  Future<num?> externalInternalVariablesResultHandler(InternalVariableAtom atom) async {
    if (externalResultHandler == null) throw '当为 SimulationType.external 类型时，externalResultHandler 不能为 null！';
    return await externalResultHandler!(atom);
  }
}
