part of algorithm_parser;

class AlgorithmBidirectionalParsing {
  static String parseFromAlgorithmWrapper(AlgorithmWrapper wrapper) {
    String result = "";

    // 解析自定义变量
    for (CustomVariabler v in wrapper.customVariables) {
      result += "${v.name} = ${v.content}\n";
    }
    result += "\n";

    // son-father
    final sonFatherMap = <IfUseElseWrapper, IfUseElseWrapper?>{};
    _handeFatherMap(fatherMap: sonFatherMap, father: null, son: wrapper.ifUseElseWrapper);

    result += _parseIfUseElseWrapper(sonFatherMap, wrapper.ifUseElseWrapper);

    return result;
  }

  static void _handeFatherMap({
    required Map<IfUseElseWrapper, IfUseElseWrapper?> fatherMap,
    required IfUseElseWrapper? father,
    required IfUseElseWrapper son,
  }) {
    fatherMap.addAll({son: father});
    son.ifers.forEach((element) {
      if (element.ifElseUseWrapper != null) {
        _handeFatherMap(fatherMap: fatherMap, father: son, son: element.ifElseUseWrapper!);
      }
    });
    if (son.elser.ifElseUseWrapper != null) {
      _handeFatherMap(fatherMap: fatherMap, father: son, son: son.elser.ifElseUseWrapper!);
    }
  }

  /// [self] 要寻找哪个的父辈。
  /// [fatherList] 初始化为空数组。
  static List<IfUseElseWrapper> _geiFathers(Map<IfUseElseWrapper, IfUseElseWrapper?> map, IfUseElseWrapper self, List<IfUseElseWrapper> fatherList) {
    var findFather = map[self];
    if (findFather != null) {
      fatherList.add(findFather);
      _geiFathers(map, findFather, fatherList);
    }
    return fatherList;
  }

  static String _parseIfUseElseWrapper(Map<IfUseElseWrapper, IfUseElseWrapper?> map, IfUseElseWrapper ifUseElseWrapper) {
    String result = "";
    if (ifUseElseWrapper.ifers.isEmpty) {
      throw KnownAlgorithmException("if 语句不存在！");
    }

    int fatherCount = _geiFathers(map, ifUseElseWrapper, []).length;

    // 解析if语句
    for (Ifer ifer in ifUseElseWrapper.ifers) {
      if (ifUseElseWrapper.ifers.first == ifer) {
        result += "${"  " * fatherCount}if (${ifer.condition}) \n${"  " * fatherCount}{\n";
      } else {
        result += "${"  " * fatherCount}else if (${ifer.condition}) \n${"  " * fatherCount}{\n";
      }

      if (ifer.use == null && ifer.ifElseUseWrapper == null) {
        throw KnownAlgorithmException("if 的 use 和 ifElseUseWrapper 必须存在一个不为 null");
      }
      if (ifer.use != null && ifer.ifElseUseWrapper != null) {
        throw KnownAlgorithmException("if 的 use 和 ifElseUseWrapper 不能同时不为 null");
      }

      // 解析使用的变量
      if (ifer.use != null) {
        result += "${"  " * fatherCount}  ${ifer.use}";
      }

      // 解析if-else语句包装器
      if (ifer.ifElseUseWrapper != null) {
        result += _parseIfUseElseWrapper(map, ifer.ifElseUseWrapper!);
      }

      result += "\n${"  " * fatherCount}} \n";
    }

    if (ifUseElseWrapper.elser.use == null && ifUseElseWrapper.elser.ifElseUseWrapper == null) {
      throw KnownAlgorithmException("else 的 use 和 ifElseUseWrapper 必须存在一个不为 null");
    }
    if (ifUseElseWrapper.elser.use != null && ifUseElseWrapper.elser.ifElseUseWrapper != null) {
      throw KnownAlgorithmException("else 的 use 和 ifElseUseWrapper 不能同时不为 null");
    }

    result += "${"  " * fatherCount}else \n${"  " * fatherCount}{\n";
    // 解析else语句
    if (ifUseElseWrapper.elser.use != null) {
      result += "${"  " * fatherCount}  ${ifUseElseWrapper.elser.use}";
    }

    // 解析else内部的if-else语句包装器
    if (ifUseElseWrapper.elser.ifElseUseWrapper != null) {
      result += _parseIfUseElseWrapper(map, ifUseElseWrapper.elser.ifElseUseWrapper!);
    }
    result += "\n${"  " * fatherCount}} ";
    return result;
  }

