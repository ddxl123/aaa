part of algorithm_parser;

/// 自定义变量命名规范检查。
String checkCustomVariableNameConvention({required String name}) {
  final nameTrim = name.trim();
  if (nameTrim == '') {
    throw KnownAlgorithmException('自定义变量名称不能为空字符！');
  }
  if (nameTrim.contains(RegExper.blank)) {
    throw KnownAlgorithmException('自定义变量名称不能包含空白字符：$nameTrim\n空白字符：空格(全/半角)、制表符、换页符等');
  }
  if (name.contains(RegExper.nameNonConvention)) {
    throw KnownAlgorithmException('自定义变量名称必须由字母、数字或下划线组成：$nameTrim');
  }

  if (keywords.contains(nameTrim)) {
    throw KnownAlgorithmException('自定义变量名称不能与关键字名称相同：$nameTrim\n关键字：${keywords.join(',')}');
  }
  final constAllNames = InternalVariableConstantHandler.getNames;
  if (constAllNames.contains(nameTrim)) {
    throw KnownAlgorithmException('自定义变量名称不能与内置变量名称相同：$nameTrim\n内置变量：${constAllNames.join(',')}');
  }
  if (RegExper.fullName.hasMatch(name)) {
    throw KnownAlgorithmException('自定义变量名称不能与内置变量名称的扩展名相同：$nameTrim\n'
        '内置变量：${constAllNames.join(',')}\n'
        '扩展类型：${NType.values.map((e) => e.name.split('.').last).join(',')}');
  }
  return name;
}
