part of algorithm_parser;

class RegExper {
  RegExper._();

  /// 控制台截取的日志的正则表达式。
  static final consolePrint = RegExp(r'#1[\S\s]*#2');

  /// 匹配注释的正则表达式。
  static final annotation = RegExp(r'<--([\S\s]*?)-->');

  /// 匹配 (abc??123) 的正则表达式。
  // static final bracketDoubtBracket = RegExp(r'\(([^\(\)]*?)\?\?([^\(\)]*?)\)');

  /// 匹配 ??123) 的正则表达式。
  // static final doubtBracket = RegExp(r'\?\?([^\(\)]*?)\)');

  /// 匹配 ?? 的正则表达式。
  static final doubt = RegExp(r'\?\?');

  /// 匹配 [NType] 名称的正则表达式。
  static final nTypeNames = RegExp('(${NType.values.map((e) => e.name.split('.').last).join('|').nothingMatches()})');

  /// 匹配 _times1 后缀的正则表达式。
  static RegExp get nSuffix => RegExp('(_$nTypeNames([0-9]+))\$');

  /// 匹配 abc 或 abc_times1 的正则表达式。
  static RegExp get ivcOrNSuffix => RegExp(InternalVariableConstant.getAllNames.map((e) => "(($e)(_$nTypeNames([0-9]+))?)").join('|').nothingMatches());

  /// 匹配 else: 的正则表达式。
  static final elseKeyword = RegExp('else:');

  /// 匹配全部运算符的正则表达式。（有个别不包含在内）
  static final allOperator = RegExp(allOperatorRegExp.map((e) => '($e)').join('|').nothingMatches());

  /// 匹配全部关系运算符的正则表达式。
  static final relationalOperator = RegExp(oRelationalOperatorRegExp.map((e) => '($e)').join('|').nothingMatches());

  /// 匹配全部逻辑运算符的正则表达式。
  static final logicalOperator = RegExp(oLogicalOperatorRegExp.map((e) => '($e)').join('|').nothingMatches());

  /// 匹配 () 的正则表达式。
  static final bracket = RegExp(r'\(|\)');

  /// 匹配全部个位数字的正则表达式。
  static final oneDigitNumber = RegExp(r'[0-9]');

  /// 匹配空白字符(包括空格、制表符、换页符等)的正则表达式。
  static final blank = RegExp(r'\s');

  /// 匹配非字母、数字、下划线的正则表达式。
  static final nameNonConvention = RegExp(r'\W');
}

extension NothingMatches on String {
  String nothingMatches() {
    return this == '' ? 'n_o_t_h_i_n_g_m_a_t_c_h_e_s' : this;
  }
}
