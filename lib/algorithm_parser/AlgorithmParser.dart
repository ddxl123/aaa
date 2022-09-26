part of algorithm_parser;

class AlgorithmParser with Explain {
  AlgorithmParser({this.isDebugPrint = true});

  /// 空赋值：name-obtainResult
  final _emptyMergeVariables = <String, double>{};

  final ContextModel cm = ContextModel();

  bool _isParsed = false;

  bool isDebugPrint;

  final StringBuffer debugPrintStringBuffer = StringBuffer();

  /// 抛出的异常信息。
  ///
  /// 若为空，则 [parseResult] 一定存在值。
  String? throwMessage;

  /// [parse] 成功的结果。
  late final double parseResult;

  void debugPrint(String content) {
    if (isDebugPrint) {
      final String printContent = '\n>>>\n$content';
      print(printContent);
      debugPrintStringBuffer.write(printContent);
    }
  }

  void throwAssert({required bool isThrow, required String message}) {
    if (isThrow) {
      debugPrintStringBuffer.write('\n抛出的异常信息：$message');
      throw message;
    }
  }

  /// 计算
  double calculate(String content) {
    late final double result;
    try {
      result = Parser().parse(content).evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      throwAssert(isThrow: true, message: '计算异常：$content');
    }
    return result;
  }

  /// TODO:
  Future<void> parseAnalyze({
    required String familiarityAlgorithmContent,
    required String nextTimeAlgorithmContent,
    required String buttonDataAlgorithmContent,
  }) async {
    await parse(
      content: buttonDataAlgorithmContent,
      internalVariablesResultHandler: (InternalVariable internalVariable, int? number) async {},
    );
  }

