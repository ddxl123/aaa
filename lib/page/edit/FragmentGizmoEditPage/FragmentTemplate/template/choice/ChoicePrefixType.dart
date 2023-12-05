enum ChoicePrefixType {
  none(displayName: "不展示前缀"),
  uppercaseLetter(displayName: "大写字母"),
  lowercaseLetter(displayName: "小写字母"),
  arabic(displayName: "阿拉伯数字"),
  roman(displayName: "罗马数字"),
  circle(displayName: "圆圈数字"),
  fullBracket(displayName: "全括号序号"),
  halfBracket(displayName: "半括号序号"),
  middleBracket(displayName: "中括号序号"),
  lowercaseChinese(displayName: "小写中文"),
  uppercaseChinese(displayName: "大写中文");

  const ChoicePrefixType({required this.displayName});

  final String displayName;

  /// AI 提示词：dart语言，将任意阿拉伯数字转换为圆圈数字(例如①)，如果超出，则使用阿拉伯数字自身
  String toTypeFrom(int number) {
    if (number < 1) {
      throw "number 不能校园1：$number";
    }
    switch (this) {
      case ChoicePrefixType.none:
        return "";
      case ChoicePrefixType.uppercaseLetter:
        if (number <= 26) {
          return String.fromCharCode(number + 64);
        } else {
          return number.toString();
        }
      case ChoicePrefixType.lowercaseLetter:
        if (number <= 26) {
          return String.fromCharCode(number + 96);
        } else {
          return number.toString();
        }
      case ChoicePrefixType.arabic:
        return number.toString();
      case ChoicePrefixType.roman:
        return _arabicToRoman(number);
      case ChoicePrefixType.circle:
        if (number <= 20) {
          return String.fromCharCode(number + 9311);
        } else {
          return number.toString();
        }
      case ChoicePrefixType.fullBracket:
        return "($number)";
      case ChoicePrefixType.halfBracket:
        return "$number)";
      case ChoicePrefixType.middleBracket:
        return "[$number]";
      case ChoicePrefixType.lowercaseChinese:
        return _arabicToLowercaseChinese(number);
      case ChoicePrefixType.uppercaseChinese:
        return _arabicToUppercaseChinese(number);
      default:
        throw "未处理类型：$this";
    }
  }

  String _arabicToRoman(int number) {
    final List<String> romanNumerals = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"];
    final List<String> romanTens = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"];
    final List<String> romanHundreds = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"];
    final List<String> romanThousands = ["", "M", "MM", "MMM"];
    if (number >= 4000) {
      return number.toString();
    }
    String result = "";
    result += romanThousands[number ~/ 1000];
    result += romanHundreds[(number % 1000) ~/ 100];
    result += romanTens[(number % 100) ~/ 10];
    result += romanNumerals[number % 10];
    return result;
  }

  String _arabicToLowercaseChinese(int number) {
    final List<String> chineseNumerals = ["", "一", "二", "三", "四", "五", "六", "七", "八", "九"];
    final List<String> chineseUnits = ["", "十", "百", "千", "万", "亿"];
    String result = "";
    int unitIndex = 0;
    while (number > 0) {
      int digit = number % 10;
      if (digit > 0) {
        result = chineseNumerals[digit] + chineseUnits[unitIndex] + result;
      } else if (unitIndex == 0 || !result.startsWith("零")) {
        result = "零" + result;
      }
      number ~/= 10;
      unitIndex++;
      if (unitIndex == 4) {
        // 超过万位，加上“亿”单位
        result = chineseUnits[unitIndex] + result;
        unitIndex++;
      }
    }
    if (result.endsWith("一十")) {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }

  String _arabicToUppercaseChinese(int number) {
    final List<String> chineseNumerals = ["", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"];
    final List<String> chineseUnits = ["", "拾", "佰", "仟", "万", "亿"];
    String result = "";
    int unitIndex = 0;
    while (number > 0) {
      int digit = number % 10;
      if (digit > 0) {
        result = chineseNumerals[digit] + chineseUnits[unitIndex] + result;
      } else if (unitIndex == 0 || !result.startsWith("零")) {
        result = "零" + result;
      }
      number ~/= 10;
      unitIndex++;
      if (unitIndex == 4) {
        // 超过万位，加上“亿”单位
        result = chineseUnits[unitIndex] + result;
        unitIndex++;
      }
    }
    if (result.endsWith("一拾")) {
      result = result.substring(0, result.length - 1) + "十";
    }
    return result;
  }
}
