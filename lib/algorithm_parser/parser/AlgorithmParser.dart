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

      _state.algorithmWrapper.customVariables.map(
        (e) {
          _state.algorithmWrapper.customVariablesMap.addAll({e.name: e.content});
        },
      );

      await algorithmWrapper.ifElseUseWrapper.handle(
        conditionChecker: (String condition) async {
          final evalCustomVariablesResult = _evalCustomVariables(content: condition);
          final evalInternalVariablesResult = await _evalInternalVariables(content: evalCustomVariablesResult);
          final emptyMergeEval = _emptyMergeEval(content: evalInternalVariablesResult);
          return _ifParse(content: emptyMergeEval);
        },
        useChecker: (String use) async {
          final evalCustomVariablesResult = _evalCustomVariables(content: use);
          final evalInternalVariablesResult = await _evalInternalVariables(content: evalCustomVariablesResult);
          final emptyMergeEval = _emptyMergeEval(content: evalInternalVariablesResult);
          _useParse(content: emptyMergeEval);
        },
      );
    } catch (o, st) {
      exceptionContent = ExceptionContent(error: o, stackTrace: st);
      recordLog(content: exceptionContent.toString());
    }

    recordLog(content: '【解析完成 ${state.getStateType}！】');
    showLog();
    return this;
  }

  /// 评估自定义变量。
  String _evalCustomVariables({required String content}) {
    String replaceResult = content;
    while (true) {
      final newReplaceResult = content.replaceAllMapped(
        RegExper.variableMatching('(${_state.algorithmWrapper.customVariablesMap.keys.map((e) => '($e)').join('|').nothingMatches()})'),
        (match) {
          return '(${_state.algorithmWrapper.customVariablesMap[match.group(0)!]!})';
        },
      );
      if (newReplaceResult == replaceResult) {
        return newReplaceResult;
      }
    }
  }

  /// 评估内置变量。
  ///
  /// 可能会返回 [nullTag]。
  Future<String> _evalInternalVariables({required String content}) async {
    if (InternalVariableConstant.getAllNames.isEmpty) throw '初始内置变量为 empty！';

    // 内置变量-对应的结果值
    final internalVariable2ResultMap = <String, num?>{};

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

      if (internalVariable2ResultMap.containsKey(fullName)) {
        if (internalVariable2ResultMap[fullName] == null) {
          internalVariable2ResultMap[fullName] = await _state.internalVariablesResultHandler(atom);
        }
      } else {
        internalVariable2ResultMap.addAll({fullName: await _state.internalVariablesResultHandler(atom)});
      }
    }
    final replaceResult = content.replaceAllMapped(
      RegExper.fullName,
      (match) {
        final result = internalVariable2ResultMap[match.group(0)!]!;
        return result != null ? result.toString() : nullTag;
      },
    );
    return replaceResult;
  }

  /// 评估空合并。
  String _emptyMergeEval({required String content}) {
    return EmptyMergeParser().parse(content: content, algorithmParser: this);
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
