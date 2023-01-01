part of drift_db;

enum QueryFragmentWhereType {
  /// 查询全部碎片。
  all,

  /// 查询 [Fragment.isSelected] 为 true 的碎片。
  selected,
}

/// TODO: 所有curd函数体都要包裹上事务。
@DriftAccessor(
  tables: tableClasses,
)
class GeneralQueryDAO extends DatabaseAccessor<DriftDb> with _$GeneralQueryDAOMixin {
  GeneralQueryDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<User?> queryUserOrNull() async {
    final manyUsers = await select(users).get();
    if (manyUsers.length > 1) {
      throw '暂时不能登录多个用户！';
    }
    return manyUsers.isEmpty ? null : manyUsers.first;
  }

  Future<User> queryUser() async {
    final manyUsers = await select(users).get();
    if (manyUsers.length > 1) {
      throw '暂时不能登录多个用户！';
    }
    return manyUsers.first;
  }

  /// 查询 [targetFragmentGroup] 内的碎片数量，不包含子碎片。
  Future<int> queryFragmentsCountInFragmentGroup({
    required FragmentGroup? targetFragmentGroup,
    required QueryFragmentWhereType queryFragmentWhereType,
  }) async {
    final count = fragments.id.count();
    final baseWhereEpr = targetFragmentGroup == null ? rFragment2FragmentGroups.fragmentGroupId.isNull() : rFragment2FragmentGroups.fragmentGroupId.equals(targetFragmentGroup.id);
    final filterWhere = filter<QueryFragmentWhereType, Expression<bool>?>(
      from: queryFragmentWhereType,
      targets: {
        [QueryFragmentWhereType.all]: () => null,
        [QueryFragmentWhereType.selected]: () => fragments.local_be_Selected.equals(true),
      },
      orElse: null,
    );
    final sel = selectOnly(fragments).join(
      [
        innerJoin(rFragment2FragmentGroups, rFragment2FragmentGroups.fragmentId.equalsExp(fragments.id), useColumns: false),
      ],
    )
      ..addColumns([count])
      ..where(filterWhere == null ? baseWhereEpr : baseWhereEpr & filterWhere);
    final result = await sel.getSingle();

    return result.read(count)!;
  }

  /// 查询 [targetFragmentGroup] 内的全部碎片，不包含子碎片。
  Future<List<Fragment>> queryFragmentsInFragmentGroup({required FragmentGroup? targetFragmentGroup}) async {
    final sel = select(fragments).join(
      [
        innerJoin(rFragment2FragmentGroups, rFragment2FragmentGroups.fragmentId.equalsExp(fragments.id)),
      ],
    )..where(
        targetFragmentGroup == null ? rFragment2FragmentGroups.fragmentGroupId.isNull() : rFragment2FragmentGroups.fragmentGroupId.equals(targetFragmentGroup.id),
      );
    final result = await sel.get();
    return result.map((e) => e.readTable(fragments)).toList();
  }

  /// 查询 [targetFragmentGroup] 内的全部碎片组，不包含子碎片组。
  Future<List<FragmentGroup>> queryFragmentGroupsInFragmentGroup({required FragmentGroup? targetFragmentGroup}) async {
    final sel = select(fragmentGroups)
      ..where((tbl) => targetFragmentGroup == null ? tbl.fatherFragmentGroupsId.isNull() : tbl.fatherFragmentGroupsId.equals(targetFragmentGroup.id));
    return await sel.get();
  }

  /// 查询 [targetFragmentGroup] 内的全部子碎片组。
  Future<List<FragmentGroup>> querySubFragmentGroupsInFragmentGroup({required FragmentGroup? targetFragmentGroup}) async {
    Future<List<FragmentGroup>> loop({required List<FragmentGroup> list}) async {
      final returnList = <FragmentGroup>[...list];
      await Future.forEach<FragmentGroup>(
        list,
        (element) async {
          final resultList = await queryFragmentGroupsInFragmentGroup(targetFragmentGroup: element);
          if (resultList.isNotEmpty) {
            returnList.addAll(await loop(list: resultList));
          }
        },
      );
      return returnList;
    }

    final targetFragmentGroups = await queryFragmentGroupsInFragmentGroup(targetFragmentGroup: targetFragmentGroup);
    return await loop(list: targetFragmentGroups);
  }

  /// 查询 [targetFragmentGroup] 内的全部子碎片。
  Future<List<Fragment>> querySubFragmentsInFragmentGroup({required FragmentGroup? targetFragmentGroup}) async {
    final subFragmentGroups = await querySubFragmentGroupsInFragmentGroup(targetFragmentGroup: targetFragmentGroup);
    // 查询 targetFragmentGroup 内的碎片。
    final fs = await queryFragmentsInFragmentGroup(targetFragmentGroup: targetFragmentGroup);
    // 查询子碎片组内的碎片。
    await Future.forEach<FragmentGroup>(
      subFragmentGroups,
      (element) async {
        fs.addAll(await queryFragmentsInFragmentGroup(targetFragmentGroup: element));
      },
    );
    return fs;
  }

