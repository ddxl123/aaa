part of algorithm_parser;

class AlgorithmParser<CS extends ClassificationState> with Explain {
  AlgorithmParser({this.isDebugPrint = true});

  /// 空赋值：name-计算表达式
  final _emptyMergeVariables = <String, String>{};

  final ContextModel cm = ContextModel();

  bool _isParsed = false;

  late final CS state;

  bool isDebugPrint;

  StringBuffer debugPrintStringBuffer = StringBuffer();

  String? throwMessage;

  void debugPrint({required String content, StackTrace? st}) {
    if (isDebugPrint) {
      final currentSt = RegExper.consolePrint.allMatches(StackTrace.current.toString()).first.group(0);
      debugPrintStringBuffer.write('\n>>>\n$content\n${currentSt?.substring(2, currentSt.length - 2).trim()}\n');
      if (st != null) {
        debugPrintStringBuffer.write('\nthrow:\n$st\n');
        throwMessage = content;
      }
    }
  }

  /// 计算
  double calculate(String content) {
    try {
      return Parser().parse(content).evaluate(EvaluationType.REAL, cm);
    } catch (e, st) {
      if (e.toString().contains('Variable not bound')) {
        throw '变量非内置变量，或变量未被定义：$content';
      }
      throw '解析失败：$content\n$e';
    }
  }

  Future<AlgorithmParser<CS>> parse({required CS state}) async {
    try {
      if (_isParsed) throw '每个 AlgorithmParser 实例只能使用一次 parse！若想多次使用，则需要创建多个 AlgorithmParser 实例。';
      _isParsed = true;
      if (InternalVariableConstant.getAllKV.isEmpty) throw '请先初始化内置变量！';
      this.state = state;
      debugPrint(content: '【开始解析 ${state.getStateType}...】');
      final lowerCaseContent = state.content.toLowerCase();
      final conciseContent = _clearAnnotated(lowerCaseContent);
      final finallyConciseContent = _emptyMergeDetection(conciseContent);
      await _internalVariablesBindAndObtain(content: finallyConciseContent);

      // 分离变量定义与 if-use-else 语句。
      final ifIndex = finallyConciseContent.indexOf('if:');
      if (ifIndex == -1) throw '缺少 "if:" 语句！';
      // 变量定义部分。
      final definitionPart = finallyConciseContent.substring(0, ifIndex);
      // if-use-else 语句部分。
      final ifUseElsePart = finallyConciseContent.substring(ifIndex);
      debugPrint(content: '- 自定义变量的定义部分：\n$definitionPart\n- if-use-else 语句部分: \n$ifUseElsePart');
      _definitionVariablesBindAndObtain(definitionPart);
      _ifUseElseParse(content: ifUseElsePart);
    } catch (e, st) {
      debugPrint(content: '$e\n已绑定 cm：${cm.variables.keys.toString()}', st: st);
    }
    logger.i(debugPrintStringBuffer);
    return this;
  }

  /// 去掉全部注释
  String _clearAnnotated(String content) {
    debugPrint(content: '正在清除注释...');
    final result = content.replaceAll(RegExper.annotation, '');
    debugPrint(content: '清除注释成功，清除后：\n$result');
    return result;
  }

  /// 空合并运算符评估，并去掉空表达式
  String _emptyMergeDetection(String content) {
    debugPrint(content: '正在评估并清除空合并运算符...');
    // 检测出全部 (abc??123) 或 (xxx_n??123)，并添加至 emptyMergeVariables 中。
    for (var v in RegExper.bracketDoubtBracket.allMatches(content)) {
      // (abc ?? 123) -> abc 123
      final bracketInternal = content.substring(v.start + 1, v.end - 1);
      // abc??123
      debugPrint(content: '检测出空合并：$bracketInternal');
      final emptyMergeSplit = bracketInternal.split('??');
      if (emptyMergeSplit.length != 2) throw '不规范使用空合并运算符：${v.group(0)}';

      // abc
      final name = emptyMergeSplit.first.trim();
      // TODO: 用命名规范来检验
      if (name == '') throw '不规范名称：$name';

      _emptyMergeVariables.addAll({name: emptyMergeSplit.last.trim()});
      debugPrint(content: '空合并评估并清除成功：$bracketInternal');
    }
    debugPrint(content: '空合并已全部评估并清除完成！');
    // 清除空赋值表达式。
    final clearResult = content.replaceAll(RegExper.doubtBracket, ')');
    final remainEmptyMerges = RegExper.doubt.firstMatch(clearResult);
    if (remainEmptyMerges != null) {
      final start = remainEmptyMerges.start - 20;
      final end = remainEmptyMerges.end + 20;
      throw '空合并表达式必须被小括号包裹：\n${clearResult.substring(start < 0 ? 0 : start, end > clearResult.length ? clearResult.length : end)}';
    }
    debugPrint(content: '评估并清除空合并运算符成功，评估结果：\n$clearResult');
    return clearResult;
  }

