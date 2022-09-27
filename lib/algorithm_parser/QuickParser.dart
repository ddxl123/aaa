part of algorithm_parser;

class QuickParser {

  /// TODO:
  Future<void> parseAnalyze({
    required FamiliarityAlgorithmContent familiarityAlgorithmContent,
    required NextTimeAlgorithmContent nextTimeAlgorithmContent,
    required ButtonDataAlgorithmContent buttonDataAlgorithmContent,
  }) async {
    final gStartTime = 0.0;
    final gCountAll = 5000.0;
    await parse(
      content: buttonDataAlgorithmContent.content,
      internalVariablesResultHandler: (InternalVariable internalVariable, int? number) async {
        if (!internalVariable.usableStates.contains(buttonDataAlgorithmContent.algorithmContentType)) {
          throwAssert(isThrow: true, message: '该算法内容不能使用 ${internalVariable.name}_${number ?? ''} 变量！');
        }
        if (internalVariable == InternalVariable.ivgStartTime) return gStartTime;
        if (internalVariable == InternalVariable.ivgCountAll) return gCountAll;
        if (internalVariable == InternalVariable.ivsActualShowTime) return 100;
        if (internalVariable == InternalVariable.ivsPlanedShowTime) return 150;
        if (internalVariable == InternalVariable.ivsClickFamiliar) return 50;
        if (internalVariable == InternalVariable.ivsCountNew) return 2500;
        if (internalVariable == InternalVariable.ivsTimes) return 5;
        if (internalVariable == InternalVariable.ivcClickTime) return 120;
        if (internalVariable == InternalVariable.ivcClickValue) return 20;
      },
    );
  }

  /// 仅验证语法是否正确，不测试数值。
  Future<AlgorithmParser> parseEasy<AC extends ParseContent>({required AC content}) async {
    return await AlgorithmParser.parse(
        content: content.content,
        internalVariablesResultHandler: (InternalVariable internalVariable, int? number) async {
          if (!internalVariable.usableStates.contains(content.runtimeType)) {
            throwAssert(isThrow: true, message: '该算法内容不能使用 ${internalVariable.name}_${number ?? ''} 变量！');
          }
          if (internalVariable == InternalVariable.ivgStartTime) return 0;
          if (internalVariable == InternalVariable.ivgCountAll) return 5000;
          if (internalVariable == InternalVariable.ivsActualShowTime) return 100;
          if (internalVariable == InternalVariable.ivsPlanedShowTime) return 150;
          if (internalVariable == InternalVariable.ivsClickFamiliar) return 50;
          if (internalVariable == InternalVariable.ivsCountNew) return 2500;
          if (internalVariable == InternalVariable.ivsTimes) return 5;
          if (internalVariable == InternalVariable.ivcClickTime) return 120;
          if (internalVariable == InternalVariable.ivcClickValue) return 20;
          throwAssert(isThrow: true, message: '未处理变量：${internalVariable.name}');
        },
        useParser:
    );
  }
}