  /// 查询 [targetFragmentGroup] 内的全部子碎片的数量。
  Future<int> querySubFragmentsCountInFragmentGroup({
    required FragmentGroup? targetFragmentGroup,
    required QueryFragmentWhereType queryFragmentWhereType,
  }) async {
    final subFragmentGroups = await querySubFragmentGroupsInFragmentGroup(targetFragmentGroup: targetFragmentGroup);
    // 查询 targetFragmentGroup 内的碎片数量。
    var count = await queryFragmentsCountInFragmentGroup(
      targetFragmentGroup: targetFragmentGroup,
      queryFragmentWhereType: queryFragmentWhereType,
    );
    // 查询子碎片组内的碎片数量。
    await Future.forEach<FragmentGroup>(
      subFragmentGroups,
      (element) async {
        count += await queryFragmentsCountInFragmentGroup(
          targetFragmentGroup: element,
          queryFragmentWhereType: queryFragmentWhereType,
        );
      },
    );
    return count;
  }

  /// 查询碎片组处在哪些碎片组链上。
  ///
  /// 如果 chain 为空数组，则表示 root 组，root 组不算进 chain 数组中。
  ///
  /// [fragmentGroup] 会被算进在 chain 中。
  Future<List<FragmentGroup>> queryFragmentGroupInWhichFragmentGroupChain({required FragmentGroup fragmentGroup}) async {
    final singleChain = <FragmentGroup>[fragmentGroup];
    // 开始循环
    Future<void> foreachQuery(FragmentGroup fg) async {
      if (fg.fatherFragmentGroupsId == null) {
        return;
      }
      final foreachSel = select(fragmentGroups);
      foreachSel.where((tbl) => tbl.id.equals(fg.fatherFragmentGroupsId!));
      final foreachResult = await foreachSel.getSingle();
      singleChain.add(foreachResult);
      await foreachQuery(foreachResult);
    }

    await foreachQuery(fragmentGroup);

    return singleChain.reversed.toList();
  }

  /// 查询碎片处在哪些碎片组链上。
  ///
  /// 一个相同碎片可能存储在不同的碎片组链上，因此返回值为多个。
  ///
  /// 如果 chain 为空数组，则表示 root 组，root 组不算进 chain 数组中。
  Future<List<List<FragmentGroup>>> queryFragmentInWhichFragmentGroupChain({required Fragment fragment}) async {
    final rSel = select(rFragment2FragmentGroups);
    rSel.where((tbl) => tbl.fragmentId.equals(fragment.id));
    final rSelResult = await rSel.get();

    final multiChain = <List<FragmentGroup>>[];
    await Future.forEach<RFragment2FragmentGroup>(
      rSelResult,
      (element) async {
        if (element.fragmentGroupId == null) {
          multiChain.add([]);
          return;
        }

        final latestSel = select(fragmentGroups);
        latestSel.where((tbl) => tbl.id.equals(element.fragmentGroupId!));
        final latestResult = await latestSel.getSingle();
        final singleChain = await queryFragmentGroupInWhichFragmentGroupChain(fragmentGroup: latestResult);
        multiChain.add(singleChain);
      },
    );
    return multiChain;
  }

  /// 查询全部已选的碎片。
  Future<List<Fragment>> querySelectedFragments() async {
    final sel = select(fragments);
    sel.where((tbl) => tbl.local_be_Selected.equals(true));
    final result = await sel.get();
    return result;
  }

  /// 查询全部已选的碎片数量。
  Future<int> querySelectedFragmentCount() async {
    final count = fragments.id.count();
    final sel = selectOnly(fragments)
      ..where(fragments.local_be_Selected.equals(true))
      ..addColumns([count]);
    final result = await sel.getSingle();
    return result.read(count)!;
  }

  /// 查询已选碎片在 [memoryGroup] 中重复的数量，根据 [FragmentMemoryInfo.fragmentId] 判断。
  Future<int> querySelectedFragmentsRepeatCount({required MemoryGroup memoryGroup}) async {
    final count = fragmentMemoryInfos.id.count();
    final selOnly = selectOnly(fragmentMemoryInfos).join([innerJoin(fragments, fragments.id.equalsExp(fragmentMemoryInfos.fragmentId), useColumns: false)])
      ..where(fragmentMemoryInfos.memoryGroupId.equals(memoryGroup.id))
      ..groupBy([fragmentMemoryInfos.fragmentId])
      ..addColumns([count]);
    final result = await selOnly.get();
    return result.length;
  }

  /// 只查询了未同步的。
  Future<List<Fragment>> queryFragmentsByIds(List<String> ids) async {
    return await (select(fragments)..where((tbl) => tbl.id.isIn(ids))).get();
  }

