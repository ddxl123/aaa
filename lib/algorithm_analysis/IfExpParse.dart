class Bracket2Index {
  final String bracket;
  final int index;

  Bracket2Index({required this.bracket, required this.index});
}

class IfExpParse {
  static const logicalOperator = ['|', '&'];
  static const relationalOperator = ['==', '!=', '<=', '>=', '<', '>'];

  static const logicalOperatorRegExp = ['\\|', '&'];
  static const relationalOperatorRegExp = ['==', '!=', '<=', '>=', '<', '>'];

  List<String> get allOperator => [...logicalOperator, ...relationalOperator];

  List<String> get allOperatorRegExp => [...logicalOperatorRegExp, ...relationalOperatorRegExp];

  /// 括号以及 index。
  final bracket2Indexes = <Bracket2Index>[];

  String relCal({required double left, required String rel, required double right}) {
    final relTrim = rel.trim();
    if (relTrim == '==') return (left == right).toString();
    if (relTrim == '!=') return (left != right).toString();
    if (relTrim == '<') return (left < right).toString();
    if (relTrim == '>') return (left > right).toString();
    if (relTrim == '<=') return (left <= right).toString();
    if (relTrim == '>=') return (left >= right).toString();
    throw '未知关系运算符 $relTrim';
  }

  //
  String logicalCal({required String left, required String center, required String right}) {
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

  bool ifExpParse(String content) => _recursion(content) == 'true' ? true : false;

  /// [content] 为输入规范化的 if 语句。
  ///
  /// 返回 false
  String _recursion(String content) {
    for (var bracketMatch in RegExp(r'\(|\)').allMatches(content)) {
      final bracket = bracketMatch.group(0)!;
      if (bracket == '(') {
        bracket2Indexes.add(Bracket2Index(bracket: bracket, index: bracketMatch.start));
      } else if (bracket == ')') {
        if (bracket2Indexes.isEmpty) throw '缺少前括号！';
        final bracketInternal = content.substring(bracket2Indexes.last.index + 1, bracketMatch.start).trim();
        late final String afterReplace;
        if (bracketInternal.contains(RegExp(allOperatorRegExp.map((e) => '($e)').join('|'))) ||
            bracketInternal == 'true' ||
            bracketInternal == 'false') {
          final boolResult = _multiCompareParse(bracketInternal);
          afterReplace = content.replaceAll(content.substring(bracket2Indexes.last.index, bracketMatch.end), boolResult);
        } else {
          // TODO: 计算
          final calResult = 111111.toString();
          afterReplace = content.replaceAll(content.substring(bracket2Indexes.last.index, bracketMatch.end), calResult);
        }
        return _recursion(afterReplace);
      } else {
        throw '括号匹配异常！';
      }
    }
    return _multiCompareParse(content);
  }

  /// 不带括号的多个比较解析，例如：a<b | c>d & false | true，也可以是单个 a<b 或 true。
  ///
  /// 返回字符串 true 或 false。
  String _multiCompareParse(String content) {
    final regExp = RegExp(logicalOperatorRegExp.map((e) => '($e)').join('|'));
    if (!content.contains(regExp)) {
      return _singleCompareParse(content);
    }

    String? result;
    for (var multiCompareMatch in regExp.allMatches(content)) {
      final leftResult = result ?? _singleCompareParse(content.substring(0, multiCompareMatch.start).split(regExp).last.trim());
      final rightResult = _singleCompareParse(content.substring(multiCompareMatch.end, content.length).split(regExp).first.trim());
      final center = multiCompareMatch.group(0)!;
      result = logicalCal(left: leftResult, center: center, right: rightResult);
    }
    return result!;
  }

  /// 不带括号的单个比较解析，例如：a <= b，也可以是单个 false 或 true。
  ///
  /// 返回字符串 true 或 false。
  String _singleCompareParse(String content) {
    final contentTrim = content.trim();
    if (contentTrim == 'true' || contentTrim == 'false') return contentTrim;

    final singleCompareMatch = RegExp(relationalOperatorRegExp.map((e) => '($e)').join('|')).allMatches(contentTrim).first;
    // TODO: 不能直接使用 true 或 false 来命名。
    // TODO: 计算
    final left = contentTrim.substring(0, singleCompareMatch.start);
    final leftParse = double.tryParse(left);
    // TODO: 计算
    final right = contentTrim.substring(singleCompareMatch.end, contentTrim.length);
    final rightParse = double.tryParse(right);
    if (leftParse == null) throw '${contentTrim.substring(singleCompareMatch.start, singleCompareMatch.end)} 的左边不规范书写！';
    if (rightParse == null) throw '${contentTrim.substring(singleCompareMatch.end, contentTrim.length)} 的右边不规范书写！';
    return relCal(left: leftParse, rel: singleCompareMatch.group(0)!, right: rightParse);
  }
}
