part of algorithm_parser;

enum SelfExistStatus {
  /// 可空
  nullable,

  /// 一定不可空。
  notEmpty,

  /// 一定为空。
  empty,
}

class UsableState {
  /// 内容类型
  ///
  /// [ClassificationState] 子类的类型。
  final Type usableStateType;

  /// 自身存在状态。
  final SelfExistStatus selfExistStatus;

  /// 可使用后缀类型
  final Set<NType> usableSuffixNTypes;

  const UsableState({required this.usableStateType, required this.selfExistStatus, required this.usableSuffixNTypes});
}

/// ivg 开头为 全局（xxx_n），
/// ivs 开头为 当展示时。
/// ivc 开头为 当点击按钮时。
class InternalVariableConst {
  const InternalVariableConst({
    required this.name,
    required this.explain,
    required this.usableStates,
    required this.whenAvailable,
    required this.numericTypeExplain,
  });

  /// 变量名
  final String name;

  /// 获取时机
  final WhenAvailable whenAvailable;

  /// 变量解释
  final String explain;

  /// 数值类型解释
  final String numericTypeExplain;

  final Set<UsableState> usableStates;
}

class InternalVariableConstant {
  InternalVariableConstant._();

  static const InternalVariableConst countAllConst = InternalVariableConst(
    name: 'count_all',
    explain: '记忆组启动的时间点。',
    numericTypeExplain: '距离记忆组开始的时间间隔秒数(s)。',
    whenAvailable: WhenAvailable.global,
    usableStates: {
      UsableState(usableStateType: FamiliarityState, usableSuffixNTypes: {}, selfExistStatus: SelfExistStatus.notEmpty),
      UsableState(usableStateType: ButtonDataState, usableSuffixNTypes: {}, selfExistStatus: SelfExistStatus.notEmpty),
      UsableState(usableStateType: NextShowTimeState, usableSuffixNTypes: {}, selfExistStatus: SelfExistStatus.notEmpty),
    },
  );
  static const InternalVariableConst countNewConst = InternalVariableConst(
    name: 'count_new',
    explain: '本次展示前，当前记忆组剩余的新碎片数量。',
    numericTypeExplain: '自然数：0，1，2，3...',
    whenAvailable: WhenAvailable.whenShow,
    usableStates: {
      UsableState(usableStateType: FamiliarityState, usableSuffixNTypes: {}, selfExistStatus: SelfExistStatus.notEmpty),
      UsableState(usableStateType: ButtonDataState, usableSuffixNTypes: {}, selfExistStatus: SelfExistStatus.notEmpty),
      UsableState(usableStateType: NextShowTimeState, usableSuffixNTypes: {}, selfExistStatus: SelfExistStatus.notEmpty),
    },
  );
  static const InternalVariableConst timesConst = InternalVariableConst(
    name: 'times',
    explain: '本次是当前碎片的第几次展示。',
    numericTypeExplain: '正整数（1，2，3...）。',
    whenAvailable: WhenAvailable.whenShow,
    usableStates: {
      UsableState(usableStateType: FamiliarityState, usableSuffixNTypes: {}, selfExistStatus: SelfExistStatus.notEmpty),
      UsableState(usableStateType: ButtonDataState, usableSuffixNTypes: {}, selfExistStatus: SelfExistStatus.notEmpty),
      UsableState(usableStateType: NextShowTimeState, usableSuffixNTypes: {}, selfExistStatus: SelfExistStatus.notEmpty),
    },
  );
  static const InternalVariableConst currentActualShowTimeConst = InternalVariableConst(
    name: 'current_actual_show_time',
    explain: '本次实际展示的时间点。',
    numericTypeExplain: '距离记忆组开始的时间间隔秒数(s)。',
    whenAvailable: WhenAvailable.whenShow,
    usableStates: {
      UsableState(usableStateType: FamiliarityState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.notEmpty),
      UsableState(usableStateType: ButtonDataState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.notEmpty),
      UsableState(usableStateType: NextShowTimeState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.notEmpty),
    },
  );
  static const InternalVariableConst nextPlanedShowTimeConst = InternalVariableConst(
    name: 'next_planed_show_time',
    explain: '本次计划下次展示的时间点。',
    numericTypeExplain: '距离记忆组开始的时间间隔秒数(s)。',
    whenAvailable: WhenAvailable.whenShow,
    usableStates: {
      UsableState(usableStateType: FamiliarityState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.empty),
      UsableState(usableStateType: ButtonDataState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.empty),
      UsableState(usableStateType: NextShowTimeState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.empty),
    },
  );

