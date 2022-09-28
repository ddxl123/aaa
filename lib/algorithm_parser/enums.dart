part of algorithm_parser;

/// TODO: 未应用
enum SimulationType {
  /// 语法校验
  syntaxCheck,

  /// 分析出全部可能性，确保算法可用。
  autoSimulation,

  /// 按照实际操作进行模拟。（模拟前必须自动分析）
  manualSimulation,
}

enum WhenAvailable {
  /// 是否全局（同时也是 是否为xxx_n 的标志）。
  global,

  /// 在刚展示时获取。
  whenShow,

  /// 在点击按钮后获取。
  whenClick,
}
