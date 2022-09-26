part of algorithm_parser;

/// TODO: 未应用
enum AlgorithmParseType {
  /// 分析出全部可能性，确保算法可用。
  analyze,

  /// 按照实际操作进行模拟。（模拟前必须自动分析）
  simulation,
}

enum WhenAvailable {
  /// 是否全局（同时也是 是否为xxx_n 的标志）。
  global,

  /// 在刚展示时获取。
  whenShow,

  /// 在点击按钮后获取。
  whenClick,
}

enum AlgorithmContentType {
  familiarity,
  nextTime,
  buttonData,
}
