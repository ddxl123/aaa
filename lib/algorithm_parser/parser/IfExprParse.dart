part of algorithm_parser;

class IfExprParse {
  IfExprParse._();

  static bool parse({required String content}) {
    return IfExprParse._()._parse(content: content);
  }

  bool _parse({required String content}) {
    bool result = _recursion(content) == 'true' ? true : false;
    return result;
  }

  /// [content] 为输入规范化的 if 语句。
  ///
  /// 返回 false 或 true
  String _recursion(String content) {
    // 存在括号的情况。
    int? bracketIndex;
    for (var bracketMatch in RegExper.bracket.allMatches(content)) {
      final bracket = bracketMatch.group(0)!;
      if (bracket == '(') {
        bracketIndex = bracketMatch.start;
      } else if (bracket == ')') {
        if (bracketIndex == null) throw KnownAlgorithmException('缺少前括号：$content');
        final bracketInternal = content.substring(bracketIndex + 1, bracketMatch.start).trim();
        late final String afterReplace;
        if (bracketInternal.contains(RegExper.allOperator) || bracketInternal == 'true' || bracketInternal == 'false') {
          final boolResult = _multiCompareParse(bracketInternal);
          afterReplace = content.replaceAll(content.substring(bracketIndex, bracketMatch.end), boolResult);
        } else {
          // 当括号内没有任何逻辑运算符和关系运算符时，可能只有算术运算符，因此需要进行计算。
          final calResult = AlgorithmParser.calculate(bracketInternal).toString();
          afterReplace = content.replaceAll(content.substring(bracketIndex, bracketMatch.end), calResult);
        }
        return _recursion(afterReplace);
      } else {
        throw KnownAlgorithmException('括号匹配异常：$content');
      }
    }
    // 不存在括号的情况。
    return _multiCompareParse(content);
  }

  /// 不带括号的多个比较解析，例如：a<b | c>d & false | true，也可以是单个 a<b 或 true。
  ///
  /// 返回字符串 true 或 false。
  String _multiCompareParse(String content) {
    // content 是一个独立的比较关系
    if (!content.contains(RegExper.logicalOperator)) {
      return _singleCompareParse(content);
    }

    // content 是一个非独立的比较关系
    String? result;
    for (var multiCompareMatch in RegExper.logicalOperator.allMatches(content)) {
      final leftResult = result ?? _singleCompareParse(content.substring(0, multiCompareMatch.start).split(RegExper.logicalOperator).last.trim());
      final rightResult = _singleCompareParse(content.substring(multiCompareMatch.end, content.length).split(RegExper.logicalOperator).first.trim());
      final center = multiCompareMatch.group(0)!;
      result = _logicalEvaluate(left: leftResult, center: center, right: rightResult);
    }
    return result!;
  }

  /// 不带括号的单个比较解析，例如：a <= b，也可以是单个 false 或 true。
  ///
  /// 返回字符串 true 或 false。
  String _singleCompareParse(String content) {
    final contentTrim = content.trim();
    if (contentTrim == 'true' || contentTrim == 'false') return contentTrim;
    if (!contentTrim.contains(RegExper.relationalOperator)) throw KnownAlgorithmException('"if:"语句必须是一个比较语句：$content');
    final singleCompareMatch = RegExper.relationalOperator.allMatches(contentTrim).first;
    // TODO: 不能直接使用 true 或 false 来命名。
    final left = AlgorithmParser.calculate(contentTrim.substring(0, singleCompareMatch.start));
    final right = AlgorithmParser.calculate(contentTrim.substring(singleCompareMatch.end, contentTrim.length));
    final center = singleCompareMatch.group(0)!;
    final result = _relationalEvaluate(left: left, rel: center, right: right);
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
    throw KnownAlgorithmException('未知关系运算符：$relTrim');
  }

  String _logicalEvaluate({required String left, required String center, required String right}) {
    final leftTrim = left.trim();
    final centerTrim = center.trim();
    final rightTrim = right.trim();
    final leftBool = leftTrim == 'false' ? false : (leftTrim == 'true' ? true : throw KnownAlgorithmException('bool 解析异常：$leftTrim'));
    final rightBool = rightTrim == 'false' ? false : (rightTrim == 'true' ? true : throw KnownAlgorithmException('bool 解析异常：$rightTrim'));
    if (centerTrim == '|') {
      return (leftBool || rightBool).toString();
    } else if (centerTrim == '&') {
      return (leftBool && rightBool).toString();
    } else {
      throw KnownAlgorithmException('未知逻辑运算符：$centerTrim');
    }
  }
}
