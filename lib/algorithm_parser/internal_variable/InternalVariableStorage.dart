part of algorithm_parser;

class NTypeNumber {
  final NType nType;
  final int suffixNumber;

  NTypeNumber({required this.nType, required this.suffixNumber});

  String get getCombineString => '_${nType.name}$suffixNumber';
}

class IvFilter<R> {
  /// [R] ：查看 [InternalVariableWithResults.rawTypeResult] 注释。
  final Future<R> Function() ivf;

  /// 如果在同一个 [InternalVariableStorage] 对象中，重复出现相同变量多次，是否要重新获取。
  final bool isReGet;

  IvFilter({required this.ivf, required this.isReGet});
}

/// 防止忘记返回。
///
/// [NR] - [InternalVariableWithResults.InternalVariableWithResults] 注释。
class AtomResultOrNull<NR> {
  AtomResultOrNull(this.nr);

  NR? nr;
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

  /// 若 [internalVariableConstant] 不支持 _n 后缀，则 [nTypeNumber] 必然为空，否则必然不为空。
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
        throw KnownAlgorithmException("$getCombineName 内置变量缺少 _${NType.nlast}n 或 _${NType.ntimes}n 后缀！");
      }

      if (nTypeNumber!.suffixNumber <= 0) {
        throw KnownAlgorithmException('"$getCombineName" 内置变量的 "n" 值必须大于 0！');
      }
    } else {
      if (nTypeNumber != null) {
        throw KnownAlgorithmException('$getCombineName 内置变量不支持 _${NType.nlast}n 或 _${NType.ntimes}n 后缀！');
      }
    }
  }

  /// 存储并获取 atom 值。
  ///
  /// 根据 [ivFilter] 查询该变量原始数据，并将查询结果存储在 [storage] 中，
  /// 最后根据会 [nTypeNumber] 返回 atom 值。
  Future<AtomResultOrNull<NR>> saveAndGet<NR>({
    required InternalVariableStorage storage,
    required IvFilter ivFilter,
  }) async {
    // 若变量值已获取过
    for (var element in storage.storage) {
      if (element.atom.getCombineName == this.getCombineName) {
        // 若该变量值已获取但为空，或者需要重新获取时
        if (element.rawTypeResult == null || ivFilter.isReGet) {
          element.rawTypeResult = await ivFilter.ivf();
        }
        return element.getNResult<NR>(nTypeNumber: nTypeNumber);
      }
    }

    // 若变量值未获取过
    final newI = InternalVariableWithResults(atom: this);
    storage.storage.add(newI);
    newI.rawTypeResult = await ivFilter.ivf();
    return newI.getNResult(nTypeNumber: nTypeNumber);
  }

  Future<AtomResultOrNull<NR>> filter<NR>({
    required InternalVariableStorage storage,
    required IvFilter<int> k1countAllConst,
    required IvFilter<int> k2CountNeverConst,
    required IvFilter<int> k2CountReviewConst,
    required IvFilter<int> k2CountCompleteConst,
    required IvFilter<int> k2CountStopConst,
    required IvFilter<int> k3StudiedTimesConst,
    required IvFilter<int> k4CurrentShowTimeConst,
    required IvFilter<double> k5CurrentShowFamiliarityConst,
    required IvFilter<List<double>> k6CurrentButtonValuesConst,
    required IvFilter<int> k7CurrentClickTimeConst,
    required IvFilter<double> k6CurrentButtonValueConst,
    required IvFilter<List<int>> i1ActualShowTimeConst,
    required IvFilter<List<int>> i2NextPlanShowTimeConst,
    required IvFilter<List<double>> i3ShowFamiliarityConst,
    required IvFilter<List<double>> i4ClickFamiliarityConst,
    required IvFilter<List<int>> i5ClickTimeConst,
    required IvFilter<List<double>> i6ClickValueConst,
    required IvFilter<List<List<double>>> i7ButtonValuesConst,
  }) async {
    if (internalVariableConstant == InternalVariableConstantHandler.k1FCountAllConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: k1countAllConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k2FCountNeverConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: k2CountNeverConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k2FCountReviewConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: k2CountReviewConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k2FCountCompleteConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: k2CountCompleteConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k2FCountStopConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: k2CountStopConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k3StudiedTimesConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: k3StudiedTimesConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k4CurrentShowTimeConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: k4CurrentShowTimeConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k5CurrentShowFamiliarityConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: k5CurrentShowFamiliarityConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k6CurrentButtonValuesConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: k6CurrentButtonValuesConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k6CurrentButtonValueConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: k6CurrentButtonValueConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.k7CurrentClickTimeConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: k7CurrentClickTimeConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i1ActualShowTimeConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: i1ActualShowTimeConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i2NextPlanShowTimeConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: i2NextPlanShowTimeConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i3ShowFamiliarityConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: i3ShowFamiliarityConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i4ClickFamiliarityConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: i4ClickFamiliarityConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i5ClickTimeConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: i5ClickTimeConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i6ClickValueConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: i6ClickValueConst);
    }
    if (internalVariableConstant == InternalVariableConstantHandler.i7ButtonValuesConst) {
      return await saveAndGet<NR>(storage: storage, ivFilter: i7ButtonValuesConst);
    }
    throw KnownAlgorithmException('filter 未处理变量: $getCombineName');
  }
}

