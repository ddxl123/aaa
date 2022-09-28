part of algorithm_parser;

class IfExprParse {
  bool _isParsed = false;
  late final AlgorithmParser _algorithmParser;
  late final Function(String content) _debugPrint;
  late final RegExp _allOperatorRegExp;
  late final RegExp _relationalOperatorRegExp;
  late final RegExp _logicalOperatorRegExp;
  late final RegExp _bracketRegExp;

  bool parse({
    required String content,
    required AlgorithmParser algorithmParser,
  }) {
    _algorithmParser = algorithmParser;
    _debugPrint = _algorithmParser.debugPrint;

    _debugPrint('正在评估 if 语句...');
    if (_isParsed) throw '每个 IfExprParse 实例只能使用一次 parse！';
    _isParsed = true;

    _allOperatorRegExp = RegExp(allOperatorRegExp.map((e) => '($e)').join('|'));
    _relationalOperatorRegExp = RegExp(oRelationalOperatorRegExp.map((e) => '($e)').join('|'));
    _logicalOperatorRegExp = RegExp(oLogicalOperatorRegExp.map((e) => '($e)').join('|'));
    _bracketRegExp = RegExp(r'\(|\)');

    bool result = _recursion(content) == 'true' ? true : false;
    _debugPrint('评估 if 语句成功：\nif 语句：\n$content\n结果：\n$result');
    return result;
  }

  /// [content] 为输入规范化的 if 语句。
  ///
  /// 返回 false 或 true
  String _recursion(String content) {
    // 存在括号的情况。
    int? bracketIndex;
    for (var bracketMatch in _bracketRegExp.allMatches(content)) {
      final bracket = bracketMatch.group(0)!;
      if (bracket == '(') {
        bracketIndex = bracketMatch.start;
      } else if (bracket == ')') {
        if (bracketIndex == null) throw '缺少前括号！';
        final bracketInternal = content.substring(bracketIndex! + 1, bracketMatch.start).trim();
        _debugPrint('已识别到括号部分：($bracketInternal)');
        late final String afterReplace;
        if (bracketInternal.contains(_allOperatorRegExp) || bracketInternal == 'true' || bracketInternal == 'false') {
          final boolResult = _multiCompareParse(bracketInternal);
          afterReplace = content.replaceAll(content.substring(bracketIndex, bracketMatch.end), boolResult);
          _debugPrint('已评估并替换括号内容：($bracketInternal) = $boolResult');
        } else {
          // 当括号内没有任何逻辑运算符和关系运算符时，可能只有算术运算符，因此需要进行计算。
          // 计算
          final calResult = _algorithmParser.calculate(bracketInternal).toString();
          afterReplace = content.replaceAll(content.substring(bracketIndex, bracketMatch.end), calResult);
          _debugPrint('已计算并替换括号内容：($bracketInternal) = $calResult');
        }
        return _recursion(afterReplace);
      } else {
        throw '括号匹配异常！';
      }
    }
    // 不存在括号的情况。
    _debugPrint('未识别到括号！');
    return _multiCompareParse(content);
  }

  /// 不带括号的多个比较解析，例如：a<b | c>d & false | true，也可以是单个 a<b 或 true。
  ///
  /// 返回字符串 true 或 false。
  String _multiCompareParse(String content) {
    if (!content.contains(_logicalOperatorRegExp)) {
      _debugPrint('$content 是一个独立的比较关系');
      return _singleCompareParse(content);
    }

    _debugPrint('$content 是一个非独立的比较关系');
    String? result;
    for (var multiCompareMatch in _logicalOperatorRegExp.allMatches(content)) {
      final leftResult = result ?? _singleCompareParse(content.substring(0, multiCompareMatch.start).split(_logicalOperatorRegExp).last.trim());
      final rightResult = _singleCompareParse(content.substring(multiCompareMatch.end, content.length).split(_logicalOperatorRegExp).first.trim());
      final center = multiCompareMatch.group(0)!;
      result = _logicalEvaluate(left: leftResult, center: center, right: rightResult);
    }
    _debugPrint('评估 $content 的结果为：$result');
    return result!;
  }

  /// 不带括号的单个比较解析，例如：a <= b，也可以是单个 false 或 true。
  ///
  /// 返回字符串 true 或 false。
  String _singleCompareParse(String content) {
    final contentTrim = content.trim();
    if (contentTrim == 'true' || contentTrim == 'false') return contentTrim;
    if (!contentTrim.contains(_relationalOperatorRegExp)) throw '"if:"语句必须是一个比较结果！';
    final singleCompareMatch = _relationalOperatorRegExp.allMatches(contentTrim).first;
    // TODO: 不能直接使用 true 或 false 来命名。
    // 计算
    final left = _algorithmParser.calculate(contentTrim.substring(0, singleCompareMatch.start));
    // 计算
    final right = _algorithmParser.calculate(contentTrim.substring(singleCompareMatch.end, contentTrim.length));
    final center = singleCompareMatch.group(0)!;
    final result = _relationalEvaluate(left: left, rel: center, right: right);
    _debugPrint('$content 的比较结果：$left $center $right -> $result');
    return result;
  }

  String _relationalEvaluate({required double left, required String rel, required double right}) {
    final relTrim = rel.trim();
    if (relTrim == '==') return (left == right).toString();
    if (relTrim == '!=') return (left != right).toString();
    if (relTrim == '<') return (left < right).toString();
    if (relTrim == '>') return (left > right).toString();
    if (relTrim == '<=') return (left <= right).toString();
    if (relTrim == '>=') return (left >= right).toString();
    throw '未知关系运算符 $relTrim';
  }

  String _logicalEvaluate({required String left, required String center, required String right}) {
    final leftTrim = left.trim();
    final centerTrim = center.trim();
    final rightTrim = right.trim();
    final leftBool = leftTrim == 'false' ? false : (leftTrim == 'true' ? true : throw 'bool 解析异常！');
    final rightBool = rightTrim == 'false' ? false : (rightTrim == 'true' ? true : throw 'bool 解析异常！');
    if (centerTrim == '|') {
      return (leftBool || rightBool).toString();
    } else if (centerTrim == '&') {
      return (leftBool && rightBool).toString();
    } else {
      throw '逻辑运算符解析异常！';
    }
  }
}
