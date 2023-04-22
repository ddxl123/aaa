part of algorithm_parser;

class AlgorithmBidirectionalParsing {
  static String parseAlgorithmWrapper(AlgorithmWrapper wrapper) {
    String result = "";

    // 解析自定义变量
    for (CustomVariabler v in wrapper.customVariables) {
      result += "${v.name} = ${v.content}\n";
    }

    // 解析if语句
    for (Ifer ifer in wrapper.ifUseElseWrapper.ifers) {
      result += "if (${ifer.condition}) {\n";

      if (ifer.use == null && ifer.ifElseUseWrapper == null) {
        throw KnownAlgorithmException("if 的 use 和 ifElseUseWrapper 必须存在一个不为 null");
      }
      if (ifer.use != null && ifer.ifElseUseWrapper != null) {
        throw KnownAlgorithmException("if 的 use 和 ifElseUseWrapper 不能同时不为 null");
      }

      // 解析使用的变量
      if (ifer.use != null) {
        result += "${ifer.use}\n";
      }

      // 解析if-else语句包装器
      if (ifer.ifElseUseWrapper != null) {
        result += parseIfUseElseWrapper(ifer.ifElseUseWrapper!);
      }

      result += "} ";
    }

    if (wrapper.ifUseElseWrapper.elser.use == null && wrapper.ifUseElseWrapper.elser.ifElseUseWrapper == null) {
      throw KnownAlgorithmException("else 的 use 和 ifElseUseWrapper 必须存在一个不为 null");
    }
    if (wrapper.ifUseElseWrapper.elser.use != null && wrapper.ifUseElseWrapper.elser.ifElseUseWrapper != null) {
      throw KnownAlgorithmException("else 的 use 和 ifElseUseWrapper 不能同时不为 null");
    }

    result += "else {\n";
    // 解析else语句
    if (wrapper.ifUseElseWrapper.elser.use != null) {
      result += "${wrapper.ifUseElseWrapper.elser.use}";
    }

    // 解析else内部的if-else语句包装器
    if (wrapper.ifUseElseWrapper.elser.ifElseUseWrapper != null) {
      result += parseIfUseElseWrapper(wrapper.ifUseElseWrapper.elser.ifElseUseWrapper!);
    }
    result += "} ";
    return result;
  }

  static String parseIfUseElseWrapper(IfUseElseWrapper ifUseElseWrapper) {
    String result = "";

    // 解析if语句
    for (Ifer ifer in ifUseElseWrapper.ifers) {
      result += "if (${ifer.condition}) {\n";

      // 解析使用的变量
      if (ifer.use != null) {
        result += "${ifer.use};\n";
      }

      // 解析if-else语句包装器
      if (ifer.ifElseUseWrapper != null) {
        result += parseIfUseElseWrapper(ifer.ifElseUseWrapper!);
      }

      result += "} ";
    }

    // 解析else语句
    if (ifUseElseWrapper.elser.use != null) {
      result += "else {\n";

      // 解析if-else语句包装器
      if (ifUseElseWrapper.elser.ifElseUseWrapper != null) {
        result += parseIfUseElseWrapper(ifUseElseWrapper.elser.ifElseUseWrapper!);
      }

      result += "} ";
    }

    return result;
  }
}
