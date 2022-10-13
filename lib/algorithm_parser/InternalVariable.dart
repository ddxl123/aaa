part of algorithm_parser;

class InternalVariabler {
  InternalVariabler._();

  static const InternalVariableConst ivgCountAllConst = InternalVariableConst(
    name: '\$count_all',
    explain: '记忆组启动的时间点。',
    numericTypeExplain: '距离记忆组开始的时间间隔秒数(s)。',
    usableSuffixTypes: {},
    usableStateTypes: {ButtonDataState, FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.global,
  );
  static const InternalVariableConst ivsCountNewConst = InternalVariableConst(
    name: '\$count_new',
    explain: '本次展示前，当前记忆组剩余的新碎片数量。',
    numericTypeExplain: '自然数：0，1，2，3...',
    usableSuffixTypes: {},
    usableStateTypes: {ButtonDataState, FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );
  static const InternalVariableConst ivsTimesConst = InternalVariableConst(
    name: '\$times',
    explain: '本次是当前碎片的第几次展示。',
    numericTypeExplain: '正整数（1，2，3...）。',
    usableSuffixTypes: {},
    usableStateTypes: {ButtonDataState, FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );
  static const InternalVariableConst ivsActualShowTimeConst = InternalVariableConst(
    name: '\$actual_show_time',
    explain: '本次实际展示的时间点。',
    numericTypeExplain: '距离记忆组开始的时间间隔秒数(s)。',
    usableSuffixTypes: {NType.times, NType.last},
    usableStateTypes: {ButtonDataState, FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );
  static const InternalVariableConst ivsPlanedShowTimeConst = InternalVariableConst(
    name: '\$planed_show_time',
    explain: '本次原本计划展示的时间点。',
    numericTypeExplain: '距离记忆组开始的时间间隔秒数(s)。',
    usableSuffixTypes: {NType.times, NType.last},
    usableStateTypes: {ButtonDataState, FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );

  static const InternalVariableConst ivsShowFamiliarConst = InternalVariableConst(
    name: '\$show_familiar',
    explain: '本次展示时的熟悉度。会根据熟悉度算法对值进行计算并获取。',
    numericTypeExplain: '任意数。',
    usableSuffixTypes: {NType.times, NType.last},
    usableStateTypes: {ButtonDataState, FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );
  static const InternalVariableConst ivcClickTimeConst = InternalVariableConst(
    name: '\$click_time',
    explain: '本次点击按钮时的时间点。',
    numericTypeExplain: '距离记忆组开始的时间间隔秒数(s)。',
    usableSuffixTypes: {NType.times, NType.last},
    usableStateTypes: {FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenClick,
  );
  static const InternalVariableConst ivcClickValueConst = InternalVariableConst(
    name: '\$click_value',
    explain: '本次点击按钮的按钮数值。',
    numericTypeExplain: '任意数。',
    usableSuffixTypes: {NType.times, NType.last},
    usableStateTypes: {FamiliarityState, NextTimeState},
    whenAvailable: WhenAvailable.whenClick,
  );

  static Map<String, InternalVariableConst> getAllKV = {
    ivgCountAllConst.name: ivgCountAllConst,
    ivsCountNewConst.name: ivsCountNewConst,
    ivsTimesConst.name: ivsTimesConst,
    ivsActualShowTimeConst.name: ivsActualShowTimeConst,
    ivsPlanedShowTimeConst.name: ivsPlanedShowTimeConst,
    ivsShowFamiliarConst.name: ivsShowFamiliarConst,
    ivcClickTimeConst.name: ivcClickTimeConst,
    ivcClickValueConst.name: ivcClickValueConst,
  };

  static Set<String> get getAllNames => getAllKV.keys.toSet();

  static Set<InternalVariableConst> get getAllConst => getAllKV.values.toSet();

  static Map<String, InternalVariableConst> getAllTarget({required Type algorithmContentType}) {
    final targetAll = <String, InternalVariableConst>{};
    getAllKV.forEach((k, v) {
      if (v.usableStateTypes.contains(algorithmContentType)) {
        targetAll.addAll({k: v});
      }
    });
    return targetAll;
  }

  static Set<String> getAllTargetNames({required Type algorithmContentType}) {
    final targetAll = <String>{};
    getAllKV.forEach((k, v) {
      if (v.usableStateTypes.contains(algorithmContentType)) {
        targetAll.add(k);
      }
    });
    return targetAll;
  }

  static InternalVariableConst getConstByName(String name) => getAllKV[name]!;
}

/// ivg 开头为 全局（xxx_n），
/// ivs 开头为 当展示时。
/// ivc 开头为 当点击按钮时。
class InternalVariableConst {
  const InternalVariableConst({
    required this.name,
    required this.explain,
    required this.usableStateTypes,
    required this.usableSuffixTypes,
    required this.whenAvailable,
    required this.numericTypeExplain,
  });

  /// 变量名
  final String name;

  /// 内容类型
  ///
  /// [ClassificationState] 子类的类型。
  final Set<Type> usableStateTypes;

  /// 可使用后缀类型
  final Set<NType> usableSuffixTypes;

  /// 获取时机
  final WhenAvailable whenAvailable;

  /// 变量解释
  final String explain;

  /// 数值类型解释
  final String numericTypeExplain;
}

class NTypeNumber {
  final NType nType;
  final int number;

  NTypeNumber({required this.nType, required this.number});

  String get getCombineString => '_${nType.name}$number';
}

class IvFilter<T extends num?> {
  /// [T] 为返回的数值类型。
  final Future<T> Function() ivf;
  final bool isCover;

  IvFilter({required this.ivf, required this.isCover});
}

/// 无论识别到的变量是否已识别过，都会生成一个新的 [InternalVariableAtom] 实例。
class InternalVariableAtom {
  InternalVariableAtom({
    required this.internalVariableConst,
    required this.nTypeNumber,
  });

  final InternalVariableConst internalVariableConst;
  final NTypeNumber? nTypeNumber;
  num? result;

  String get getCombineName => internalVariableConst.name + (nTypeNumber == null ? '' : nTypeNumber!.getCombineString);

  String get throwMessage => '未处理变量: $getCombineName';

  Future<num?> save({required InternalVariableStorage storage, required IvFilter<num?> ivFilter}) async {
    for (var element in storage.storage) {
      if (element.getCombineName == getCombineName) {
        if (element.result == null || ivFilter.isCover) {
          return element.result = await ivFilter.ivf();
        }
      }
    }
    result = await ivFilter.ivf();
    storage.storage.add(this);
    return result;
  }

  Future<num?> filter({
    required InternalVariableStorage storage,
    required IvFilter<int?> countAllIF,
    required IvFilter<int?> countNewIF,
    required IvFilter<int?> timesIF,
    required IvFilter<int?> actualShowTimeIF,
    required IvFilter<int?> planedShowTimeIF,
    required IvFilter<double?> showFamiliarIF,
    required IvFilter<int?> clickTimeIF,
    required IvFilter<double?> clickValueIF,
  }) async {
    if (internalVariableConst == InternalVariabler.ivgCountAllConst) {
      return await save(storage: storage, ivFilter: countAllIF);
    }
    if (internalVariableConst == InternalVariabler.ivgCountAllConst) {
      return await save(storage: storage, ivFilter: countNewIF);
    }
    if (internalVariableConst == InternalVariabler.ivgCountAllConst) {
      return await save(storage: storage, ivFilter: timesIF);
    }
    if (internalVariableConst == InternalVariabler.ivgCountAllConst) {
      return await save(storage: storage, ivFilter: actualShowTimeIF);
    }
    if (internalVariableConst == InternalVariabler.ivgCountAllConst) {
      return await save(storage: storage, ivFilter: planedShowTimeIF);
    }
    if (internalVariableConst == InternalVariabler.ivgCountAllConst) {
      return await save(storage: storage, ivFilter: showFamiliarIF);
    }
    if (internalVariableConst == InternalVariabler.ivgCountAllConst) {
      return await save(storage: storage, ivFilter: clickTimeIF);
    }
    if (internalVariableConst == InternalVariabler.ivgCountAllConst) {
      return await save(storage: storage, ivFilter: clickValueIF);
    }
    throw throwMessage;
  }
}

class InternalVariableStorage {
  /// 存储时，会检测 [InternalVariableAtom.getCombineName] 是否相同，
  /// 若相同，则复用。若不同，则新增。
  final List<InternalVariableAtom> storage = [];
}
