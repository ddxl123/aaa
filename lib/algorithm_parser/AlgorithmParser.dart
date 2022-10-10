part of algorithm_parser;

class AlgorithmParser<CS extends ClassificationState> with Explain {
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

  late final CS state;

  void debugPrint(String content) {
    if (isDebugPrint) {
      final String printContent = '\n>>>\n$content';
      print(printContent);
      debugPrintStringBuffer.write(printContent);
    }
  }

  /// 计算
  double calculate(String content) {
    late final double result;
    try {
      result = Parser().parse(content).evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      debugPrintStringBuffer.write('\n抛出的异常信息：$e');
    }
    return result;
  }

  /// 对 [content] 算法进行解析。
  ///
  /// [algorithmParseType] 表示该算法的类型。
  ///
  /// 解析结果将赋值给 [parseResult]。
  ///
  /// 错误信息将赋值给 [throwMessage]。
  Future<AlgorithmParser<CS>> parse({required CS state}) async {
    try {
      if (_isParsed) throw '每个 AlgorithmParser 实例只能使用一次 parse！若想多次使用，则需要创建多个 AlgorithmParser 实例。';
      _isParsed = true;
      if (InternalVariabler.getAllKV.isEmpty) throw '请先初始化内置变量！';
      this.state = state;
      final conciseContent = _clearAnnotated(state.content);
      final finallyConciseContent = _emptyMergeDetection(conciseContent);
      await _internalVariablesBindAndObtain(content: finallyConciseContent);

      // 分离变量定义与 if-use-else 语句。
      final ifIndex = finallyConciseContent.indexOf('if:');
      if (ifIndex == -1) throw '缺少 "if:" 语句！';
      // 变量定义部分。
      final definitionPart = finallyConciseContent.substring(0, ifIndex);
      // if-use-else 语句部分。
      final ifUseElsePart = finallyConciseContent.substring(ifIndex);
      debugPrint('自定义变量的定义部分：\n$definitionPart\nif-use-else 语句部分: \n$ifUseElsePart');
      _definitionVariablesBindAndObtain(definitionPart);
      _ifUseElseParse(content: ifUseElsePart);
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
      if (emptyMergeSplit.length != 2) throw '不规范使用空合并运算符：${v.group(0)}';

      // abc
      final name = emptyMergeSplit.first.trim();
      // TODO: 用命名规范来检验
      if (name == '') throw '不规范名称：$name';

      // 123
      final result = double.tryParse(emptyMergeSplit.last.trim());
      if (result == null) throw '不规范使用空合并运算符！';

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
  Future<void> _internalVariablesBindAndObtain({required String content}) async {
    debugPrint('正在评估内置变量...');
    if (InternalVariabler.getAllNames.isEmpty) throw '内置变量为 empty！';
    final nTypeNames = '(${NType.values.map((e) => e.name).join('|')})';
    final vRegExp = RegExp(InternalVariabler.getAllNames.map((e) => "(($e)(_$nTypeNames(0-9)+)?)").join('|'));
    // 识别出需要的内置变量，若没有识别出，则直接过。
    for (var match in vRegExp.allMatches(content)) {
      final variableName = match.group(0)!;
      String easyName = variableName;
      NTypeNumber? nTypeNumber;
      debugPrint('解析出变量：$variableName');
      final nMatch = RegExp('(_$nTypeNames([0-9]+))\$').firstMatch(variableName);
      if (nMatch != null) {
        easyName = variableName.substring(0, nMatch.start);
        final nNameMatch = RegExp(nTypeNames).firstMatch(nMatch.group(0)!);
        final number = int.parse(nMatch.input.substring(nNameMatch!.end + 1, nMatch.input.length));
        final nType = NType.values.where((element) => element.name == nMatch.group(0)!).first;
        nTypeNumber = NTypeNumber(nType: nType, number: number);
      }
      // 相同的变量名值绑定一次。
      if (!cm.variables.containsKey(variableName)) {
        final result = await state.internalVariablesResultHandler(
          InternalVariableAtom(
            internalVariableConst: InternalVariabler.getConstByName(easyName),
            nTypeNumber: nTypeNumber,
          ),
        );
        debugPrint('已扫描到的内置变量及获取到的值：$variableName = $result');
        if (result != null) {
          cm.bindVariableName(variableName, Number(result));
          debugPrint('绑定 ContextModel 成功：$variableName = $result');
        } else {
          if (!_emptyMergeVariables.containsKey(variableName)) throw '$variableName 内置变量存在为空的情况，请使用"??"进行空赋值！';
          cm.bindVariableName(variableName, Number(_emptyMergeVariables[variableName]!));
          debugPrint('绑定 ContextModel 成功：$variableName = ${_emptyMergeVariables[variableName]!}');
        }
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
      if (eSep.length != 2) throw '请规范使用赋值符号"="！';

      String name = eSep.first.trim();
      // TODO: 用命名规范来检验
      if (name.trim() == '') throw '不规范名称：$name';
      String valueExp = eSep.last.trim();
      late final double result;
      try {
        result = calculate(valueExp);
        cm.bindVariableName(name, Number(result));
      } on FormatException catch (e) {
        throw '计算异常：\n自定义变量：$name\n计算内容：$valueExp\n计算结果异常：${e.message}';
      } on ArgumentError catch (e) {
        throw '计算异常：\n自定义变量：$name\n计算内容：$valueExp\n计算结果异常：${e.message}';
      }
      debugPrint('绑定 ContextModel 成功：$name = $valueExp');
    }
    debugPrint('评估自定义变量成功！');
  }

  /// if-use-else 语句解析。
  void _ifUseElseParse({required String content}) {
    debugPrint('正在评估 if-use-else 语句...');
    final elseMatches = RegExp('else:').allMatches(content);
    if (elseMatches.isEmpty) throw '缺少 "else:" 语句！若不想使用 "else:" 语句，请使用 "else: throw 说明" 来进行异常处理！（程序会解析"说明"信息并展示给用户查看）';
    final elseMatch = elseMatches.first;
    final elseContent = content.substring(elseMatch.end, content.length).trim();
    debugPrint('else 内容：\n$elseContent');
    final ifUseContent = content.substring(0, elseMatch.start).trim();
    debugPrint('if-use 内容：\n$ifUseContent');
    final ifUses = ifUseContent.split('if:');
    if (ifUses.length == 1) throw '缺少 "if:" 语句！';
    // 去掉第一个 'if:' 前的空白。
    ifUses.removeAt(0);
    for (var iu in ifUses) {
      debugPrint('解析出 -use- 内容：\n$iu');
      final iuTrim = iu.trim();
      if (iuTrim == '') throw '不规范使用 if-use 语句！';
      if (!iuTrim.contains('use:')) throw '缺少 "use:" 语句';
      final i2u = iuTrim.split('use:');
      if (i2u.length != 2) throw '不规范使用 if 语句：$iuTrim';
      final i = i2u.first.trim();
      debugPrint('解析出 if 内容：\n$i');
      if (i == '') throw '"if:" 语句内容不能为空！';
      final u = i2u.last.trim();
      debugPrint('解析出 use 内容：\n$u');
      if (u == '') throw '"use:" 语句内容不能为空！';
      if (_ifParse(content: i)) {
        _useParse(content: u);
        debugPrint('所使用的 use 语句：$u\n计算结果：${state.toStringResult()}');
        return;
      }
    }
    if (elseContent.contains('throw')) throw elseContent.substring(elseContent.indexOf('throw') + 5, elseContent.length);
    debugPrint('所有 if 语句都不匹配，已执行 else 语句：$elseContent');
    _useParse(content: elseContent);
  }

  /// 解析 if 语句。
  bool _ifParse({required String content}) {
    return IfExprParse().parse(content: content, algorithmParser: this);
  }

  /// 解析 use 语句。
  void _useParse({required String content}) {
    state.parse(content: content, algorithmParser: this);
  }
}
