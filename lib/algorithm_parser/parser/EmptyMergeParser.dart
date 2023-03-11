part of algorithm_parser;

class IndexAndContent {
  /// 不包含'('或')'的边界 index。
  final int boundIndex;

  /// '??' 左边或右边的内容。
  final String content;

  IndexAndContent({required this.boundIndex, required this.content});

  @override
  String toString() => '$boundIndex, $content';
}

class EmptyMergeParser {
  EmptyMergeParser._();

  static String parse<T extends ClassificationState>({required String content}) {
    return EmptyMergeParser._()._parse(content: content);
  }

  /// 消除空合并。
  ///
  /// 处理多处无相关的空合并。
  ///
  /// 处理类似 '(aaa)-(null??((null??(111+((null)??333)))+(null??222)))eee' 的复杂表达式。
  String _parse<T extends ClassificationState>({required String content}) {
    return _recursion(content: content);
  }

  String _recursion({required String content}) {
    final result = singlePlace(content: content);
    if (result == null) {
      return content;
    }
    return _recursion(content: result);
  }

  /// 处理单处空合并，包含内嵌空合并处理。
  String? singlePlace({required String content}) {
    IndexAndContent? left;
    IndexAndContent? right;
    final match = RegExper.doubt.firstMatch(content);
    if (match == null) {
      return null;
    }
    left = toFront(match);
    right = toAfter(match);
    if (left.content.trim() == AlgorithmParser.nullTag) {
      final replaceResult = content.replaceRange(left.boundIndex + 1, right.boundIndex, right.content);
      return _recursion(content: replaceResult);
    } else {
      final replaceResult = content.replaceRange(left.boundIndex + 1, right.boundIndex, left.content);
      return _recursion(content: replaceResult);
    }
  }

// 往前检索
  IndexAndContent toFront(Match match) {
    bool hasLeftBracket = false;
    // 不包含最外层'('
    String content = '';
    for (int i = match.start - 1; i >= 0; i--) {
      final indexStr = match.input[i];
      if (indexStr == '(') {
        hasLeftBracket = true;
        break;
      }
      if (indexStr == ')') {
        if (content != '') {
          throw KnownAlgorithmException('不规范使用空合并操作符！\n正确写法：(xxx??yyy) 或 ((xxx??yyy)??zzz), 其中xxx只能为内置变量。');
        }
      } else {
        content = indexStr + content;
      }
    }
    if (!hasLeftBracket) {
      throw KnownAlgorithmException('空合并操作符左边变量缺少左括号！\n正确写法：(xxx??yyy) 或 ((xxx??yyy)??zzz), 其中xxx只能为内置变量。');
    }
    if (content.trim() == '') {
      throw KnownAlgorithmException('空合并操作符左边缺少可能为空的变量！');
    }

    final leftBracketIndex = match.start - content.length - 2;
    return IndexAndContent(boundIndex: leftBracketIndex, content: content);
  }

// 往后检索
  IndexAndContent toAfter(Match match) {
    final String rightOriginal = match.input.substring(match.end, match.input.length);
    if (rightOriginal.trim() == '') {
      throw KnownAlgorithmException('空合并操作符右边缺少内容！');
    }
    // 不包含最外层')'
    String content = '';
    final leftBrackets = <String>[];
    for (int i = 0; i < rightOriginal.length; i++) {
      final indexStr = rightOriginal[i];
      if (indexStr == '(') {
        leftBrackets.add('(');
      }
      if (indexStr == ')') {
        if (leftBrackets.isNotEmpty && leftBrackets.last == '(') {
          leftBrackets.removeLast();
        } else {
          leftBrackets.add(')');
        }
      }
      if (leftBrackets.length == 1 && leftBrackets.first == ')') {
        break;
      }
      content += indexStr;
    }
    if (content.trim() == '') {
      throw KnownAlgorithmException('空合并运算符右边缺少值！');
    }
    if (leftBrackets.isEmpty) {
      throw KnownAlgorithmException('空合并缺少右括号: $content??');
    }
    if (leftBrackets.length > 1) {
      throw KnownAlgorithmException('空合并括号分配异常：$content');
    }

    final rightBracketIndex = match.end + content.length + 1;
    return IndexAndContent(boundIndex: rightBracketIndex, content: content);
  }
}
