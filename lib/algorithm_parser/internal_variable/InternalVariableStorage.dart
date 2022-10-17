part of algorithm_parser;

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

  Future<num?> save({
    required InternalVariableStorage storage,
    required IvFilter<num?> ivFilter,
  }) async {
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