class InternalVariableWithResults {
  InternalVariableWithResults({required this.atom});

  final InternalVariableAtom atom;

  /// 原始数据。
  ///
  /// 例如 N 类型 List 列表、非 N 类型数据。
  /// 例如：all_count=123(int类型)，show_time_lastn=[1,2,3](数组类型)，button_data_lastn=[[1,2,3],[1],[]]
  dynamic rawTypeResult = null;

  /// 获取 [rawTypeResult] 中某个元素或自身。
  ///
  /// 若 [rawTypeResult] 自身为非数组，则返回自身，且 [nTypeNumber] 必然为空。
  /// 若 [rawTypeResult] 自身为数组，则返回 [nTypeNumber] 角标元素，且 [nTypeNumber] 必然不为空。
  ///
  /// 当 [nTypeNumber] 为空时，返回结果必然不为空。
  /// 返回 null 的可能性：
  ///  - [nTypeNumber] 超出 list 长度。
  AtomResultOrNull<E> getNResult<E>({required NTypeNumber? nTypeNumber}) {
    if (rawTypeResult is List?) {
      if (rawTypeResult == null) {
        throw KnownAlgorithmException("当 rawTypeResult 为 List 时，rawTypeResult 不能为 null！");
      }
      if (nTypeNumber == null) {
        throw KnownAlgorithmException("当 rawTypeResult 为 List 时，nTypeNumber 不能为 null！");
      }
      if (rawTypeResult.isEmpty) {
        throw KnownAlgorithmException("getNResult 结果集不能为空！");
      }
      if (nTypeNumber.suffixNumber > (rawTypeResult as List).length) {
        return AtomResultOrNull(null);
      }
      if (nTypeNumber.nType == NType.ntimes) {
        return rawTypeResult[nTypeNumber.suffixNumber - 1];
      } else if (nTypeNumber.nType == NType.nlast) {
        return (rawTypeResult as List).reversed.toList()[nTypeNumber.suffixNumber - 1];
      } else {
        throw KnownAlgorithmException("未处理 ${nTypeNumber.nType}");
      }
    } else {
      if (rawTypeResult == null) {
        throw KnownAlgorithmException("当 rawTypeResult 为不为 List? 类型时，rawTypeResult 不能为 null！");
      }
      if (nTypeNumber != null) {
        throw KnownAlgorithmException("当 rawTypeResult 为非 List 时，nTypeNumber 必须为 null！");
      }
      return AtomResultOrNull(rawTypeResult as E);
    }
  }
}

/// 存储每个内置变量的仓库。
class InternalVariableStorage {
  final List<InternalVariableWithResults> storage = [];
}
