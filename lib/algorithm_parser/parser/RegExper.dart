part of algorithm_parser;

class RegExper {
  RegExper._();

  /// 控制台截取的日志的正则表达式。
  static final consolePrint = RegExp(r'#1[\S\s]*#2');

  /// 识别注释的正则表达式。
  static final annotation = RegExp(r'<--([\S\s]*?)-->');

  /// 识别 (abc??123) 的正则表达式。
  static final bracketDoubtBracket = RegExp(r'\(([\S\s]*?)\?\?([\S\s]*?)\)');

  /// 识别 ??123) 的正则表达式。
  static final doubtBracket = RegExp(r'\?\?([\S\s]*?)\)');

  /// 识别 ?? 的正则表达式。
  static final doubt = RegExp(r'\?\?');

  /// 识别 [NType] 名称的正则表达式。
  static final nTypeNames = RegExp('(${NType.values.map((e) => e.name.split('.').last).join('|')})');

  /// 识别 _times1 后缀的正则表达式。
  static RegExp get nSuffix => RegExp('(_$nTypeNames([0-9]+))\$');

  /// 识别 abc 或 abc_times1 的正则表达式。
  static RegExp get ivcOrNSuffix => RegExp(InternalVariableConstant.getAllNames.map((e) => "(($e)(_$nTypeNames([0-9]+))?)").join('|'));

  /// 识别 else: 的正则表达式。
  static final elseKeyword = RegExp('else:');

  /// 识别全部运算符的正则表达式。（有个别不包含在内）
  static final allOperator = RegExp(allOperatorRegExp.map((e) => '($e)').join('|'));

  /// 识别全部关系运算符的正则表达式。
  static final relationalOperator = RegExp(oRelationalOperatorRegExp.map((e) => '($e)').join('|'));

  /// 识别全部逻辑运算符的正则表达式。
  static final logicalOperator = RegExp(oLogicalOperatorRegExp.map((e) => '($e)').join('|'));

  /// 识别 () 的正则表达式。
  static final bracket = RegExp(r'\(|\)');
}
