part of algorithm_parser;

class AlgorithmParser<CS extends ClassificationState> with Explain {
  final ContextModel _cm = ContextModel();

  bool _isParsed = false;

  late final CS _state;

  static const nullTag = '_tag_null_tag_';

  /// 是否记录并输出日志
  final bool _isRecordLog = false;

  final StringBuffer _logStringBuffer = StringBuffer();

  ExceptionContent? exceptionContent;

  /// 记录日志。
  ///
  /// 异常捕获会在 [recordLog] 之前捕获。
  void recordLog({required String content}) {
    if (_isRecordLog) {
      final currentSt = RegExper.consolePrint.allMatches(StackTrace.current.toString()).first.group(0)!.trim();
      _logStringBuffer.write(
        '\n-------------------------------------------------------------------\n$content\n${currentSt.substring(2, currentSt.length - 2).trim()}',
      );
    }
  }

  /// 最终展示日志。
  void showLog() {
    if (_isRecordLog) {
      logger.outNormal(print: _logStringBuffer);
    }
  }

  /// 计算
  double calculate(String content) {
    try {
      return Parser().parse(content).evaluate(EvaluationType.REAL, _cm);
    } catch (e) {
      throw '运算解析失败：$content\n$e';
    }
  }

  Future<T> handle<T>({
    required Future<T> Function(CS state) onSuccess,
    required Future<T> Function(ExceptionContent ec) onError,
  }) async {
    try {
      if (exceptionContent == null) {
        return await onSuccess(_state);
      } else {
        return await onError(exceptionContent!);
      }
    } catch (e, st) {
      return await onError(ExceptionContent(error: e, stackTrace: st));
    }
  }

  /// 使用 [handle] 来处理结果。
  Future<AlgorithmParser<CS>> parse({required CS state}) async {
    try {
      if (_isParsed) throw '每个 AlgorithmParser 实例只能使用一次 parse！若想多次使用，则需要创建多个 AlgorithmParser 实例。';
      _isParsed = true;

      _state = state;

      recordLog(content: RegExper.consolePrint.allMatches(StackTrace.current.toString()).first.group(0)!);
      recordLog(content: '【开始解析 ${state.getStateType}...】');

      AlgorithmWrapper algorithmWrapper = state.algorithmWrapper;

      algorithmWrapper = _evalCustomVariables(definitionPart: definitionPart, ifUseElsePart: ifUseElsePart);
      algorithmWrapper = await _evalInternalVariables(content: algorithmWrapper);
      algorithmWrapper = _emptyMergeEval(content: algorithmWrapper);

      _evalIfUseElse(content: algorithmWrapper);
    } catch (o, st) {
      exceptionContent = ExceptionContent(error: o, stackTrace: st);
      recordLog(content: exceptionContent.toString());
    }

    recordLog(content: '【解析完成 ${state.getStateType}！】');
    showLog();
    return this;
  }

  /// 评估自定义变量。
  ///
  /// 清除自定义变量部分，并替换 if-use-else 语句中的全部自定义变量。
  ///
  /// 返回被替换后的 if-use-else 语句，结果中的变量只存在内置变量。
  String _evalCustomVariables({required String definitionPart, required String ifUseElsePart}) {
    recordLog(content: '正在评估自定义变量...');
    final name2Value = <String, String>{};

    // 替换变量
    String replace(String inputContent) {
      recordLog(content: '已存：$name2Value');
      final replaceResult = inputContent.replaceAllMapped(
        RegExper.variableMatching('(${name2Value.keys.map((e) => '($e)').join('|').nothingMatches()})'),
        (match) {
          final returnResult = '(${name2Value[match.group(0)!]!})';
          return returnResult;
        },
      );

      return replaceResult;
    }

    final semicolonSplit = definitionPart.trim().split(';');
    for (var assign in semicolonSplit) {
      // 最后一个';'会出现空字符，同时也可以解决连续分号 ';;;' 的问题。
      final assignTrim = assign.trim();
      if (assignTrim == '') continue;
      final eSep = assignTrim.split('=');
      if (eSep.length != 2) {
        if (eSep.isEmpty || eSep.length == 1) {
          throw '需要对自定义变量进行赋值：$assignTrim';
        } else {
          throw '多个自定义变量间需要使用";"隔开：$assignTrim';
        }
      }

      final name = checkCustomVariableNameConvention(name: eSep.first.trim());
      final originalVal = eSep.last.trim();
      final nowVal = replace(originalVal);
      recordLog(content: '识别到：name:$name originalVal:$originalVal nowVal:$nowVal');
      if (name2Value.containsKey(name)) {
        throw '自定义变量名不能重复：$name';
      }
      name2Value.addAll({name: nowVal});
    }

    final result = replace(ifUseElsePart);
    recordLog(content: '替换结果：\n$result');
    recordLog(content: '评估自定义变量完成！');
    return result;
  }

