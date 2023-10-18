part of algorithm_parser;

/// TODO: 未应用
enum SimulationType {
  /// 语法校验
  syntaxCheck,

  /// 外部处理
  external,

  /// 发送异常
  exception,
}

enum NType {
  /// 第 n 次
  ntimes,

  /// 上 n 次
  nlast,
}
