part of algorithm_parser;

/// 自定义变量命名规范检查。
String checkNameConvent({required String name}) {
  final nameTrim = name.trim();
  if (nameTrim == '') {
    throw '自定义变量名称不能为空字符！';
  }
  if (nameTrim.contains(RegExp(r'\s'))) {
    throw '自定义变量名称不能包含空白字符：$nameTrim\n空白字符：空格(全/半角)、制表符、换页符等';
  }
  if (name.contains(RegExp(r'[^A-Za-z0-9_]'))) {
    throw '自定义变量名称必须由字母、数字或下划线组成：$nameTrim';
  }

  if (keywords.contains(nameTrim)) {
    throw '自定义变量名称不能与关键字名称相同：$nameTrim\n关键字：${keywords.join(',')}';
  }
  final constAllNames = InternalVariableConstant.getAllNames;
  if (constAllNames.contains(nameTrim)) {
    throw '自定义变量名称不能与内置变量名称相同：$nameTrim\n内置变量：${constAllNames.join(',')}';
  }
  if (RegExper.ivcOrNSuffix.hasMatch(name)) {
    throw '自定义变量名称不能与内置变量名称的扩展名相同：$nameTrim\n'
        '内置变量：${constAllNames.join(',')}\n'
        '扩展类型：${NType.values.map((e) => e.name.split('.').last).join(',')}';
  }
  return nameTrim;
}
