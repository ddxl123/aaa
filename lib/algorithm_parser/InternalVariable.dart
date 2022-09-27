part of algorithm_parser;

/// ivg 开头为 全局（xxx_n），
/// ivs 开头为 当展示时。
/// ivc 开头为 当点击按钮时。
class InternalVariable {
  const InternalVariable({
    required this.name,
    required this.explain,
    required this.numericTypeExplain,
    required this.usableStates,
    required this.whenAvailable,
  });

  /// 变量名
  final String name;

  /// 变量解释
  final String explain;

  /// 数值类型解释
  final String numericTypeExplain;

  /// 内容类型
  final Set<Type> usableStates;

  /// 获取时机
  final WhenAvailable whenAvailable;

  static const InternalVariable ivgStartTime = InternalVariable(
    name: '\$start_time',
    explain: '记忆组启动的时间点。',
    numericTypeExplain: '以秒(s)为单位的时间戳。',
    usableStates: {ButtonDataState, FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.global,
  );

  static const InternalVariable ivgCountAll = InternalVariable(
    name: '\$count_all',
    explain: '记忆组启动的时间点。',
    numericTypeExplain: '以秒(s)为单位的时间戳。',
    usableStates: {ButtonDataState, FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.global,
  );
  static const InternalVariable ivsCountNew = InternalVariable(
    name: '\$count_new',
    explain: '本次展示前，当前记忆组剩余的新碎片数量。',
    numericTypeExplain: '自然数。',
    usableStates: {ButtonDataState, FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );
  static const InternalVariable ivsTimes = InternalVariable(
    name: '\$times',
    explain: '本次是第几次展示。',
    numericTypeExplain: '正整数（1，2，3...）。',
    usableStates: {ButtonDataState, FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );
  static const InternalVariable ivsActualShowTime = InternalVariable(
    name: '\$actual_show_time',
    explain: '本次实际展示的时间点。',
    numericTypeExplain: '以秒为单位的时间戳。',
    usableStates: {ButtonDataState, FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );
  static const InternalVariable ivsPlanedShowTime = InternalVariable(
    name: '\$planed_show_time',
    explain: '本次原本计划展示的时间点。',
    numericTypeExplain: '以秒为单位的时间戳。',
    usableStates: {ButtonDataState, FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );

  static const InternalVariable ivsClickFamiliar = InternalVariable(
    name: '\$click_familiar',
    explain: '本次刚展示时的熟悉度。默认为0，用户可能会手动分配初始值。',
    numericTypeExplain: '任意实数。',
    usableStates: {ButtonDataState, FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );
  static const InternalVariable ivcClickTime = InternalVariable(
    name: '\$click_time',
    explain: '本次点击按钮时的时间点。',
    numericTypeExplain: '以秒为单位的时间戳。',
    usableStates: {FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenClick,
  );
  static const InternalVariable ivcClickValue = InternalVariable(
    name: '\$click_value',
    explain: '本次点击按钮的按钮数值。',
    numericTypeExplain: '任意实数。',
    usableStates: {FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenClick,
  );

  static Map<String, InternalVariable> getAll = {
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

  static Set<String> get getAllNames => getAll.keys.toSet();

  static Set<InternalVariable> get getAllIvs => getAll.values.toSet();

  static Map<String, InternalVariable> getAllTarget({required Type algorithmContentType}) {
    final targetAll = <String, InternalVariable>{};
    getAll.forEach((k, v) {
      if (v.usableStates.contains(algorithmContentType)) {
        targetAll.addAll({k: v});
      }
    });
    return targetAll;
  }

  static Set<String> getAllTargetNames({required Type algorithmContentType}) {
    final targetAll = <String>{};
    getAll.forEach((k, v) {
      if (v.usableStates.contains(algorithmContentType)) {
        targetAll.add(k);
      }
    });
    return targetAll;
  }

  static InternalVariable getIvByName(String name) => getAll[name]!;
}
