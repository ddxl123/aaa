part of algorithm_parser;

/// 自定义变量命名规范检查。
// Set<String> checkNameConvent({required String name}) {
//   if (keywords.contains(name)) {
//     throw '自定义变量名称不能与关键字名称相同：$name\n关键字：${keywords.join(',')}';
//   }
//   final constAllNames = InternalVariableConstant.getAllNames;
//   if (constAllNames.contains(name)) {
//     throw '自定义变量名称不能与内置变量名称相同：$name\n内置变量：${constAllNames.join(',')}';
//   }
//   final nTypeNames = '(${NType.values.map((e) => e.name.split('.').last).join('|')})';
//   final vRegExp = RegExp(constAllNames.map((e) => "(($e)(_$nTypeNames([0-9]+))?)").join('|'));
//   // if (vRegExp)
// }

/// TODO: 哪些必须空合并，哪些无需空合并。
