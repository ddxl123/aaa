part of algorithm_parser;

class NTypeNumber {
  final NType nType;
  final int suffixNumber;

  NTypeNumber({required this.nType, required this.suffixNumber});

  String get getCombineString => '_${nType.name}$suffixNumber';
}

class IvFilter<R> {
  /// [R] 为获取到的数值类型。
  final Future<R> Function() ivf;

  /// 如果在同一个 [InternalVariableStorage] 对象中，重复出现相同变量多次，是否要重新获取。
  final bool isReGet;

  IvFilter({required this.ivf, required this.isReGet});
}

/// 无论识别到的内置变量是否已识别过，只要识别到一个内置变量，都会生成一个新的 [InternalVariableAtom] 实例。
class InternalVariableAtom<CS extends ClassificationState> {
  InternalVariableAtom({
    required this.internalVariableConstant,
    required this.currentState,
    required this.nTypeNumber,
    required this.hasNullMerge,
  });

  final InternalVariableConstant internalVariableConstant;
  final CS currentState;
  final NTypeNumber? nTypeNumber;

  /// 变量后面是否存在空合并符号。
  final bool hasNullMerge;

  String get getCombineName => internalVariableConstant.name + (nTypeNumber == null ? '' : nTypeNumber!.getCombineString);

  /// 排查错误。
  void handleException() {
    if (internalVariableConstant.isReadFromMemoryInfo) {
      if (!internalVariableConstant.isNullable && hasNullMerge) {
        throw KnownAlgorithmException("$getCombineName 内置变量必然不为空，请去掉空合并运算符！");
      }
      if (nTypeNumber == null) {
        throw KnownAlgorithmException("$getCombineName 内置变量缺少 _${NType.last}n 或 _${NType.times}n 后缀！");
      }

      if (nTypeNumber!.suffixNumber <= 0) {
        throw KnownAlgorithmException('"$getCombineName" 内置变量的 "n" 值必须大于 0！');
      }
    } else {
      if (nTypeNumber != null) {
        throw KnownAlgorithmException('$getCombineName 内置变量不支持 _${NType.last}n 或 _${NType.times}n 后缀！');
      }
    }
  }

  /// 根据 [ivFilter] 查询该变量原始类型值(例如 字符串数组、int、double...)，并将查询结果存储在 [storage] 中，
  /// 最后根据 [nTypeNumber] 返回变量结果值。
  Future<NR> saveAndGet<NR>({
    required InternalVariableStorage storage,
    required IvFilter ivFilter,
  }) async {
    // 若变量值已获取过
    for (var element in storage.storage) {
      if (element.atom.getCombineName == this.getCombineName) {
        // 若该变量值已获取但为空，或者需要重新获取时
        if (element.rawTypeResult == null || ivFilter.isReGet) {
          final ivfResults = await ivFilter.ivf();
          element.rawTypeResult = ivfResults;
        }
        return element.getNResult(nTypeNumber: nTypeNumber);
      }
    }

    // 若变量值未获取过
    final newI = InternalVariableWithResults(atom: this);
    storage.storage.add(newI);
    final ivfResults = await ivFilter.ivf();
    newI.rawTypeResult = ivfResults;
    return newI.getNResult(nTypeNumber: nTypeNumber);
  }

  Future<NR> filter<NR>({
    required InternalVariableStorage storage,
    required IvFilter<int> k1countAllConst,
    required IvFilter<int> k2CountNewConst,
    required IvFilter<int> k3TimesConst,
    required IvFilter<int> k4CurrentShowTimeConst,
    required IvFilter<double> k5CurrentShowFamiliarityConst,
    required IvFilter<List<double>> k6CurrentButtonValuesConst,
    required IvFilter<List<int>> i1ActualShowTimeConst,
    required IvFilter<List<int>> i2NextPlanShowTimeConst,
    required IvFilter<List<double>> i3ShowFamiliarityConst,
    required IvFilter<List<double>> i4ClickFamiliarityConst,
    required IvFilter<List<int>> i5ClickTimeConst,
    required IvFilter<List<double>> i6ClickValueConst,
    required IvFilter<List<List<double>>> i7ButtonValuesConst,
  }) async {
    if (internalVariableConstant == InternalVariableConstantHandler.k1countAllConst) {
      return await saveAndGet(storage: storage, ivFilter: k1countAllConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k2CountNewConst) {
      return await saveAndGet(storage: storage, ivFilter: k1countAllConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k3TimesConst) {
      return await saveAndGet(storage: storage, ivFilter: k1countAllConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k4CurrentShowTimeConst) {
      return await saveAndGet(storage: storage, ivFilter: k1countAllConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k5CurrentShowFamiliarityConst) {
      return await saveAndGet(storage: storage, ivFilter: k1countAllConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k6CurrentButtonValuesConst) {
      return await saveAndGet(storage: storage, ivFilter: k1countAllConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i1ActualShowTimeConst) {
      return await saveAndGet(storage: storage, ivFilter: k1countAllConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i2NextPlanShowTimeConst) {
      return await saveAndGet(storage: storage, ivFilter: k1countAllConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i3ShowFamiliarityConst) {
      return await saveAndGet(storage: storage, ivFilter: k1countAllConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i4ClickFamiliarityConst) {
      return await saveAndGet(storage: storage, ivFilter: k1countAllConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i5ClickTimeConst) {
      return await saveAndGet(storage: storage, ivFilter: k1countAllConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i6ClickValueConst) {
      return await saveAndGet(storage: storage, ivFilter: k1countAllConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i7ButtonValuesConst) {
      return await saveAndGet(storage: storage, ivFilter: k1countAllConst);
    }
    throw KnownAlgorithmException('filter 未处理变量: $getCombineName');
  }
}

class InternalVariableWithResults {
  InternalVariableWithResults({required this.atom});

  final InternalVariableAtom atom;

  dynamic rawTypeResult = null;

  E? getNResult<E>({required NTypeNumber? nTypeNumber}) {
    if (rawTypeResult is List) {
      if (atom.internalVariableConstant == InternalVariableConstantHandler.k6CurrentButtonValuesConst) {

      }

      if (rawTypeResult.isEmpty) {
        throw KnownAlgorithmException("getNResult 结果集不能为空！");
      }
      if (rawTypeResult.length - 1 < index || index < 0) {
        return null;
      }
      return rawTypeResult[index] as E;
    }
    return rawTypeResult as E?;
  }
}

/// 存储每个内置变量的仓库。
class InternalVariableStorage {
  final List<InternalVariableWithResults> storage = [];
}
