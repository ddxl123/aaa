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
  /// 处理多处无相关的空合并。
  ///
  /// 处理类似 '(aaa)-(null???((null??(111+(null??333)))+(null??222)))eee' 的复杂表达式。
  String parse({required String content}) {
    final result = singlePlace(content: content);
    if (result == null) {
      return content;
    }
    return parse(content: result);
  }

  /// 处理单处空合并，包含内嵌空合并处理。
  String? singlePlace({required String content}) {
    IndexAndContent? left;
    IndexAndContent? right;
    final match = RegExp(r'\?\?').firstMatch(content);
    if (match == null) {
      return null;
    }
    left = toFront(match);
    right = toAfter(match);
    print('left: $left right: $right');
    if (left.content.trim() == 'null') {
      final replaceResult = content.replaceRange(left.boundIndex + 1, right.boundIndex, right.content);
      print('replaceResult: $replaceResult');
      return parse(content: replaceResult);
    } else {
      final replaceResult = content.replaceRange(left.boundIndex + 1, right.boundIndex, left.content);
      print('replaceResult: $replaceResult');
      return parse(content: replaceResult);
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
        print('content: $content');
        hasLeftBracket = true;
        break;
      }
      if (indexStr.contains(RegExp(r'\W')) && indexStr != ' ') {
        throw '空合并操作符左边存在不规范字符：$indexStr';
      }
      content = indexStr + content;
    }
    if (!hasLeftBracket) {
      throw '空合并操作符缺少左括号：${content.length < 10 ? content : content.substring(content.length - 10, content.length)}??';
    }
    if (content.trim() == '') {
      throw '空合并操作符左边缺少可空变量！';
    }

    // 含最外层'('
    final leftBracketIndex = match.start - content.length - 1;
    return IndexAndContent(boundIndex: leftBracketIndex, content: content);
  }

// 往后检索
  IndexAndContent toAfter(Match match) {
    final String rightOriginal = match.input.substring(match.end, match.input.length);
    if (rightOriginal.trim() == '') {
      throw '空合并操作符右边缺少内容！';
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
    if (leftBrackets.isEmpty) {
      throw '空合并缺少右括号: $content';
    }
    if (leftBrackets.length > 1) {
      throw '空合并括号分配异常：$content';
    }

    // 含最外层')'
    final rightBracketIndex = match.end + content.length;
    return IndexAndContent(boundIndex: rightBracketIndex, content: content);
  }
}
