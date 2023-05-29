part of algorithm_parser;

/// [R] 获取到的数据类型，例如 数组类型、int类型、double类型...
class InternalVariableConstant<R> {
  const InternalVariableConstant({
    required this.name,
    required this.explain,
    required this.isReadFromMemoryInfo,
    required this.isNullable,
    required this.numericTypeExplain,
    required this.rawStringToDartTypeFunc,
  });

  /// 变量名
  final String name;

  /// 变量解释
  final String explain;

  /// 数值类型解释
  final String numericTypeExplain;

  /// 是否是从碎片记忆信息中读取
  ///
  /// 若为 true，则可带后缀 _n
  ///
  /// 若为 true，则 [isNullable] 必然为 true
  final bool isReadFromMemoryInfo;

  /// 是否可为空
  final bool isNullable;

  final R Function(String rawStringResult) rawStringToDartTypeFunc;
}

class InternalVariableConstantHandler {
  InternalVariableConstantHandler._();

  static InternalVariableConstant k1FCountAllConst = InternalVariableConstant<int>(
    name: 'f_count_all',
    explain: '当前记忆组全部碎片的数量',
    numericTypeExplain: '单位：个\n例如：1,2,3...',
    isReadFromMemoryInfo: false,
    isNullable: false,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return int.parse(rawStringResult);
    },
  );

  static InternalVariableConstant k2FCountNeverConst = InternalVariableConstant<int>(
    name: 'f_count_never',
    explain: '从本次碎片展示前进行计算，当前记忆组中未学习过的碎片的数量',
    numericTypeExplain: '单位：个\n例子：0,1,2,3...',
    isReadFromMemoryInfo: false,
    isNullable: false,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return int.parse(rawStringResult);
    },
  );
  static InternalVariableConstant k2FCountReviewConst = InternalVariableConstant<int>(
    name: 'f_count_review',
    explain: '从本次碎片展示前进行计算，当前记忆组中学习过但还需要再复习的碎片的数量',
    numericTypeExplain: '单位：个\n例子：0,1,2,3...',
    isReadFromMemoryInfo: false,
    isNullable: false,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return int.parse(rawStringResult);
    },
  );

  static InternalVariableConstant k2FCountCompleteConst = InternalVariableConstant<int>(
    name: 'f_count_complete',
    explain: '从本次碎片展示前进行计算，当前记忆组中已学习完成的碎片的数量',
    numericTypeExplain: '单位：个\n例子：0,1,2,3...',
    isReadFromMemoryInfo: false,
    isNullable: false,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return int.parse(rawStringResult);
    },
  );
  static InternalVariableConstant k2FCountStopConst = InternalVariableConstant<int>(
    name: 'f_count_stop',
    explain: '从本次碎片展示前进行计算，当前记忆组中被标记为暂停学习的碎片的数量',
    numericTypeExplain: '单位：个\n例子：0,1,2,3...',
    isReadFromMemoryInfo: false,
    isNullable: false,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return int.parse(rawStringResult);
    },
  );

  static InternalVariableConstant k3StudiedTimesConst = InternalVariableConstant<int>(
    name: 'studied_times',
    explain: '从本次碎片展示前进行计算，该碎片已被学习过多少次',
    numericTypeExplain: '单位：次\n例子：1,2,3...',
    isReadFromMemoryInfo: false,
    isNullable: false,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return int.parse(rawStringResult);
    },
  );

  static InternalVariableConstant k4CurrentShowTimeConst = InternalVariableConstant<int>(
    name: 'current_show_time',
    explain: '本次展示时的时间点',
    numericTypeExplain: '距离记忆组启动时的时间间隔秒数',
    isReadFromMemoryInfo: false,
    isNullable: false,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return int.parse(rawStringResult);
    },
  );

  static InternalVariableConstant k5CurrentShowFamiliarityConst = InternalVariableConstant<double>(
    name: 'current_show_familiarity',
    explain: '本次展示时间点对应的熟悉度',
    numericTypeExplain: '无单位',
    isReadFromMemoryInfo: false,
    isNullable: true,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return double.parse(rawStringResult);
    },
  );

  static InternalVariableConstant k6CurrentButtonValuesConst = InternalVariableConstant<List<double>>(
    name: 'current_button_values',
    explain: '本次展示所分配的全部按钮数据',
    numericTypeExplain: '数组类型，例如：[1,2,3]',
    isReadFromMemoryInfo: false,
    isNullable: true,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return jsonDecode(rawStringResult);
    },
  );

  static InternalVariableConstant k6CurrentButtonValueConst = InternalVariableConstant<double>(
    name: 'current_button_value',
    explain: '本次展示时所点击的按钮数值',
    numericTypeExplain: '数组类型，例如：1',
    isReadFromMemoryInfo: false,
    isNullable: true,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return jsonDecode(rawStringResult);
    },
  );

  static InternalVariableConstant k7CurrentClickTimeConst = InternalVariableConstant<int>(
    name: 'current_click_time',
    explain: '本次展示时所点击按钮的时间',
    numericTypeExplain: '距离记忆组启动时的时间间隔秒数',
    isReadFromMemoryInfo: false,
    isNullable: true,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return jsonDecode(rawStringResult);
    },
  );

  /// ==================================== 下面是从碎片记忆信息中获取 ===========================================

  /// [FragmentMemoryInfos.actual_show_time]
  static InternalVariableConstant i1ActualShowTimeConst = InternalVariableConstant<List<int>>(
    name: 'actual_show_time',
    explain: '实际展示的时间点。',
    numericTypeExplain: '距离记忆组启动时的时间间隔秒数',
    isReadFromMemoryInfo: true,
    isNullable: true,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return jsonDecode(rawStringResult);
    },
  );

  /// [FragmentMemoryInfos.next_plan_show_time]
  static InternalVariableConstant i2NextPlanShowTimeConst = InternalVariableConstant<List<int>>(
    name: 'next_plan_show_time',
    explain: '下次计划展示的时间点。',
    numericTypeExplain: '距离记忆组启动时的时间间隔秒数',
    isReadFromMemoryInfo: true,
    isNullable: true,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return jsonDecode(rawStringResult);
    },
  );

  /// [FragmentMemoryInfos.show_familiarity]
  static InternalVariableConstant i3ShowFamiliarityConst = InternalVariableConstant<List<double>>(
    name: 'show_familiarity',
    explain: '展示时时间点的熟练度',
    numericTypeExplain: '无单位',
    isReadFromMemoryInfo: true,
    isNullable: true,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return jsonDecode(rawStringResult);
    },
  );

  /// [FragmentMemoryInfos.click_familiarity]
  static InternalVariableConstant i4ClickFamiliarityConst = InternalVariableConstant<List<double>>(
    name: 'click_familiarity',
    explain: '点击时时间点的熟练度',
    numericTypeExplain: '无单位',
    isReadFromMemoryInfo: true,
    isNullable: true,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return jsonDecode(rawStringResult);
    },
  );

  /// [FragmentMemoryInfos.click_time]
  static InternalVariableConstant i5ClickTimeConst = InternalVariableConstant<List<int>>(
    name: 'click_time',
    explain: '点击按钮时的时间点',
    numericTypeExplain: '距离记忆组启动时的时间间隔秒数',
    isReadFromMemoryInfo: true,
    isNullable: true,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return jsonDecode(rawStringResult);
    },
  );

  /// [FragmentMemoryInfos.click_value]
  static InternalVariableConstant i6ClickValueConst = InternalVariableConstant<List<double>>(
    name: 'click_value',
    explain: '点击按钮时的按钮数值',
    numericTypeExplain: '无单位',
    isReadFromMemoryInfo: true,
    isNullable: true,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return jsonDecode(rawStringResult);
    },
  );

  /// [FragmentMemoryInfos.button_values]
  static InternalVariableConstant i7ButtonValuesConst = InternalVariableConstant<List<List<double>>>(
    name: 'button_values',
    explain: '按钮分配数据',
    numericTypeExplain: '数组类型，例如：[1,2,3]',
    isReadFromMemoryInfo: true,
    isNullable: true,
    rawStringToDartTypeFunc: (String rawStringResult) {
      return jsonDecode(rawStringResult);
    },
  );

  /// TODO: 受 [NType.ntimes] 影响，必须把 [k3StudiedTimesConst] 放到最后，若放到前面，正则表达式会先识别 times。
  static Map<String, InternalVariableConstant> getKVs = {
    InternalVariableConstantHandler.i1ActualShowTimeConst.name: InternalVariableConstantHandler.i1ActualShowTimeConst,
    InternalVariableConstantHandler.i2NextPlanShowTimeConst.name: InternalVariableConstantHandler.i2NextPlanShowTimeConst,
    InternalVariableConstantHandler.i3ShowFamiliarityConst.name: InternalVariableConstantHandler.i3ShowFamiliarityConst,
    InternalVariableConstantHandler.i4ClickFamiliarityConst.name: InternalVariableConstantHandler.i4ClickFamiliarityConst,
    InternalVariableConstantHandler.i5ClickTimeConst.name: InternalVariableConstantHandler.i5ClickTimeConst,
    InternalVariableConstantHandler.i6ClickValueConst.name: InternalVariableConstantHandler.i6ClickValueConst,
    InternalVariableConstantHandler.i7ButtonValuesConst.name: InternalVariableConstantHandler.i7ButtonValuesConst,
    InternalVariableConstantHandler.k1FCountAllConst.name: InternalVariableConstantHandler.k1FCountAllConst,
    InternalVariableConstantHandler.k2FCountNeverConst.name: InternalVariableConstantHandler.k2FCountNeverConst,
    InternalVariableConstantHandler.k2FCountReviewConst.name: InternalVariableConstantHandler.k2FCountReviewConst,
    InternalVariableConstantHandler.k2FCountCompleteConst.name: InternalVariableConstantHandler.k2FCountCompleteConst,
    InternalVariableConstantHandler.k2FCountStopConst.name: InternalVariableConstantHandler.k2FCountStopConst,
    InternalVariableConstantHandler.k3StudiedTimesConst.name: InternalVariableConstantHandler.k3StudiedTimesConst,
    InternalVariableConstantHandler.k4CurrentShowTimeConst.name: InternalVariableConstantHandler.k4CurrentShowTimeConst,
    InternalVariableConstantHandler.k5CurrentShowFamiliarityConst.name: InternalVariableConstantHandler.k5CurrentShowFamiliarityConst,
    InternalVariableConstantHandler.k6CurrentButtonValuesConst.name: InternalVariableConstantHandler.k6CurrentButtonValuesConst,
    InternalVariableConstantHandler.k6CurrentButtonValueConst.name: InternalVariableConstantHandler.k6CurrentButtonValueConst,
    InternalVariableConstantHandler.k7CurrentClickTimeConst.name: InternalVariableConstantHandler.k7CurrentClickTimeConst,
  };

  static Set<String> get getNames => getKVs.keys.toSet();

  static Set<InternalVariableConstant> get getConsts => getKVs.values.toSet();

  static InternalVariableConstant getConstByName(String name) => getKVs[name]!;
}
