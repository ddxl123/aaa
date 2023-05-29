part of algorithm_parser;

class AlgorithmParser<CS extends ClassificationState> with Explain {
  AlgorithmParser._();

  late final CS _state;

  static const nullTag = '_tag_null_tag_';

  static const bool isDebug = true;

  /// 计算
  static double calculate(String content) {
    try {
      return Parser().parse(content).evaluate(EvaluationType.REAL, ContextModel());
    } catch (e) {
      throw KnownAlgorithmException('运算解析失败：$content\n$e');
    }
  }

  static Future<R> parse<CS extends ClassificationState, R>({
    required CS Function() stateFunc,
    required Future<R> Function(CS state) onSuccess,
    required Future<R> Function(AlgorithmException ec) onError,
  }) async {
    return await AlgorithmParser<CS>._()._parse<R>(stateFunc: stateFunc, onSuccess: onSuccess, onError: onError);
  }

  Future<R> _parse<R>({
    required CS Function() stateFunc,
    required Future<R> Function(CS state) onSuccess,
    required Future<R> Function(AlgorithmException algorithmException) onError,
  }) async {
    try {
      _state = stateFunc();
      AlgorithmWrapper algorithmWrapper = _state.algorithmWrapper;

      _state.algorithmWrapper.customVariablesMap.clear();
      await Future.forEach<CustomVariabler>(
        _state.algorithmWrapper.customVariables,
        (ele) async {
          try {
            checkCustomVariableNameConvention(name: ele.name);
          } on KnownAlgorithmException catch (e) {
            ele.setNameAlgorithmException(algorithmException: e);
            rethrow;
          } catch (e, st) {
            if (e is UnknownAlgorithmException) rethrow;
            throw UnknownAlgorithmException(e.toString(), st);
          }
          try {
            final contentResult = await _eval(content: ele.content);
            _state.algorithmWrapper.customVariablesMap.addAll({ele.name: contentResult});
            ele.setContentAlgorithmException(algorithmException: null);
          } on KnownAlgorithmException catch (e) {
            ele.setContentAlgorithmException(algorithmException: e);
            rethrow;
          } catch (e, st) {
            if (e is UnknownAlgorithmException) rethrow;
            throw UnknownAlgorithmException(e.toString(), st);
          }
        },
      );

      await algorithmWrapper.ifUseElseWrapper.handle(
        conditionChecker: (Ifer ifer, String condition) async {
          try {
            final result = await _eval(content: condition);
            final parseResult = _ifParse(content: result);
            ifer.setConditionAlgorithmException(algorithmException: null);
            return parseResult;
          } on KnownAlgorithmException catch (e) {
            ifer.setConditionAlgorithmException(algorithmException: e);
            rethrow;
          } catch (e, st) {
            if (e is UnknownAlgorithmException) rethrow;
            throw UnknownAlgorithmException(e.toString(), st);
          }
        },
        useChecker: (Ifer ifer, String use) async {
          try {
            final result = await _eval(content: use);
            _useParse(content: result);
          } on KnownAlgorithmException catch (e) {
            ifer.setUseAlgorithmException(algorithmException: e);
            rethrow;
          } catch (e, st) {
            if (e is UnknownAlgorithmException) rethrow;
            throw UnknownAlgorithmException(e.toString(), st);
          }
        },
        elseChecker: (Elser elser, String use) async {
          try {
            final result = await _eval(content: use);
            _useParse(content: result);
          } on KnownAlgorithmException catch (e) {
            elser.setUseAlgorithmException(algorithmException: e);
            rethrow;
          } catch (e, st) {
            if (e is UnknownAlgorithmException) rethrow;
            throw UnknownAlgorithmException(e.toString(), st);
          }
        },
      );
      return await onSuccess(_state);
    } catch (o, st) {
      if (isDebug) {
        logger.outError(error: o, stackTrace: st);
      }
      return await onError(UnknownAlgorithmException(o.toString(), st));
    }
  }

  Future<String> _eval({required String content}) async {
    final evalCustomVariablesResult = _evalCustomVariables(content: content);
    final evalInternalVariablesResult = await _evalInternalVariables(content: evalCustomVariablesResult);
    final emptyMergeEvalResult = _emptyMergeEval(content: evalInternalVariablesResult);
    return emptyMergeEvalResult;
  }

  /// 评估自定义变量。
  String _evalCustomVariables({required String content}) {
    return content.replaceAllMapped(
      RegExper.variableMatching('(${_state.algorithmWrapper.customVariablesMap.keys.map((e) => '($e)').join('|').nothingMatches()})'),
      (match) {
        return '(${_state.algorithmWrapper.customVariablesMap[match.group(0)!]!})';
      },
    );
  }

  /// 评估内置变量。
  ///
  /// 可能会返回 [nullTag]。
  Future<String> _evalInternalVariables({required String content}) async {
    if (InternalVariableConstantHandler.getNames.isEmpty) throw KnownAlgorithmException('初始内置变量为 empty！');

    // 内置变量-对应的结果值
    final internalVariable2ResultMap = <String, num?>{};

    for (var match in RegExper.fullName.allMatches(content)) {
      final fullName = match.group(0)!;
      String simplifyName = fullName;
      NTypeNumber? nTypeNumber;
      final nMatch = RegExper.nSuffix.firstMatch(fullName);
      // 若变量含后缀
      if (nMatch != null) {
        final nMatchStr = nMatch.group(0)!;
        simplifyName = fullName.substring(0, nMatch.start);
        final nTypeMatch = RegExper.nTypeNames.firstMatch(nMatchStr);
        final nType = NType.values.where((element) => element.name.split(',').last == nTypeMatch!.group(0)!).first;
        final number = int.tryParse(nMatchStr.substring(nType.name.split('.').last.length + 1, nMatchStr.length));
        if (number == null) {
          throw KnownAlgorithmException('扩展类型的后缀必须携带数值，例如 xxx_times1');
        }
        nTypeNumber = NTypeNumber(nType: nType, suffixNumber: number);
      }
      // 相同的变量名值只绑定一次，但是 hasNullMerge 必须每次都执行。
      final atom = InternalVariableAtom(
        internalVariableConstant: InternalVariableConstantHandler.getConstByName(simplifyName),
        currentState: _state,
        nTypeNumber: nTypeNumber,
        hasNullMerge: match.input.substring(match.end, match.input.length).contains(RegExper.isExistNullMerge),
      );
      atom.handleException();

      if (internalVariable2ResultMap.containsKey(fullName)) {
        if (internalVariable2ResultMap[fullName] == null) {
          internalVariable2ResultMap[fullName] = (await _state.internalVariablesResultHandler(atom)).nr;
        }
      } else {
        internalVariable2ResultMap.addAll({fullName: (await _state.internalVariablesResultHandler(atom)).nr});
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
    return EmptyMergeParser.parse(content: content);
  }

  /// 解析 if 语句。
  bool _ifParse({required String content}) {
    return IfExprParse.parse(content: content);
  }

  /// 解析 use 语句。
  void _useParse({required String content}) {
    _state.useParse(useContent: content);
  }
}