  /// 仅验证语法是否正确。
  Future<AlgorithmParser> parseEasy<T extends AbstractAlgorithmContent>({required T content}) async {
    return await parse(
      content: content.content,
      internalVariablesResultHandler: (InternalVariable internalVariable, int? number) async {
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
    );
  }

  /// 对 [content] 算法进行解析。
  ///
  /// [algorithmParseType] 表示该算法的类型。
  ///
  /// 解析结果将赋值给 [parseResult]。
  ///
  /// 错误信息将赋值给 [throwMessage]。
  Future<AlgorithmParser> parse({
    required String content,
    required InternalVariablesResultHandler internalVariablesResultHandler,
  }) async {
    try {
      throwAssert(isThrow: _isParsed, message: '每个 AlgorithmParser 实例只能使用一次 parse！若想多次使用，则需要创建多个 AlgorithmParser 实例。');
      _isParsed = true;
      throwAssert(isThrow: InternalVariable.getAll.isEmpty, message: '请先初始化内置变量！');
      final conciseContent = _clearAnnotated(content);
      final finallyConciseContent = _emptyMergeDetection(conciseContent);
      await _internalVariablesBindAndObtain(content: finallyConciseContent, internalVariablesResultHandler: internalVariablesResultHandler);

      // 分离变量定义与 if-use-else 语句。
      final ifIndex = finallyConciseContent.indexOf('if:');
      throwAssert(isThrow: ifIndex == -1, message: '缺少 "if:" 语句！');
      // 变量定义部分。
      final definitionPart = finallyConciseContent.substring(0, ifIndex);
      // if-use 语句部分。
      final ifUsePart = finallyConciseContent.substring(ifIndex);
      debugPrint('自定义变量的定义部分：\n$definitionPart\nif-use-else 语句部分: \n$ifUsePart');
      _definitionVariablesBindAndObtain(definitionPart);
      parseResult = _ifUseParse(ifUsePart);
    } catch (e, st) {
      print('algorithm_catch $e');
      throwMessage = e.toString();
    }
    return this;
  }

  /// 去掉全部注释
  String _clearAnnotated(String content) {
    debugPrint('正在清除注释...');
    final result = content.replaceAll(RegExp(r'<--([\S\s]*?)-->'), '');
    debugPrint('清除注释成功，清除后：\n$result');
    return result;
  }

  /// 空合并运算符评估，并去掉空表达式
  String _emptyMergeDetection(String content) {
    debugPrint('正在评估空合并运算符...');
    final regExp = RegExp(r'\(([\S\s]*?)\?\?([\S\s]*?)\)');
    // 检测出全部 (abc??123) 或 (xxx_n??123)，并添加至 emptyMergeVariables 中。
    for (var v in regExp.allMatches(content)) {
      // (abc ?? 123) -> abc 123
      final bracketInternal = content.substring(v.start + 1, v.end - 1);
      debugPrint('检测出空合并：$bracketInternal');
      final emptyMergeSplit = bracketInternal.split('??');
      throwAssert(isThrow: emptyMergeSplit.length != 2, message: '不规范使用空合并运算符：${v.group(0)}');

      // abc
      final name = emptyMergeSplit.first.trim();
      // TODO: 用命名规范来检验
      throwAssert(isThrow: name == '', message: '不规范名称：$name');

      // 123
      final result = double.tryParse(emptyMergeSplit.last.trim());
      throwAssert(isThrow: result == null, message: '不规范使用空合并运算符！');

      _emptyMergeVariables.addAll({name: result!});
      debugPrint('空合并评估成功：$bracketInternal');
    }
    debugPrint('空合并已全部评估完成！');
    // 清除空赋值表达式。
    final clearResult = content.replaceAll(RegExp(r'\?\?(([0-9]+\.[0-9]+)|([0-9]+))'), '');
    debugPrint('评估空合并运算符成功，评估结果：\n$clearResult');
    return clearResult;
  }

  /// 扫描使用到的内置变量，并绑定内置变量、获取内置变量的值
  Future<void> _internalVariablesBindAndObtain({
    required String content,
    required InternalVariablesResultHandler internalVariablesResultHandler,
  }) async {
    debugPrint('正在评估内置变量...');
    throwAssert(isThrow: InternalVariable.getAllNames.isEmpty, message: '内置变量为 empty！');
    final regExp = RegExp(InternalVariable.getAllNames.map((e) => "(($e)(_[0-9])?)").join('|'));
    // 识别出需要的内置变量，若没有识别出，则直接过。
    for (var match in regExp.allMatches(content)) {
      final variableName = match.group(0)!;
      String easyName = variableName;
      int? number;
      debugPrint('解析出变量名：$variableName 简单名：$easyName n值：$number');
      final matches = RegExp(r'(_([0-9]+))$').allMatches(variableName);
      if (matches.isNotEmpty) {
        easyName = variableName.substring(0, matches.first.start);
        number = int.parse(matches.first.group(0)!);
      }
      final result = await internalVariablesResultHandler(InternalVariable.getIvByName(easyName), number);
      debugPrint('已扫描到的内置变量及获取到的值：$variableName = $result');
      if (result != null) {
        cm.bindVariableName(variableName, Number(result));
        debugPrint('绑定 ContextModel 成功：$variableName = $result');
      } else {
        throwAssert(isThrow: !_emptyMergeVariables.containsKey(variableName), message: '$variableName 内置变量存在为空的情况，请使用"??"进行空赋值！');
        cm.bindVariableName(variableName, Number(_emptyMergeVariables[variableName]!));
        debugPrint('绑定 ContextModel 成功：$variableName = ${_emptyMergeVariables[variableName]!}');
      }
    }
    debugPrint('评估内置变量成功！');
  }

  /// 绑定并获取自定义变量值。
  ///
  /// 因为内置变量已经被空赋值了，因此自定义变量始终不为 null，即自定义变量无需空赋值。
  void _definitionVariablesBindAndObtain(String content) {
    debugPrint('正在评估自定义变量...');
    final semicolonSplit = content.trim().split(';');
    for (var assign in semicolonSplit) {
      // 最后一个';'会出现空字符，同时也可以解决连续分号 ';;;' 的问题。
      if (assign.trim() == '') continue;
      final eSep = assign.trim().split('=');
      throwAssert(isThrow: eSep.length != 2, message: '请规范使用赋值符号"="！');

      String name = eSep.first.trim();
      // TODO: 用命名规范来检验
      throwAssert(isThrow: name.trim() == '', message: '不规范名称：$name');
      String valueExp = eSep.last.trim();
      late final double result;
      try {
        result = calculate(valueExp);
        cm.bindVariableName(name, Number(result));
      } on FormatException catch (e) {
        throwAssert(isThrow: true, message: '计算异常：\n自定义变量：$name\n计算内容：$valueExp\n计算结果异常：${e.message}');
      } on ArgumentError catch (e) {
        throwAssert(isThrow: true, message: '计算异常：\n自定义变量：$name\n计算内容：$valueExp\n计算结果异常：${e.message}');
      }
      debugPrint('绑定 ContextModel 成功：$name = $valueExp');
    }
    debugPrint('评估自定义变量成功！');
  }

  /// if-use-else 语句解析。
  double _ifUseParse(String content) {
    debugPrint('正在评估 if-use-else 语句...');
    final elseMatches = RegExp('else:').allMatches(content);
    throwAssert(isThrow: elseMatches.isEmpty, message: '缺少 "else:" 语句！若不想使用 "else:" 语句，请使用 "else: throw 说明" 来进行异常处理！（程序会解析"说明"信息并展示给用户查看）');
    final elseMatch = elseMatches.first;
    final elseContent = content.substring(elseMatch.end, content.length).trim();
    debugPrint('else 内容：\n$elseContent');
    final ifUseContent = content.substring(0, elseMatch.start).trim();
    debugPrint('if-use 内容：\n$ifUseContent');
    final ifUses = ifUseContent.split('if:');
    throwAssert(isThrow: ifUses.length == 1, message: '缺少 "if:" 语句！');
    // 去掉第一个 'if:' 前的空白。
    ifUses.removeAt(0);
    for (var iu in ifUses) {
      debugPrint('解析出 -use- 内容：\n$iu');
      final iuTrim = iu.trim();
      throwAssert(isThrow: iuTrim == '', message: '不规范使用 if-use 语句！');
      throwAssert(isThrow: !iuTrim.contains('use:'), message: '缺少 "use:" 语句');
      final i2u = iuTrim.split('use:');
      throwAssert(isThrow: i2u.length != 2, message: '不规范使用 if 语句：$iuTrim');
      final i = i2u.first.trim();
      debugPrint('解析出 if 内容：\n$i');
      throwAssert(isThrow: i == '', message: '"if:" 语句内容不能为空！');
      final u = i2u.last.trim();
      debugPrint('解析出 use 内容：\n$u');
      throwAssert(isThrow: u == '', message: '"use:" 语句内容不能为空！');
      if (_ifParse(i)) {
        final result = _useParse(u);
        debugPrint('所使用的 use 语句：$u\n计算结果：$result');
        return result;
      }
    }
    throwAssert(isThrow: elseContent.contains('throw'), message: elseContent.substring(elseContent.indexOf('throw') + 5, elseContent.length));
    debugPrint('所有 if 语句都不匹配，已执行 else 语句：$elseContent');
    return calculate(elseContent);
  }

  /// 解析 if 语句。
  bool _ifParse(String content) {
    return IfExprParse().parse(content: content, algorithmParser: this);
  }

  /// 解析 use 语句。
  double _useParse(String content) {
    return calculate(content);
  }
}
