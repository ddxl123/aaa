part of algorithm_parser;

class NTypeNumber {
  final NType nType;
  final int suffixNumber;

  NTypeNumber({required this.nType, required this.suffixNumber});

  String get getCombineString => '_${nType.name}$suffixNumber';
}

class IvFilter<T extends num?> {
  /// [T] 为返回的数值类型。
  final Future<List<T>> Function() ivf;

  /// 是否要重新获取。
  final bool isReGet;

  IvFilter({required this.ivf, required this.isReGet});
}

/// 无论识别到的变量是否已识别过，都会生成一个新的 [InternalVariableAtom] 实例。
class InternalVariableAtom<CS extends ClassificationState> {
  InternalVariableAtom({
    required this.internalVariableConst,
    required this.currentState,
    required this.nTypeNumber,
    required this.hasNullMerge,
  });

  final InternalVariableConst internalVariableConst;
  final CS currentState;
  final NTypeNumber? nTypeNumber;

  /// 变量后面是否存在空合并符号。
  final bool hasNullMerge;

  String get getCombineName => internalVariableConst.name + (nTypeNumber == null ? '' : nTypeNumber!.getCombineString);

  /// 返回空表示当前 [internalVariableConst] 不能使用 [currentState]。
  UsableState? getCurrentUsableStateForCurrentState() {
    final manyUsable = internalVariableConst.usableStates.where((element) => element.usableStateType == currentState.getStateType);
    if (manyUsable.isEmpty) return null;
    if (manyUsable.length == 1) return manyUsable.single;
    throw '初始化配置异常：usable 里出现了两个相同实例！';
  }

  /// 排查错误。
  void handle() {
    final usableState = getCurrentUsableStateForCurrentState();
    if (usableState == null) {
      throw '该算法内容不能使用 $getCombineName 变量，因为获取到的结果值始终为空！';
    }

    if (nTypeNumber != null) {
      final isUsableSuffix = usableState.usableSuffixNTypes.contains(nTypeNumber!.nType);
      if (!isUsableSuffix) {
        throw '${internalVariableConst.name} 变量不支持 "_${nTypeNumber!.nType}n" 后缀！';
      }

      if (nTypeNumber!.suffixNumber <= 0) {
        throw '"_${nTypeNumber!.nType.name}n" 内的 "n" 值必须大于 0！';
      }

      if (!hasNullMerge) {
        throw '$getCombineName 扩展变量存在为空的可能性，请使用空合并运算符(??)来预防！';
      }
    }

    if (nTypeNumber == null) {
      if (usableState.selfExistStatus == SelfExistStatus.nullable && !hasNullMerge) {
        throw '$getCombineName 变量存在为空的可能性，请使用空合并运算符(??)来预防！';
      }
      if (usableState.selfExistStatus == SelfExistStatus.notEmpty && hasNullMerge) {
        throw '$getCombineName 变量必然不为空，请去掉空合并运算符(??)！';
      }
      if (usableState.selfExistStatus == SelfExistStatus.empty && !hasNullMerge) {
        throw '$getCombineName 变量在当前算法下必然为空，请使用空合并运算符(??)来预防，或者放弃使用该变量！';
      }
    }
  }

  Future<NumberOrNull> save({
    required InternalVariableStorage storage,
    required IvFilter<num?> ivFilter,
  }) async {
    if (getCurrentUsableStateForCurrentState()?.selfExistStatus == SelfExistStatus.empty) {
      return NumberOrNull(null);
    }
    // 获取需要的 index 对应的结果值。
    num? singleResult({required InternalVariableWithResults i}) {
      if (nTypeNumber == null) {
        return i.results.last;
      }
      if (nTypeNumber!.nType == NType.times) {
        return i.getResult(index: nTypeNumber!.suffixNumber);
      }
      if (nTypeNumber!.nType == NType.last) {
        return i.getResult(index: i.results.length - 1 - nTypeNumber!.suffixNumber);
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
        return NumberOrNull(singleResult(i: element));
      }
    }

    final newI = InternalVariableWithResults(internalVariableConst: internalVariableConst);
    storage.storage.add(newI);
    final ivfResults = await ivFilter.ivf();
    newI.results.addAll(ivfResults);
    return NumberOrNull(singleResult(i: newI));
  }

  Future<NumberOrNull> filter({
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
    if (internalVariableConst == InternalVariableConstant.countAllConst) {
      return await save(storage: storage, ivFilter: countAllIF);
    }
    if (internalVariableConst == InternalVariableConstant.countNewConst) {
      return await save(storage: storage, ivFilter: countNewIF);
    }
    if (internalVariableConst == InternalVariableConstant.timesConst) {
      return await save(storage: storage, ivFilter: timesIF);
    }
    if (internalVariableConst == InternalVariableConstant.currentActualShowTimeConst) {
      return await save(storage: storage, ivFilter: currentActualShowTimeIF);
    }
    if (internalVariableConst == InternalVariableConstant.nextPlanedShowTimeConst) {
      return await save(storage: storage, ivFilter: currentPlanedShowTimeIF);
    }
    if (internalVariableConst == InternalVariableConstant.showFamiliarConst) {
      return await save(storage: storage, ivFilter: showFamiliarIF);
    }
    if (internalVariableConst == InternalVariableConstant.clickTimeConst) {
      return await save(storage: storage, ivFilter: clickTimeIF);
    }
    if (internalVariableConst == InternalVariableConstant.clickValueConst) {
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