  // 解析嵌套的 if-else 字符串
  static AlgorithmWrapper parseFromString(String content) {
    final match = RegExp(r'\bif\b').firstMatch(content);
    final customVariablesContent = match == null ? null : content.substring(0, match.start);
    final ifUseElseWrapperContent = match == null ? null : content.substring(match.start, content.length);

    final customVariables = _customVariablerLoop(customVariablesContent ?? "");
    final ifUseElseWrapper = _ifUseElseWrapperLoop(ifUseElseWrapperContent ?? "");
    return AlgorithmWrapper(customVariables: customVariables, ifUseElseWrapper: ifUseElseWrapper ?? IfUseElseWrapper.emptyIfUseElseWrapper);
  }

  static List<CustomVariabler> _customVariablerLoop(String content) {
    final customVariables = <CustomVariabler>[];
    RegExp(r"([^\r\n]+)|([^\n]+)").allMatches(content).forEach(
      (element) {
        final singleContent = element.group(0)!;
        final sp = singleContent.split("=");
        if (sp.length != 2) {
          if (singleContent.trim().isNotEmpty) {
            customVariables.add(CustomVariabler(name: element.group(0)!.trim(), content: "", explain: ""));
          }
        } else {
          customVariables.add(CustomVariabler(name: sp.first.trim(), content: sp.last.trim(), explain: ""));
        }
      },
    );
    return customVariables;
  }

  /// 返回 null 表示不存在 if-else 语句。
  static IfUseElseWrapper? _ifUseElseWrapperLoop(String fatherStr) {
    final ifUseElseWrapper = IfUseElseWrapper(ifers: [], elser: Elser(use: "", ifElseUseWrapper: null, explain: null));
    String? remainStr = fatherStr;
    while (true) {
      if (remainStr == null) {
        break;
      }
      remainStr = _bodyHandle(remainStr + " ", ifUseElseWrapper);
    }

    return ifUseElseWrapper.ifers.isEmpty ? null : ifUseElseWrapper;
  }

  /// 返回剩下的内容，返回 null 表示没有剩下了。
  static String? _bodyHandle(String loopStr, IfUseElseWrapper ifUseElseWrapper) {
    // 花括号
    final braces = <String>[];
    int? firstBraceIndex;
    int? leftBraceIndex;
    int? rightBraceIndex;
    for (int i = 0; i < loopStr.length; i++) {
      final current = loopStr[i];
      if (current == "{") {
        firstBraceIndex ??= i;
        leftBraceIndex ??= i;
        braces.add("{");
      } else if (current == "}") {
        if (braces.isEmpty) {
          throw KnownAlgorithmException("不能没有左花括号！");
        }
        braces.removeLast();
        if (braces.isEmpty) {
          rightBraceIndex ??= i;
          break;
        }
      }
    }
    final ifElseTypeRegExp = RegExp(r"(^if$)|(^else$)|(^else(\s+)if$)");

    // 没有前后花括号
    if (firstBraceIndex == null || leftBraceIndex == null || rightBraceIndex == null) {
      return null;
    }

    final ifElseTypeOrConditionStr = loopStr.substring(0, firstBraceIndex).trim();
    final ifElseType =
        ifElseTypeOrConditionStr.contains("(") ? ifElseTypeOrConditionStr.substring(0, ifElseTypeOrConditionStr.indexOf("(")).trim() : ifElseTypeOrConditionStr.trim();
    late final String condition;
    if (ifElseType != "else") {
      condition = ifElseTypeOrConditionStr.substring(ifElseTypeOrConditionStr.indexOf("(") + 1, ifElseTypeOrConditionStr.lastIndexOf(")")).trim();
    }
    final body = loopStr.substring(leftBraceIndex + 1, rightBraceIndex);

    // 前面存在 if 或 else if 或 else
    if (ifElseTypeRegExp.hasMatch(ifElseType)) {
      if (ifElseType != "else") {
        final loopResult = _ifUseElseWrapperLoop(body);
        ifUseElseWrapper.ifers.add(Ifer(condition: condition, use: loopResult == null ? body.trim() : null, ifElseUseWrapper: loopResult, explain: null));
      } else {
        final loopResult = _ifUseElseWrapperLoop(body);
        ifUseElseWrapper.elser.use = loopResult == null ? body.trim() : null;
        ifUseElseWrapper.elser.ifElseUseWrapper = loopResult;
      }
    }

    // 多一个空格防止 +1 越界
    return loopStr.substring(rightBraceIndex + 1, loopStr.length);
  }
}