  /// 评估内置变量。
  ///
  /// 扫描使用到的内置变量，并获取内置变量的值，最后替换成结果值。
  Future<String> _evalInternalVariables({required String content}) async {
    recordLog(content: '正在评估内置变量...');
    if (InternalVariableConstant.getAllNames.isEmpty) throw '初始内置变量为 empty！';

    // 内置变量：对应的结果值
    final internalVariable2Results = <String, num?>{};

    for (var match in RegExper.fullName.allMatches(content)) {
      final fullName = match.group(0)!;
      String simplifyName = fullName;
      NTypeNumber? nTypeNumber;
      recordLog(content: '解析出变量：$fullName');
      final nMatch = RegExper.nSuffix.firstMatch(fullName);
      // 若变量含后缀
      if (nMatch != null) {
        final nMatchStr = nMatch.group(0)!;
        simplifyName = fullName.substring(0, nMatch.start);
        final nTypeMatch = RegExper.nTypeNames.firstMatch(nMatchStr);
        final nType = NType.values.where((element) => element.name.split(',').last == nTypeMatch!.group(0)!).first;
        final number = int.tryParse(nMatchStr.substring(nType.name.split('.').last.length + 1, nMatchStr.length));
        if (number == null) {
          throw '扩展类型的后缀必须携带数值，例如 xxx_times1';
        }
        nTypeNumber = NTypeNumber(nType: nType, suffixNumber: number);
      }
      // 相同的变量名值只绑定一次，但是 hasNullMerge 必须每次都执行。
      final atom = InternalVariableAtom(
        internalVariableConst: InternalVariableConstant.getConstByName(simplifyName),
        currentState: _state,
        nTypeNumber: nTypeNumber,
        hasNullMerge: match.input.substring(match.end, match.input.length).contains(RegExper.isExistNullMerge),
      );
      atom.handle();

      // 相同的变量名值只绑定一次。
      if (internalVariable2Results.containsKey(fullName)) {
        if (internalVariable2Results[fullName] == null) {
          internalVariable2Results[fullName] = await _state.internalVariablesResultHandler(atom);
        }
      } else {
        internalVariable2Results.addAll({fullName: await _state.internalVariablesResultHandler(atom)});
      }
      recordLog(content: '内置变量结果值：$fullName = ${internalVariable2Results[fullName]}');
    }
    final replaceResult = content.replaceAllMapped(
      RegExper.fullName,
      (match) {
        recordLog(content: '${match.group(0)}');
        final result = internalVariable2Results[match.group(0)!];
        return result != null ? result.toString() : nullTag;
      },
    );
    recordLog(content: '替换结果：\n$replaceResult');
    recordLog(content: '评估内置变量成功！');
    return replaceResult;
  }

  /// 评估空合并。
  String _emptyMergeEval({required String content}) {
    recordLog(content: '正在评估空合并运算符...');
    final result = EmptyMergeParser().parse(content: content, algorithmParser: this);
    recordLog(content: '替换结果：\n$result');
    recordLog(content: '评估空合并完成！');
    return result;
  }

  /// if-use-else 语句解析。
  void _evalIfUseElse({required String content}) {
    recordLog(content: '正在评估 if-use-else 语句...');
    final elseMatches = RegExper.elseKeyword.allMatches(content);
    if (elseMatches.isEmpty) throw '缺少 "else:" 语句！若不想使用 "else:" 语句，请使用 "else: throw 说明" 来进行异常处理！（程序会解析"说明"信息并展示给用户查看）';
    final elseMatch = elseMatches.first;
    final elseContent = content.substring(elseMatch.end, content.length).trim();
    if (elseContent == '') throw '"else:" 语句不能为空！';
    recordLog(content: 'else 内容：\n$elseContent');
    final ifUseContent = content.substring(0, elseMatch.start).trim();
    recordLog(content: 'if-use 内容：\n$ifUseContent');
    final ifUses = ifUseContent.split('if:');
    if (ifUses.length == 1) throw '缺少 "if:" 语句！';
    // 去掉第一个 'if:' 前的空白。
    ifUses.removeAt(0);
    for (var iu in ifUses) {
      recordLog(content: '解析出 -use:- 内容：\n$iu');
      final iuTrim = iu.trim();
      if (iuTrim == '') throw '不规范使用 if-use 语句！';
      if (!iuTrim.contains('use:')) throw '缺少 "use:" 语句：$iuTrim';
      final i2u = iuTrim.split('use:');
      if (i2u.length != 2) throw '不规范使用 if 语句：$iuTrim';
      final i = i2u.first.trim();
      recordLog(content: '解析出 if 内容：\n$i');
      if (i == '') throw '"if:" 语句内容不能为空：$iuTrim';
      final u = i2u.last.trim();
      recordLog(content: '解析出 use 内容：\n$u');
      if (u == '') throw '"use:" 语句内容不能为空：$iuTrim';
      if (_ifParse(content: i)) {
        _useParse(content: u);
        recordLog(content: '所使用的 use 语句：$u\n计算结果：${_state.toStringResult()}');
        return;
      }
    }
    if (elseContent.contains('throw')) throw elseContent.substring(elseContent.indexOf('throw') + 5, elseContent.length);
    recordLog(content: '所有 if 语句都不匹配，已执行 else 语句：$elseContent');
    _useParse(content: elseContent);
    recordLog(content: 'else 语句计算结果：${_state.toStringResult()}');
  }

  /// 解析 if 语句。
  bool _ifParse({required String content}) {
    return IfExprParse().parse(content: content, algorithmParser: this);
  }

  /// 解析 use 语句。
  void _useParse({required String content}) {
    _state.useParse(useContent: content, algorithmParser: this);
  }
}
