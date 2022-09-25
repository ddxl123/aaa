part of algorithm_parser;

/// ivg 开头为 全局（xxx_n），
/// ivs 开头为 当展示时。
/// ivc 开头为 当点击按钮时。
class InternalVariable {
  const InternalVariable({
    required this.name,
    required this.explain,
    required this.numericTypeExplain,
  });

  /// 变量名
  final String name;

  /// 变量解释
  final String explain;

  /// 数值类型解释
  final String numericTypeExplain;

  static InternalVariable ivgStartTime = const InternalVariable(
    name: '\$start_time',
    explain: '记忆组启动的时间点。',
    numericTypeExplain: '以秒(s)为单位的时间戳。',
  );

  static InternalVariable ivgCountAll = const InternalVariable(
    name: '\$count_all',
    explain: '记忆组启动的时间点。',
    numericTypeExplain: '以秒(s)为单位的时间戳。',
  );
  static InternalVariable ivsCountNew = const InternalVariable(
    name: '\$count_new',
    explain: '本次展示前，当前记忆组剩余的新碎片数量。',
    numericTypeExplain: '自然数。',
  );
  static InternalVariable ivsTimes = const InternalVariable(
    name: '\$times',
    explain: '本次是第几次展示。',
    numericTypeExplain: '正整数（1，2，3...）。',
  );
  static InternalVariable ivsActualShowTime = const InternalVariable(
    name: '\$actual_show_time',
    explain: '本次实际展示的时间点。',
    numericTypeExplain: '以秒为单位的时间戳。',
  );
  static InternalVariable ivsPlanedShowTime = const InternalVariable(
    name: '\$planed_show_time',
    explain: '本次原本计划展示的时间点。',
    numericTypeExplain: '以秒为单位的时间戳。',
  );

  static InternalVariable ivsClickFamiliar = const InternalVariable(
    name: '\$click_familiar',
    explain: '本次刚展示时的熟悉度。默认为0，用户可能会手动分配初始值。',
    numericTypeExplain: '任意实数。',
  );
  static InternalVariable ivcClickTime = const InternalVariable(
    name: '\$click_time',
    explain: '本次点击按钮时的时间点。',
    numericTypeExplain: '以秒为单位的时间戳。',
  );
  static InternalVariable ivcClickValue = const InternalVariable(
    name: '\$click_value',
    explain: '本次点击按钮的按钮数值。',
    numericTypeExplain: '任意实数。',
  );

  static Map<String, InternalVariable> all = {
    ivgStartTime.name: ivgStartTime,
    ivgCountAll.name: ivgCountAll,
    ivsCountNew.name: ivsCountNew,
    ivsTimes.name: ivsTimes,
    ivsActualShowTime.name: ivsActualShowTime,
    ivsPlanedShowTime.name: ivsPlanedShowTime,
    ivsClickFamiliar.name: ivsClickFamiliar,
    ivcClickTime.name: ivcClickTime,
    ivcClickValue.name: ivcClickValue,
  };

  static List<String> get allName => all.keys.toList();

  static List<InternalVariable> get allIv => all.values.toList();

  static InternalVariable getIvByName(String name) {
    return all[name]!;
  }
}