  static const InternalVariableConst showFamiliarConst = InternalVariableConst(
    name: 'show_familiar',
    explain: '本次展示时的熟悉度。会根据熟悉度算法对值进行计算并获取。',
    numericTypeExplain: '任意数。',
    whenAvailable: WhenAvailable.whenShow,
    usableStates: {
      UsableState(usableStateType: FamiliarityState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.empty),
      UsableState(usableStateType: ButtonDataState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.notEmpty),
      UsableState(usableStateType: NextShowTimeState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.notEmpty),
    },
  );
  static const InternalVariableConst clickTimeConst = InternalVariableConst(
    name: 'click_time',
    explain: '本次点击按钮时的时间点。',
    numericTypeExplain: '距离记忆组开始的时间间隔秒数(s)。',
    whenAvailable: WhenAvailable.whenClick,
    usableStates: {
      UsableState(usableStateType: FamiliarityState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.empty),
      UsableState(usableStateType: ButtonDataState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.empty),
      UsableState(usableStateType: NextShowTimeState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.notEmpty),
    },
  );
  static const InternalVariableConst clickValueConst = InternalVariableConst(
    name: 'click_value',
    explain: '本次点击按钮的按钮数值。',
    numericTypeExplain: '任意数。',
    whenAvailable: WhenAvailable.whenClick,
    usableStates: {
      UsableState(usableStateType: FamiliarityState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.empty),
      UsableState(usableStateType: ButtonDataState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.empty),
      UsableState(usableStateType: NextShowTimeState, usableSuffixNTypes: {NType.times, NType.last}, selfExistStatus: SelfExistStatus.notEmpty),
    },
  );

  /// 受 [NType.times] 影响，必须把 [timesConst] 放到最后，若放到前面，正则表达式会先识别 times。
  static Map<String, InternalVariableConst> getAllKV = {
    countAllConst.name: countAllConst,
    countNewConst.name: countNewConst,
    timesConst.name: timesConst,
    currentActualShowTimeConst.name: currentActualShowTimeConst,
    nextPlanedShowTimeConst.name: nextPlanedShowTimeConst,
    showFamiliarConst.name: showFamiliarConst,
    clickTimeConst.name: clickTimeConst,
    clickValueConst.name: clickValueConst,
  };

  static Set<String> get getAllNames => getAllKV.keys.toSet();

  static Set<InternalVariableConst> get getAllConst => getAllKV.values.toSet();

  static Map<String, InternalVariableConst> getAllTarget({required Type algorithmContentType}) {
    final targetAll = <String, InternalVariableConst>{};
    getAllKV.forEach((k, v) {
      if (v.usableStates.map((e) => e.usableStateType).contains(algorithmContentType)) {
        targetAll.addAll({k: v});
      }
    });
    return targetAll;
  }

  static Set<String> getAllTargetNames({required Type algorithmContentType}) {
    final targetAll = <String>{};
    getAllKV.forEach((k, v) {
      if (v.usableStates.map((e) => e.usableStateType).contains(algorithmContentType)) {
        targetAll.add(k);
      }
    });
    return targetAll;
  }

  static InternalVariableConst getConstByName(String name) => getAllKV[name]!;
}