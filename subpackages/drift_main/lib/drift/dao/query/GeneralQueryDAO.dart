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

  /// 查询 [Syncs.tag] 最小的一组 [Syncs]，以及对应的 row 实体。
  ///
  /// 返回空数组表示已经全部上传完成。
  Future<List<(Sync, dynamic)>> querySameSyncTagWithRow() async {
    final sel = select(syncs);
    sel.orderBy([(_) => OrderingTerm.asc(_.tag)]);
    sel.limit(1);
    final syncsResult = await sel.getSingleOrNull();
    if (syncsResult == null) return [];

    final multiSyncsResult = await (select(syncs)..where((tbl) => tbl.tag.equals(syncsResult.tag))).get();

    final returnResult = <(Sync, dynamic)>[];
    await Future.forEach<Sync>(
      multiSyncsResult,
      (element) async {
        dynamic ti = db.getTableInfoFromTableActualName(tableActualName: element.sync_table_name);
        final fSel = select(ti)..where((tbl) => (tbl as dynamic).id.equals(element.row_id));
        final result = await fSel.getSingle();
        returnResult.add((element, result));
      },
    );

    return returnResult;
  }

  Future<User?> queryUserOrNull() async {
    final manyUsers = await select(users).get();
    if (manyUsers.length > 1) {
      throw "本地存在多个用户！";
    }
    return manyUsers.isEmpty ? null : manyUsers.first;
  }

  /// 在查询前，必须已插入过，否则抛出异常。
  ///
  /// 如果 [deviceInfo] 与本地查询到的不一致，则抛出异常。
  Future<ClientSyncInfo> queryClientSyncInfo([String? deviceInfo]) async {
    final result = await queryClientSyncInfoOrNull();
    if (result == null) throw "ClientSyncInfo 不应该为空";
    if (deviceInfo != null && result.device_info != deviceInfo) throw "响应的 deviceInfo 与本地查询到的不一致！";
    return result;
  }

  Future<ClientSyncInfo?> queryClientSyncInfoOrNull() async {
    final sel = await select(clientSyncInfos).get();
    if (sel.length > 1) throw "本地存在多个客户端同步信息！";
    return sel.isEmpty ? null : sel.first;
  }

  Future<Fragment> queryFragmentById({required String id}) async {
    return await (select(fragments)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  /// 查询 [targetFragmentGroupId] 内的碎片数量，不包含子碎片。
  Future<int> queryFragmentsCountInFragmentGroup({
    required String? targetFragmentGroupId,
    required QueryFragmentWhereType queryFragmentWhereType,
  }) async {
    final count = fragments.id.count();
    final baseWhereEpr =
        targetFragmentGroupId == null ? rFragment2FragmentGroups.fragment_group_id.isNull() : rFragment2FragmentGroups.fragment_group_id.equals(targetFragmentGroupId);
    final filterWhere = filter<QueryFragmentWhereType, Expression<bool>?>(
      from: queryFragmentWhereType,
      targets: {
        [QueryFragmentWhereType.all]: () => null,
        [QueryFragmentWhereType.selected]: () => fragments.client_be_selected.equals(true),
      },
      orElse: null,
    );
    final sel = selectOnly(fragments).join(
      [
        innerJoin(rFragment2FragmentGroups, rFragment2FragmentGroups.fragment_id.equalsExp(fragments.id), useColumns: false),
      ],
    )
      ..addColumns([count])
      ..where(filterWhere == null ? baseWhereEpr : baseWhereEpr & filterWhere);
    final result = await sel.getSingle();

    return result.read(count)!;
  }

  /// 查询 [targetFragmentGroupId] 内的全部碎片，不包含子碎片。
  Future<List<Fragment>> queryFragmentsInFragmentGroupById({required String? targetFragmentGroupId}) async {
    final sel = select(fragments).join(
      [
        innerJoin(rFragment2FragmentGroups, rFragment2FragmentGroups.fragment_id.equalsExp(fragments.id)),
      ],
    )..where(
        targetFragmentGroupId == null ? rFragment2FragmentGroups.fragment_group_id.isNull() : rFragment2FragmentGroups.fragment_group_id.equals(targetFragmentGroupId),
      );
    final result = await sel.get();
    return result.map((e) => e.readTable(fragments)).toList();
  }

  /// 查询 [targetFragmentGroupId] 内的全部碎片组和碎片组配置，不包含子碎片组。
  Future<List<FragmentGroup>> queryFragmentGroupsInFragmentGroupById({required String? targetFragmentGroupId}) async {
    final sel = select(fragmentGroups);
    sel.where(
      (tbl) => targetFragmentGroupId == null ? tbl.father_fragment_groups_id.isNull() : tbl.father_fragment_groups_id.equals(targetFragmentGroupId),
    );
    return await sel.get();
  }

  /// 查询 [targetFragmentGroupId] 内的全部子碎片组。
  Future<List<FragmentGroup>> querySubFragmentGroupsInFragmentGroupById({required String? targetFragmentGroupId}) async {
    Future<List<FragmentGroup>> loop({required List<FragmentGroup> list}) async {
      final returnList = <FragmentGroup>[...list];
      await Future.forEach<FragmentGroup>(
        list,
        (element) async {
          final resultList = await queryFragmentGroupsInFragmentGroupById(targetFragmentGroupId: element.id);
          if (resultList.isNotEmpty) {
            returnList.addAll(await loop(list: resultList));
          }
        },
      );
      return returnList;
    }

    final targetFragmentGroups = await queryFragmentGroupsInFragmentGroupById(targetFragmentGroupId: targetFragmentGroupId);
    return await loop(list: targetFragmentGroups);
  }

  /// 查询 [targetFragmentGroupId] 内的全部子碎片。
  Future<List<Fragment>> querySubFragmentsInFragmentGroupById({required String? targetFragmentGroupId}) async {
    final subFragmentGroups = await querySubFragmentGroupsInFragmentGroupById(targetFragmentGroupId: targetFragmentGroupId);
    // 查询 targetFragmentGroup 内的碎片。
    final fs = await queryFragmentsInFragmentGroupById(targetFragmentGroupId: targetFragmentGroupId);
    // 查询子碎片组内的碎片。
    await Future.forEach<FragmentGroup>(
      subFragmentGroups,
      (element) async {
        fs.addAll(await queryFragmentsInFragmentGroupById(targetFragmentGroupId: element.id));
      },
    );
    return fs;
  }

  /// 查询 [targetFragmentGroupId] 内的全部子碎片的数量。
  Future<int> querySubFragmentsCountInFragmentGroup({
    required String? targetFragmentGroupId,
    required QueryFragmentWhereType queryFragmentWhereType,
  }) async {
    final subFragmentGroups = await querySubFragmentGroupsInFragmentGroupById(targetFragmentGroupId: targetFragmentGroupId);
    // 查询 targetFragmentGroup 内的碎片数量。
    var count = await queryFragmentsCountInFragmentGroup(
      targetFragmentGroupId: targetFragmentGroupId,
      queryFragmentWhereType: queryFragmentWhereType,
    );
    // 查询子碎片组内的碎片数量。
    await Future.forEach<FragmentGroup>(
      subFragmentGroups,
      (element) async {
        count += await queryFragmentsCountInFragmentGroup(
          targetFragmentGroupId: element.id,
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
      if (fg.father_fragment_groups_id == null) {
        return;
      }
      final foreachSel = select(fragmentGroups);
      foreachSel.where((tbl) => tbl.id.equals(fg.father_fragment_groups_id!));
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
    rSel.where((tbl) => tbl.fragment_id.equals(fragment.id));
    final rSelResult = await rSel.get();

    final multiChain = <List<FragmentGroup>>[];
    await Future.forEach<RFragment2FragmentGroup>(
      rSelResult,
      (element) async {
        if (element.fragment_group_id == null) {
          multiChain.add([]);
          return;
        }

        final latestSel = select(fragmentGroups);
        latestSel.where((tbl) => tbl.id.equals(element.fragment_group_id!));
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
    sel.where((tbl) => tbl.client_be_selected.equals(true));
    final result = await sel.get();
    return result;
  }

  /// 查询全部已选的碎片数量。
  Future<int> querySelectedFragmentCount() async {
    final count = fragments.id.count();
    final sel = selectOnly(fragments)
      ..where(fragments.client_be_selected.equals(true))
      ..addColumns([count]);
    final result = await sel.getSingle();
    return result.read(count)!;
  }

  /// 查询已选碎片在 [memoryGroup] 中重复的数量，根据 [FragmentMemoryInfo.fragmentId] 判断。
  Future<int> querySelectedFragmentsRepeatCount({required MemoryGroup memoryGroup}) async {
    final count = fragmentMemoryInfos.id.count();
    final selOnly = selectOnly(fragmentMemoryInfos).join([innerJoin(fragments, fragments.id.equalsExp(fragmentMemoryInfos.fragment_id), useColumns: false)])
      ..where(fragmentMemoryInfos.memory_group_id.equals(memoryGroup.id))
      ..groupBy([fragmentMemoryInfos.fragment_id])
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

  Future<MemoryGroup?> queryMemoryGroupById({required String id}) async {
    return await (select(memoryGroups)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// 获取全部记忆模型。
  Future<List<MemoryModel>> queryMemoryModels() async {
    return await select(memoryModels).get();
  }

  /// 查询 [memoryGroup] 中的全部碎片。
  Future<List<Fragment>> queryFragmentsInMemoryGroup({required MemoryGroup memoryGroup}) async {
    final selJoin = select(fragments).join([innerJoin(fragmentMemoryInfos, fragments.id.equalsExp(fragmentMemoryInfos.fragment_id))])
      ..where(fragmentMemoryInfos.memory_group_id.equals(memoryGroup.id));
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
        (tbl) => tbl.fragment_id.equals(fragment.id) & tbl.memory_group_id.equals(memoryGroup.id),
      );
    final result = await selOnly.get();
    return result.isEmpty ? false : true;
  }

  /// 查询 [memoryGroup] 中的全部碎片数量。
  Future<int> queryFragmentsCountInMemoryGroup({required MemoryGroup memoryGroup}) async {
    final count = fragments.id.count();
    final selJoin = selectOnly(fragments).join([innerJoin(fragmentMemoryInfos, fragments.id.equalsExp(fragmentMemoryInfos.fragment_id), useColumns: false)])
      ..where(fragmentMemoryInfos.memory_group_id.equals(memoryGroup.id))
      ..addColumns([count]);
    final result = await selJoin.getSingle();
    return result.read(count)!;
  }

  /// 查询 [memoryGroup] 中的 [MemoryModel]。
  Future<MemoryModel?> queryMemoryModelInMemoryGroup({required MemoryGroup memoryGroup}) async {
    if (memoryGroup.memory_model_id == null) return null;
    return await (select(memoryModels)..where((tbl) => tbl.id.equals(memoryGroup.memory_model_id!))).getSingle();
  }

  /// 根据 [MemoryModel.id] 查询 [MemoryModel]。
  Future<MemoryModel> queryMemoryModelById({required String memoryModelId}) async {
    return await (select(memoryModels)..where((tbl) => tbl.id.equals(memoryModelId))).getSingle();
  }

  /// 获取 [memoryGroup] 内全部碎片数量。
  Future<int> queryFragmentsCount({required MemoryGroup memoryGroup}) async {
    final count = rFragment2FragmentGroups.id.count();
    final sel = selectOnly(rFragment2FragmentGroups);
    sel.addColumns([count]);
    sel.where(rFragment2FragmentGroups.fragment_group_id.equals(memoryGroup.id));
    final result = await sel.getSingle();
    return result.read(count)!;
  }

  Future<int> queryFragmentsCountByStudyStatus({required MemoryGroup memoryGroup, required StudyStatus studyStatus}) async {
    final count = fragmentMemoryInfos.id.count();
    final sel = selectOnly(fragmentMemoryInfos);
    sel.addColumns([count]);
    sel.where(fragmentMemoryInfos.memory_group_id.equals(memoryGroup.id) & fragmentMemoryInfos.study_status.equalsValue(studyStatus));
    final result = await sel.getSingle();
    return result.read(count)!;
  }

  Future<bool> queryFragmentGroupIsSynced({required String fragmentGroupId}) async {
    final sel = select(syncs);
    sel.where((tbl) => tbl.sync_table_name.equals(fragmentGroups.actualTableName) & tbl.row_id.equals(fragmentGroupId));
    final result = await sel.get();
    return result.isEmpty;
  }

  /// 更新时间晚的在前。
  Future<List<Shorthand>> queryAllShorthandsByTime() async {
    return await (select(shorthands)
          ..orderBy(
            [
              (_) => OrderingTerm(expression: _.updated_at, mode: OrderingMode.desc),
            ],
          ))
        .get();
  }
}
