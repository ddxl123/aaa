part of algorithm_parser;

/// TODO: 未应用
enum SimulationType {
  /// 语法校验
  syntaxCheck,

  /// 外部处理
  external,
}

enum WhenAvailable {
  /// 是否全局（同时也是 是否为xxx_n 的标志）。
  global,

  /// 在刚展示时获取。
  whenShow,

  /// 在点击按钮后获取。
  whenClick,
}

enum NType {
  /// 第 n 次
  times,

  /// 上 n 次
  last,
}

/// [NType.times] 转 'times'
List<String> nTypeEnum2Names() => NType.values.map((e) => e.name.split('.').last).toList();
