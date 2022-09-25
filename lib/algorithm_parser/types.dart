part of algorithm_parser;

/// [name] 表示去掉 _n 后的名称。
/// [number] 表示 n 的数值，若为空则该变量不是 xxx_n 类型。
typedef InternalVariablesResultHandler = Future<double?> Function(InternalVariable internalVariable, int? number);
