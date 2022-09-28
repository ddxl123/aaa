part of algorithm_parser;

abstract class ClassificationState {
  final String content;
  final SimulationType simulationType;

  ClassificationState({required this.content, required this.simulationType});

  Type get getStateType => runtimeType;

  /// 返回 String 类型的 result。
  String toStringResult();

  /// 未被拦截变量抛出的文本。
  String notProcessIvThrow({required InternalVariable internalVariable, required int? number}) {
    return '未处理变量：${internalVariable.name}${number == null ? '' : '_$number'}';
  }

  /// 当前状态类的 use 的解析方式。
  ClassificationState parse({required String content, required AlgorithmParser algorithmParser});

  /// 处理 if-else-use 已使用的内置变量。
  ///
  /// 根据 [SimulationType] 进行扩展。
  Future<double?> internalVariablesResultHandler(InternalVariable internalVariable, int? number) async {
    if (!internalVariable.usableStateTypes.contains(getStateType)) {
      throw '该算法内容不能使用 ${internalVariable.name}${number == null ? '' : '_$number'} 变量！';
    }
    if (simulationType == SimulationType.syntaxCheck) {
      return await syntaxCheckInternalVariablesResultHandler(internalVariable, number);
    } else if (simulationType == SimulationType.autoSimulation) {
      return await autoSimulationInternalVariablesResultHandler(internalVariable, number);
    } else if (simulationType == SimulationType.manualSimulation) {
      return await manualSimulationInternalVariablesResultHandler(internalVariable, number);
    }
    throw '未处理模拟类型：$simulationType';
  }

  Future<double?> syntaxCheckInternalVariablesResultHandler(InternalVariable internalVariable, int? number);

  Future<double?> autoSimulationInternalVariablesResultHandler(InternalVariable internalVariable, int? number);

  Future<double?> manualSimulationInternalVariablesResultHandler(InternalVariable internalVariable, int? number);
}
