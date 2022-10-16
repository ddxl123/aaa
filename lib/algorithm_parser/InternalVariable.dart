part of algorithm_parser;

class InternalVariabler {
  InternalVariabler._();

  static const InternalVariableConst ivgCountAllConst = InternalVariableConst(
    name: '\$count_all',
    explain: '记忆组启动的时间点。',
    numericTypeExplain: '距离记忆组开始的时间间隔秒数(s)。',
    usableSuffixTypes: {},
    usableStateTypes: {ButtonDataState, FamiliarityState, NextShowTimeState},
    whenAvailable: WhenAvailable.global,
  );
  static const InternalVariableConst ivsCountNewConst = InternalVariableConst(
    name: '\$count_new',
    explain: '本次展示前，当前记忆组剩余的新碎片数量。',
    numericTypeExplain: '自然数：0，1，2，3...',
    usableSuffixTypes: {},
    usableStateTypes: {ButtonDataState, FamiliarityState, NextShowTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );
  static const InternalVariableConst ivsTimesConst = InternalVariableConst(
    name: '\$times',
    explain: '本次是当前碎片的第几次展示。',
    numericTypeExplain: '正整数（1，2，3...）。',
    usableSuffixTypes: {},
    usableStateTypes: {ButtonDataState, FamiliarityState, NextShowTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );
  static const InternalVariableConst ivsCurrentActualShowTimeConst = InternalVariableConst(
    name: '\$current_actual_show_time',
    explain: '本次实际展示的时间点。',
    numericTypeExplain: '距离记忆组开始的时间间隔秒数(s)。',
    usableSuffixTypes: {NType.times, NType.last},
    usableStateTypes: {ButtonDataState, FamiliarityState, NextShowTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );
  static const InternalVariableConst ivsNextPlanedShowTimeConst = InternalVariableConst(
    name: '\$next_planed_show_time',
    explain: '本次原本计划展示的时间点。',
    numericTypeExplain: '距离记忆组开始的时间间隔秒数(s)。',
    usableSuffixTypes: {NType.times, NType.last},
    usableStateTypes: {ButtonDataState, FamiliarityState, NextShowTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );

  static const InternalVariableConst ivsShowFamiliarConst = InternalVariableConst(
    name: '\$show_familiar',
    explain: '本次展示时的熟悉度。会根据熟悉度算法对值进行计算并获取。',
    numericTypeExplain: '任意数。',
    usableSuffixTypes: {NType.times, NType.last},
    usableStateTypes: {ButtonDataState, FamiliarityState, NextShowTimeState},
    whenAvailable: WhenAvailable.whenShow,
  );
  static const InternalVariableConst ivcClickTimeConst = InternalVariableConst(
    name: '\$click_time',
    explain: '本次点击按钮时的时间点。',
    numericTypeExplain: '距离记忆组开始的时间间隔秒数(s)。',
    usableSuffixTypes: {NType.times, NType.last},
    usableStateTypes: {FamiliarityState, NextShowTimeState},
    whenAvailable: WhenAvailable.whenClick,
  );
  static const InternalVariableConst ivcClickValueConst = InternalVariableConst(
    name: '\$click_value',
    explain: '本次点击按钮的按钮数值。',
    numericTypeExplain: '任意数。',
    usableSuffixTypes: {NType.times, NType.last},
    usableStateTypes: {FamiliarityState, NextShowTimeState},
    whenAvailable: WhenAvailable.whenClick,
  );

  static Map<String, InternalVariableConst> getAllKV = {
    ivgCountAllConst.name: ivgCountAllConst,
    ivsCountNewConst.name: ivsCountNewConst,
    ivsTimesConst.name: ivsTimesConst,
    ivsCurrentActualShowTimeConst.name: ivsCurrentActualShowTimeConst,
    ivsNextPlanedShowTimeConst.name: ivsNextPlanedShowTimeConst,
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
  final Future<List<T>> Function() ivf;

  /// 是否要重新获取。
  final bool isReGet;

  IvFilter({required this.ivf, required this.isReGet});
}

/// 无论识别到的变量是否已识别过，都会生成一个新的 [InternalVariableAtom] 实例。
class InternalVariableAtom {
  InternalVariableAtom({
    required this.internalVariableConst,
    required this.nTypeNumber,
  });

  final InternalVariableConst internalVariableConst;
  final NTypeNumber? nTypeNumber;

  String get getCombineName => internalVariableConst.name + (nTypeNumber == null ? '' : nTypeNumber!.getCombineString);

  Future<num?> save({required InternalVariableStorage storage, required IvFilter<num?> ivFilter}) async {
    num? singleResult({required InternalVariableWithResults i}) {
      if (nTypeNumber == null) {
        return i.results.last;
      }
      if (nTypeNumber!.nType == NType.times) {
        return i.getResult(index: nTypeNumber!.number);
      }
      if (nTypeNumber!.nType == NType.last) {
        return i.getResult(index: i.results.length - 1 - nTypeNumber!.number);
      }
      throw '未处理类型：${nTypeNumber!.nType}';
    }

    for (var element in storage.storage) {
      if (element.internalVariableConst == internalVariableConst) {
        if (element.results.isEmpty || ivFilter.isReGet) {
          element.results.clear();
          final ivfResults = await ivFilter.ivf();
          element.results.addAll(ivfResults);
        }
        return singleResult(i: element);
      }
    }

    final newI = InternalVariableWithResults(internalVariableConst: internalVariableConst);
    storage.storage.add(newI);
    final ivfResults = await ivFilter.ivf();
    newI.results.addAll(ivfResults);
    return singleResult(i: newI);
  }

  Future<num?> filter({
    required InternalVariableStorage storage,
    required IvFilter<int?> countAllIF,
    required IvFilter<int?> countNewIF,
    required IvFilter<int?> timesIF,
    required IvFilter<int?> currentActualShowTimeIF,
    required IvFilter<int?> currentPlanedShowTimeIF,
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
      return await save(storage: storage, ivFilter: currentActualShowTimeIF);
    }
    if (internalVariableConst == InternalVariabler.ivgCountAllConst) {
      return await save(storage: storage, ivFilter: currentPlanedShowTimeIF);
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
    throw '未处理变量: $getCombineName';
  }
}

class InternalVariableWithResults {
  final InternalVariableConst internalVariableConst;

  /// 存储每次的结果，按照时间排序。
  /// 最后一个 index 始终是当前展示的结果。
  /// 若当前展示的结果无法获取，则必须默认赋值为 null，即 [results.length] 必然大于等于 1。
  final List<num?> results = [];

  InternalVariableWithResults({required this.internalVariableConst});

  num? getResult({required int index}) {
    if (results.isEmpty) {
      throw '结果集不能为空！';
    }
    if (results.length - 1 < index || index < 0) {
      return null;
    }
    return results[index];
  }
}

class InternalVariableStorage {
  final List<InternalVariableWithResults> storage = [];
}