  /// 获取全部记忆组。
  Future<List<MemoryGroup>> queryMemoryGroups() async {
    return await select(memoryGroups).get();
  }

  /// 获取全部记忆模型。
  Future<List<MemoryModel>> queryMemoryModels() async {
    return await select(memoryModels).get();
  }

  /// 查询 [memoryGroup] 中的全部碎片。
  Future<List<Fragment>> queryFragmentsInMemoryGroup({required MemoryGroup memoryGroup}) async {
    final selJoin = select(fragments).join([innerJoin(fragmentMemoryInfos, fragments.id.equalsExp(fragmentMemoryInfos.fragmentId))])
      ..where(fragmentMemoryInfos.memoryGroupId.equals(memoryGroup.id));
    final result = await selJoin.get();
    return result.map((e) => e.readTable(fragments)).toList();
  }

  /// 查询 [fragment] 是否存在于 [memoryGroup] 中。
  Future<bool> queryIsExistFragmentInMemoryGroup({
    required Fragment fragment,
    required MemoryGroup memoryGroup,
  }) async {
    final selOnly = select(fragmentMemoryInfos)
      ..where(
        (tbl) => tbl.fragmentId.equals(fragment.id) & tbl.memoryGroupId.equals(memoryGroup.id),
      );
    final result = await selOnly.get();
    return result.isEmpty ? false : true;
  }

  /// 查询 [memoryGroup] 中的全部碎片数量。
  Future<int> queryFragmentsCountInMemoryGroup({required MemoryGroup memoryGroup}) async {
    final count = fragments.id.count();
    final selJoin = selectOnly(fragments).join([innerJoin(fragmentMemoryInfos, fragments.id.equalsExp(fragmentMemoryInfos.fragmentId), useColumns: false)])
      ..where(fragmentMemoryInfos.memoryGroupId.equals(memoryGroup.id))
      ..addColumns([count]);
    final result = await selJoin.getSingle();
    return result.read(count)!;
  }

  /// 查询 [memoryGroup] 中的 [MemoryModel]。
  Future<MemoryModel?> queryMemoryModelInMemoryGroup({required MemoryGroup memoryGroup}) async {
    if (memoryGroup.memoryModelId == null) return null;
    return await (select(memoryModels)..where((tbl) => tbl.id.equals(memoryGroup.memoryModelId!))).getSingle();
  }

  /// 根据 [MemoryModel.id] 查询 [MemoryModel]。
  Future<MemoryModel> queryMemoryModelById({required String memoryModelId}) async {
    return await (select(memoryModels)..where((tbl) => tbl.id.equals(memoryModelId))).getSingle();
  }

  /// 获取 [memoryGroup] 内全部碎片数量。
  ///
  /// 实际上是查询 [FragmentMemoryInfo] 数量。
  Future<int> queryFragmentsCount({required MemoryGroup memoryGroup}) async {
    final count = fragmentMemoryInfos.id.count();
    final sel = selectOnly(fragmentMemoryInfos);
    sel.addColumns([count]);
    sel.where(fragmentMemoryInfos.memoryGroupId.equals(memoryGroup.id));
    final result = await sel.getSingle();
    return result.read(count)!;
  }

  /// 获取 [memoryGroup] 内暂未学习过的碎片数量。
  ///
  /// 实际上是查询 [FragmentMemoryInfo] 数量。
  Future<int> queryNewFragmentsCount({required MemoryGroup memoryGroup}) async {
    final count = fragmentMemoryInfos.id.count();
    final sel = selectOnly(fragmentMemoryInfos);
    sel.addColumns([count]);
    sel.where(fragmentMemoryInfos.memoryGroupId.equals(memoryGroup.id) & fragmentMemoryInfos.nextPlanShowTime.isNull());
    final result = await sel.getSingle();
    return result.read(count)!;
  }

  /// 获取 [memoryGroup] 内已经学习过至少一次的碎片数量。
  ///
  /// 实际上是查询 [FragmentMemoryInfo] 数量。
  Future<int> queryLearnedFragmentsCount({required MemoryGroup memoryGroup}) async {
    final count = fragmentMemoryInfos.id.count();
    final sel = selectOnly(fragmentMemoryInfos);
    sel.addColumns([count]);
    sel.where(fragmentMemoryInfos.memoryGroupId.equals(memoryGroup.id) & fragmentMemoryInfos.nextPlanShowTime.isNotNull());
    final result = await sel.getSingle();
    return result.read(count)!;
  }

  /// 通过 [fragmentTemplateId] 查询 [FragmentTemplate]。
  Future<FragmentTemplate> queryFragmentTemplateById({required String fragmentTemplateId}) async {
    final sel = select(fragmentTemplates);
    sel.where((tbl) => tbl.id.equals(fragmentTemplateId));
    final result = await sel.getSingle();
    return result;
  }
}