  /// 扫描使用到的内置变量，并绑定内置变量、获取内置变量的值
  Future<void> _internalVariablesBindAndObtain({required String content}) async {
    debugPrint(content: '正在评估内置变量...');
    if (InternalVariableConstant.getAllNames.isEmpty) throw '初始内置变量为 empty！';
    for (var match in RegExper.ivcOrNSuffix.allMatches(content)) {
      final variableName = match.group(0)!;
      String easyName = variableName;
      NTypeNumber? nTypeNumber;
      debugPrint(content: '解析出变量：$variableName');
      final nMatch = RegExper.nSuffix.firstMatch(variableName);
      if (nMatch != null) {
        final nMatchStr = nMatch.group(0)!;
        easyName = variableName.substring(0, nMatch.start);
        final nTypeMatch = RegExper.nTypeNames.firstMatch(nMatchStr);
        final nType = NType.values.where((element) => element.name.split(',').last == nTypeMatch!.group(0)!).first;
        final number = int.parse(nMatchStr.substring(nType.name.split('.').last.length + 1, nMatchStr.length));
        nTypeNumber = NTypeNumber(nType: nType, number: number);
      }
      // 相同的变量名值只绑定一次。
      if (!cm.variables.containsKey(variableName)) {
        final result = await state.internalVariablesResultHandler(
          InternalVariableAtom(
            internalVariableConst: InternalVariableConstant.getConstByName(easyName),
            nTypeNumber: nTypeNumber,
          ),
        );
        debugPrint(content: '已扫描到的内置变量及获取到的值：$variableName = $result');
        if (result != null) {
          cm.bindVariableName(variableName, Number(result));
          debugPrint(content: '绑定 ContextModel 成功：$variableName = $result');
        } else {
          if (!_emptyMergeVariables.containsKey(variableName)) throw '$variableName 内置变量存在为空的情况，请使用"??"进行空赋值！';
          final emptyMergeResult = calculate(_emptyMergeVariables[variableName]!);
          cm.bindVariableName(variableName, Number(emptyMergeResult));
          debugPrint(content: '绑定 ContextModel 成功：$variableName = $emptyMergeResult');
        }
      }
    }
    debugPrint(content: '评估内置变量成功！');
  }

  /// 绑定并获取自定义变量值。
  ///
  /// 因为内置变量已经被空赋值了，因此自定义变量始终不为 null，即自定义变量无需空赋值。
  void _definitionVariablesBindAndObtain(String content) {
    debugPrint(content: '正在评估自定义变量...');
    final semicolonSplit = content.trim().split(';');
    for (var assign in semicolonSplit) {
      // 最后一个';'会出现空字符，同时也可以解决连续分号 ';;;' 的问题。
      final assignTrim = assign.trim();
      if (assignTrim == '') continue;
      final eSep = assignTrim.split('=');
      if (eSep.length != 2) {
        if (eSep.length == 1) {
          throw '需要对自定义变量进行赋值：$assignTrim';
        }
        if (eSep.length > 1) {
          throw '多个自定义变量间需要使用";"隔开：$assignTrim';
        }
        throw '未知自定义变量异常：$assignTrim';
      }

      String nameTrim = eSep.first.trim();

      checkNameConvent(name: nameTrim);

      String valueExp = eSep.last.trim();
      late final double result;
      try {
        result = calculate(valueExp);
        cm.bindVariableName(nameTrim, Number(result));
      } on FormatException catch (e) {
        throw '计算异常：\n自定义变量：$nameTrim\n计算内容：$valueExp\n计算结果异常：${e.message}';
      } on ArgumentError catch (e) {
        throw '计算异常：\n自定义变量：$nameTrim\n计算内容：$valueExp\n计算结果异常：${e.message}';
      }
      debugPrint(content: '绑定 ContextModel 成功：$nameTrim = $valueExp');
    }
    debugPrint(content: '评估自定义变量成功！');
  }

  /// if-use-else 语句解析。
  void _ifUseElseParse({required String content}) {
    debugPrint(content: '正在评估 if-use-else 语句...');
    final elseMatches = RegExper.elseKeyword.allMatches(content);
    if (elseMatches.isEmpty) throw '缺少 "else:" 语句！若不想使用 "else:" 语句，请使用 "else: throw 说明" 来进行异常处理！（程序会解析"说明"信息并展示给用户查看）';
    final elseMatch = elseMatches.first;
    final elseContent = content.substring(elseMatch.end, content.length).trim();
    if (elseContent == '') throw '"else:" 语句不能为空！';
    debugPrint(content: 'else 内容：\n$elseContent');
    final ifUseContent = content.substring(0, elseMatch.start).trim();
    debugPrint(content: 'if-use 内容：\n$ifUseContent');
    final ifUses = ifUseContent.split('if:');
    if (ifUses.length == 1) throw '缺少 "if:" 语句！';
    // 去掉第一个 'if:' 前的空白。
    ifUses.removeAt(0);
    for (var iu in ifUses) {
      debugPrint(content: '解析出 -use:- 内容：\n$iu');
      final iuTrim = iu.trim();
      if (iuTrim == '') throw '不规范使用 if-use 语句！';
      if (!iuTrim.contains('use:')) throw '缺少 "use:" 语句：$iuTrim';
      final i2u = iuTrim.split('use:');
      if (i2u.length != 2) throw '不规范使用 if 语句：$iuTrim';
      final i = i2u.first.trim();
      debugPrint(content: '解析出 if 内容：\n$i');
      if (i == '') throw '"if:" 语句内容不能为空：$iuTrim';
      final u = i2u.last.trim();
      debugPrint(content: '解析出 use 内容：\n$u');
      if (u == '') throw '"use:" 语句内容不能为空：$iuTrim';
      if (_ifParse(content: i)) {
        _useParse(content: u);
        debugPrint(content: '所使用的 use 语句：$u\n计算结果：${state.toStringResult()}');
        return;
      }
    }
    if (elseContent.contains('throw')) throw elseContent.substring(elseContent.indexOf('throw') + 5, elseContent.length);
    debugPrint(content: '所有 if 语句都不匹配，已执行 else 语句：$elseContent');
    _useParse(content: elseContent);
    debugPrint(content: 'else 语句计算结果：${state.toStringResult()}');
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
