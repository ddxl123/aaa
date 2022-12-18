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
        [QueryFragmentWhereType.selected]: () => fragments.local_isSelected.equals(true),
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

  /// 查询碎片处在哪个碎片组链上。
  ///
  /// 一个相同碎片可能存储在不同的碎片组链上，因此使用 [rFragment2FragmentGroup] 进行查询。
  ///
  /// 如果返回值为空数组，则表示 root 组。
  /// root 组不算在返回值内。
  Future<List<FragmentGroup>> queryFragmentInWhichFragmentGroupChain({required Fragment fragment,required FragmentGroup fragmentGroup}) async {
    final rSel = select(rFragment2FragmentGroups);
    rSel.where((tbl) => tbl.fragmentId.eq)

    final fgSel = select(fragmentGroups);
    if (rFragment2FragmentGroup.fragmentGroupId == null) {
      return [];
    }
    fgSel.where((tbl) => tbl.id.equals(rFragment2FragmentGroup.fragmentGroupId!));
    final fgResult = await fgSel.getSingle();

    final fgChain = <FragmentGroup>[];
    // 开始循环
    Future<void> foreachQuery(FragmentGroup fg) async {
      if (fg.fatherFragmentGroupsId == null) {
        return;
      }
      final foreachSel = select(fragmentGroups);
      foreachSel.where((tbl) => tbl.id.equals(fg.fatherFragmentGroupsId!));
      final foreachResult = await foreachSel.getSingle();
      fgChain.add(foreachResult);
      await foreachQuery(foreachResult);
    }

    await foreachQuery(fgResult);
    return fgChain.reversed.toList();
  }

  /// 查询全部已选的碎片。
  Future<List<Fragment>> querySelectedFragments() async {
    final sel = select(fragments);
    sel.where((tbl) => tbl.local_isSelected.equals(true));
    final result = await sel.get();
    return result;
  }

  /// 查询全部已选的碎片数量。
  Future<int> querySelectedFragmentCount() async {
    final count = fragments.id.count();
    final sel = selectOnly(fragments)
      ..where(fragments.local_isSelected.equals(true))
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

  /// 查询已同步的、查询未同步的、查询未下载的
  Future<List<FragmentGroup>> queryFragmentGroups(String? fatherFragmentGroupId) async {
    // return await (select(fragmentGroups)
    //       ..where((tbl) => fatherFragmentGroupId == null ? tbl.fatherFragmentGroupId.isNull() : tbl.fatherFragmentGroupId.equals(fatherFragmentGroupId)))
    //     .get();
    return [];
  }

  Future<List<Fragment>> queryFragmentsByFragmentGroupId(String? fragmentGroupId) async {
    // final j = innerJoin(rFragment2FragmentGroups, rFragment2FragmentGroups.sonId.equalsExp(fragments.id));
    // final w = fragmentGroupId == null ? rFragment2FragmentGroups.fatherId.isNull() : rFragment2FragmentGroups.fatherId.equals(fragmentGroupId);
    // final List<TypedResult> result = await (select(fragments).join([j])..where(w)).get();
    // return result.map((e) => e.readTable(fragments)).toList();
    return [];
  }

  /// 只查询了未同步的。
  Future<List<Fragment>> queryFragmentsByIds(List<String> ids) async {
    return await (select(fragments)..where((tbl) => tbl.id.isIn(ids))).get();
  }

  /// 输入的 [ids] 与返回的对象是同一个对象。
  Future<List<String>> queryFragmentsForAllSubgroup(String fragmentGroupId, List<String> ids) async {
    // final fIds = (await queryFragmentsByFragmentGroupId(fragmentGroupId)).map((e) => e.id);
    // ids.addAll(fIds);
    // final fgIds = (await queryFragmentGroups(fragmentGroupId)).map((e) => e.id);
    // await Future.forEach<String>(
    //   fgIds,
    //   (fgId) async {
    //     await queryFragmentsForAllSubgroup(fgId, ids);
    //   },
    // );
    // return ids;
    return [];
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
  Future<int> getFragmentsCount({required MemoryGroup memoryGroup}) async {
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
  Future<int> getNewFragmentsCount({required MemoryGroup memoryGroup}) async {
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
  Future<int> getLearnedFragmentsCount({required MemoryGroup memoryGroup}) async {
    final count = fragmentMemoryInfos.id.count();
    final sel = selectOnly(fragmentMemoryInfos);
    sel.addColumns([count]);
    sel.where(fragmentMemoryInfos.memoryGroupId.equals(memoryGroup.id) & fragmentMemoryInfos.nextPlanShowTime.isNotNull());
    final result = await sel.getSingle();
    return result.read(count)!;
  }
}
