part of algorithm_parser;

class RegExper {
  RegExper._();

  /// 匹配变量名称的正则表达式。
  static RegExp variableMatching(String matchContent) {
    // ((?<=\W)_abc(?=\W))|(^_abc(?=\W))|((?<=\W)_abc$)
    return RegExp(
      r'((?<=\W)'
      '$matchContent'
      r'(?=\W))'
      r'|'
      r'(^'
      '$matchContent'
      r'(?=\W))'
      r'|'
      r'((?<=\W)'
      '$matchContent'
      r'$)',
    );
  }

  /// 控制台截取的日志的正则表达式。
  static final consolePrint = RegExp(r'#1[\S\s]*#2');

  /// 匹配注释的正则表达式。
  static final annotation = RegExp(r'<--([\S\s]*?)-->');

  /// 匹配 ?? 的正则表达式。
  static final doubt = RegExp(r'\?\?');

  /// 匹配 abc 或 abc_times 或 abc_times1 的正则表达式。
  ///
  /// 包含 abc_times 是为了能提示用户应该在结尾增加数值。
  ///
  /// 注意前后不包含变量正则表达式。
  static RegExp get fullName => variableMatching(
        '(${InternalVariableConstantHandler.getNames.map((e) => '($e)').join('|').nothingMatches()})'
        '(_(${NType.values.map((e) => '(${e.name})').join('|').nothingMatches()})([0-9]*))?',
      );

  /// 匹配 _[NType]1 后缀的正则表达式，且以其为结尾。
  ///
  /// 识别 [fullName] 是否为含 [NType] 类型的变量。
  static RegExp get nSuffix => RegExp('(_(${NType.values.map((e) => '(${e.name})').join('|').nothingMatches()})([0-9]*))\$');

  /// 匹配 [NType]。
  ///
  /// 识别 [nSuffix] 内的 [NType]。
  static RegExp get nTypeNames => RegExp('(${NType.values.map((e) => '(${e.name})').join('|')})');

  /// 匹配 else: 的正则表达式。
  ///
  /// 注意前缀不包含变量正则表达式。
  static final elseKeyword = RegExp(r'\Welse:');

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

  /// 匹配变量右侧是否存在空合并运算符。
  static final isExistNullMerge = RegExp(r'^(((\))|( ))*)\?\?');
}

extension NothingMatches on String {
  String nothingMatches() {
    return this == '' ? 'n_o_t_h_i_n_g_m_a_t_c_h_e_s' : this;
  }
}
