part of algorithm_parser;

class InternalVariable {
  /// 变量名
  final String name;

  /// 变量解释
  final String explain;

  /// 数值类型解释
  final String numericTypeExplain;

  /// 可获得的时间点类型
  final WhenAvailable whenGet;

  /// 是否全局（同样也是 是否为 xxx_n 的标志）
  final bool isOnce;

  InternalVariable({
    required this.name,
    required this.explain,
    required this.numericTypeExplain,
    required this.whenGet,
    required this.isOnce,
  });
}
