part of algorithm_parser;

class AlgorithmBidirectionalParsing {
  static String parseAlgorithmWrapper(AlgorithmWrapper wrapper) {
    String result = "";

    // 解析自定义变量
    for (CustomVariabler v in wrapper.customVariables) {
      result += "${v.name} = ${v.content}\n";
    }

    // son-father
    final sonFatherMap = <IfUseElseWrapper, IfUseElseWrapper?>{};
    _handeFatherMap(fatherMap: sonFatherMap, father: null, son: wrapper.ifUseElseWrapper);

    result += _parseIfUseElseWrapper(sonFatherMap, wrapper.ifUseElseWrapper);


    final inputString = 'if (a > b) { if (a > c) { return a; } else { return c; } } else { if (b > c) { return b; } else { return c; } }';
    final r = parseIfElse(inputString);
    print(r);
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
        result += "${"  " * fatherCount}  return ${ifer.use}";
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
      result += "${"  " * fatherCount}  return ${ifUseElseWrapper.elser.use}";
    }

    // 解析else内部的if-else语句包装器
    if (ifUseElseWrapper.elser.ifElseUseWrapper != null) {
      result += _parseIfUseElseWrapper(map, ifUseElseWrapper.elser.ifElseUseWrapper!);
    }
    result += "\n${"  " * fatherCount}} ";
    return result;
  }

  // 解析嵌套的 if-else 字符串
  static String parseIfElse(String input) {
    // 定义 if 和 else 语句的正则表达式
    final ifPattern = RegExp(r'if\s*\((.*?)\)\s*\{(.*)\}');
    final elsePattern = RegExp(r'else\s*\{(.*)\}');

    // 查找 if 语句的匹配项
    final ifMatch = ifPattern.firstMatch(input);
    if (ifMatch != null) {
      // 解析 true 分支
      final condition = ifMatch.group(1);
      final trueBranch = parseIfElse(ifMatch.group(2)!);
      // 查找 else 分支的匹配项
      final elseMatch = elsePattern.firstMatch(input.substring(ifMatch.end));
      if (elseMatch != null) {
        // 解析 false 分支
        final falseBranch = parseIfElse(elseMatch.group(1)!);
        // 构建 if-else 语句
        return 'if ($condition) { $trueBranch } else { $falseBranch }';
      } else {
        // 构建 if 语句
        return 'if ($condition) { $trueBranch }';
      }
    } else {
      // 如果没有找到 if 语句，则说明字符串已经被解析到最简形式
      return input.trim();
    }
  }
}
