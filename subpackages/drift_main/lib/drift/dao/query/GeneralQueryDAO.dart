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

  /// 查询 [Syncs.tag] 最小的一组 [Syncs]，以及对应的 row [dynamic] 实体。
  ///
  /// 如果对应的 row 不存在，则 [dynamic] 返回 null。
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
        final result = await fSel.getSingleOrNull();
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

  /// 在查询前，必须已插入过，否则抛出异常
  ///
  /// 如果 [deviceInfo] 与本地查询到的不一致，则抛出异常
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

  /// 查询 [fragment] 的全部 [FragmentGroup] 以及 [RFragment2FragmentGroup]
  Future<List<(FragmentGroup?, RFragment2FragmentGroup)>> queryFragmentGroupAndRs({required Fragment fragment}) async {
    final selJoin = select(rFragment2FragmentGroups).join([
      leftOuterJoin(
        fragmentGroups,
        rFragment2FragmentGroups.fragment_group_id.equalsExp(fragmentGroups.id),
      ),
    ]);
    selJoin.where(rFragment2FragmentGroups.fragment_id.equals(fragment.id));
    final result = await selJoin.get();

    return result.map((e) => (e.readTableOrNull(fragmentGroups), e.readTable(rFragment2FragmentGroups))).toList();
  }

  /// 查询全部游离态的 [Fragment]，即没有对应的 [RFragment2FragmentGroup] 的 [Fragment]
  Future<List<Fragment>> queryAllFreeFragment() async {
    final j = select(fragments).join(
      [leftOuterJoin(rFragment2FragmentGroups, fragments.id.equalsExp(rFragment2FragmentGroups.fragment_id))],
    );
    j.where(rFragment2FragmentGroups.id.isNull());
    return (await j.get()).map((e) => e.readTable(fragments)).toList();
  }

  /// 查询 [targetFragmentGroup] 内的碎片数量，不包含子碎片
  Future<int> queryFragmentsCountInFragmentGroup({
    required FragmentGroup? targetFragmentGroup,
    required QueryFragmentWhereType queryFragmentWhereType,
  }) async {
    final count = rFragment2FragmentGroups.id.count();
    final baseWhereEpr =
        targetFragmentGroup == null ? rFragment2FragmentGroups.fragment_group_id.isNull() : rFragment2FragmentGroups.fragment_group_id.equals(targetFragmentGroup.id);
    final filterWhere = filter<QueryFragmentWhereType, Expression<bool>?>(
      from: queryFragmentWhereType,
      targets: {
        [QueryFragmentWhereType.all]: () => null,
        [QueryFragmentWhereType.selected]: () => rFragment2FragmentGroups.client_be_selected.equals(true),
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

  Future<FragmentGroup?> queryFragmentGroupById({required String id}) async {
    final sel = select(fragmentGroups);
    sel.where((tbl) => tbl.id.equals(id));
    return await sel.getSingleOrNull();
  }

  /// 根据 [fragmentGroupIds] 查询是否存在 [fragmentGroups]。
  ///
  /// 返回存在的 [fragmentGroups]
  Future<Set<String>> queryFragmentGroupIsExistIn({required Set<String> fragmentGroupIds}) async {
    final sel = select(fragmentGroups);
    sel.where((tbl) => tbl.id.isIn(fragmentGroupIds));
    return (await sel.get()).map((e) => e.id).toSet();
  }

  /// 查询 [surfaceFragmentGroup] 内的全部碎片组，不包含子碎片组。
  ///
  /// 不会有重复，因为不会含 jump 的目标碎片组，而被 jump 组本身所代替。
  Future<List<FragmentGroup>> queryFragmentGroupsInFragmentGroupById({required FragmentGroup? surfaceFragmentGroup}) async {
    final sel = select(fragmentGroups);
    sel.where(
      (tbl) {
        if (surfaceFragmentGroup == null) {
          return tbl.father_fragment_groups_id.isNull();
        }
        return tbl.father_fragment_groups_id.equals(
          surfaceFragmentGroup.jump_to_fragment_groups_id ?? surfaceFragmentGroup.id,
        );
      },
    );
    return await sel.get();
  }

  /// 查询 [surfaceFragmentGroup] 内的全部子碎片组，包含子孙组。
  ///
  /// 不会有重复，因为不会含 jump 的目标碎片组，而被 jump 组本身所代替。
  Future<List<FragmentGroup>> querySubFragmentGroupsInFragmentGroupById({required FragmentGroup? surfaceFragmentGroup}) async {
    Future<List<FragmentGroup>> loop({required List<FragmentGroup> list}) async {
      final returnList = <FragmentGroup>[...list];
      for (var v in list) {
        final resultList = await queryFragmentGroupsInFragmentGroupById(surfaceFragmentGroup: v);
        if (resultList.isNotEmpty) {
          returnList.addAll(await loop(list: resultList));
        }
      }
      return returnList;
    }

    final targetFragmentGroups = await queryFragmentGroupsInFragmentGroupById(surfaceFragmentGroup: surfaceFragmentGroup);
    return await loop(list: targetFragmentGroups);
  }

  /// 查询 [surfaceFragmentGroup] 内的全部碎片，不包含子孙碎片。
  ///
  /// 在同一层组内，因为父碎片组是唯一的，所以该组的碎片列表（不含子孙碎片）的 [RFragment2FragmentGroup] 哪怕有重复碎片，其 id 不会存在重复。
  /// 所以该层组可能存在相同 [Fragment] ，但是返回值里的 [Fragment] 不会出现重复，且存在多个 [RFragment2FragmentGroup]。
  ///
  /// 传入的 [set] 与返回的 [set] 是同一个对象。
  Future<Map<String, (Fragment, List<RFragment2FragmentGroup>)>> queryFragmentsInFragmentGroupById({
    required FragmentGroup? surfaceFragmentGroup,
    required Map<String, (Fragment, List<RFragment2FragmentGroup>)> set,
  }) async {
    final sel = select(fragments).join(
      [
        innerJoin(rFragment2FragmentGroups, rFragment2FragmentGroups.fragment_id.equalsExp(fragments.id)),
      ],
    )..where(
        surfaceFragmentGroup == null
            ? rFragment2FragmentGroups.fragment_group_id.isNull()
            : rFragment2FragmentGroups.fragment_group_id.equals(
                surfaceFragmentGroup.jump_to_fragment_groups_id ?? surfaceFragmentGroup.id,
              ),
      );
    final s = await sel.get();
    s.map(
      (e) {
        final f = e.readTable(fragments);
        final f2fg = e.readTable(rFragment2FragmentGroups);
        if (!set.containsKey(f.id)) {
          set.addAll({f.id: (f, [])});
        }
        // 同时用于递归
        if (!set[f.id]!.$2.any((element) => element.id == f2fg.id)) {
          set[f.id]!.$2.add(f2fg);
        }
      },
    ).toList();
    return set;
  }

  /// 查询 [surfaceFragmentGroup] 内的全部子碎片，包含子孙碎片。
  ///
  /// 虽然 [FragmentGroup] 不会存在重复，但是因为是递归查询，而非一次性查询，
  /// 所以 [RFragment2FragmentGroup] 和 [Fragment] 可能会查询到多次。
  /// 返回值里的 [Fragment] 不会出现重复，且存在多个 [RFragment2FragmentGroup]。
  Future<Map<String, (Fragment, List<RFragment2FragmentGroup>)>> querySubFragmentsInFragmentGroupById({
    required FragmentGroup? surfaceFragmentGroup,
  }) async {
    final subFragmentGroups = await querySubFragmentGroupsInFragmentGroupById(surfaceFragmentGroup: surfaceFragmentGroup);

    final set = <String, (Fragment, List<RFragment2FragmentGroup>)>{};
    // 先查询 targetFragmentGroup 内的碎片
    await queryFragmentsInFragmentGroupById(surfaceFragmentGroup: surfaceFragmentGroup, set: set);
    // 再查询 subFragmentGroups 内的碎片
    for (var v in subFragmentGroups) {
      await queryFragmentsInFragmentGroupById(surfaceFragmentGroup: v, set: set);
    }
    return set;
  }

  /// TODO: 引入 jump
  /// 查询 [surfaceFragmentGroup] 内的全部子碎片的数量，包含子孙碎片。
  Future<int> querySubFragmentsCountInFragmentGroup({
    required FragmentGroup? surfaceFragmentGroup,
    required QueryFragmentWhereType queryFragmentWhereType,
  }) async {
    final subFragmentGroups = await querySubFragmentGroupsInFragmentGroupById(surfaceFragmentGroup: surfaceFragmentGroup);
    // 查询 targetFragmentGroup 内的碎片数量。
    var count = await queryFragmentsCountInFragmentGroup(
      targetFragmentGroup: surfaceFragmentGroup,
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
  /// 返回值:
  ///   - 第一个参数：surfaceFragmentGroup
  ///   - 第二个参数：jumpTargetFragmentGroup
  // Future<List<(FragmentGroup, FragmentGroup)>> queryFragmentGroupInWhichFragmentGroupChain({required FragmentGroup unknownFragmentGroup}) async {
  //   final singleChain = <(FragmentGroup, FragmentGroup)>[];
  //   // 检查是否为跳转组
  //   final targetSel = select(fragmentGroups)..where((tbl) => tbl.jump_to_fragment_groups_id.equals(unknownFragmentGroup.id));
  //   // 可能存在于多个 surface 组内
  //   final targets = await targetSel.get();
  //
  //
  //   // 开始循环
  //   Future<void> foreachQuery(FragmentGroup fg) async {
  //     if (fg.father_fragment_groups_id == null) {
  //       return;
  //     }
  //     final foreachSel = select(fragmentGroups);
  //     foreachSel.where((tbl) => tbl.id.equals(fg.father_fragment_groups_id!));
  //     final foreachResult = await foreachSel.getSingle();
  //     singleChain.add(foreachResult);
  //     await foreachQuery(foreachResult);
  //   }
  //
  //   await foreachQuery(unknownFragmentGroup);
  //
  //   return singleChain.reversed.toList();
  // }

  /// 查询全部已选的碎片，以及对应的已选 [RFragment2FragmentGroup]
  ///
  /// TODO: [RFragment2FragmentGroup] 的 fragment 可能不存在，当原碎片被删除时，其 [RFragment2FragmentGroup] 会找不到对应的 fragment。
  /// TODO: 但不会报错，会处于游离态。
  Future<Map<String, (Fragment, List<RFragment2FragmentGroup>)>> queryAllSelectedFragments() async {
    final sel = select(fragments).join([
      innerJoin(rFragment2FragmentGroups, rFragment2FragmentGroups.fragment_id.equalsExp(fragments.id)),
    ]);
    sel.where(rFragment2FragmentGroups.client_be_selected.equals(true));
    // sel.groupBy([fragments.id]);
    final r = await sel.get();
    final result = <String, (Fragment, List<RFragment2FragmentGroup>)>{};
    r.map(
      (e) {
        final fs = e.readTable(fragments);
        final f2fg = e.readTable(rFragment2FragmentGroups);
        if (!result.containsKey(fs.id)) {
          result.addAll({fs.id: (fs, [])});
        }
        result[fs.id]!.$2.add(f2fg);
      },
    ).toList();
    return result;
  }

  Future<RFragment2FragmentGroup> queryRFragment2FragmentGroup({
    required RFragment2FragmentGroup rFragment2FragmentGroup,
  }) async {
    final j = select(rFragment2FragmentGroups);
    j.where((tbl) => tbl.id.equals(rFragment2FragmentGroup.id));
    return await j.getSingle();
  }

  Future<List<RFragment2FragmentGroup>> querySelectedRFragment2FragmentGroups({required List<String> fragmentIds}) async {
    final j = select(rFragment2FragmentGroups)..where((tbl) => tbl.fragment_id.isIn(fragmentIds) & tbl.client_be_selected.equals(true));
    return await j.get();
  }

  /// 查询全部已选的碎片组
  ///
  /// 包含 jump 类型本身，但不包含 jump 目标组，因为选择的时候不包含。
  Future<List<FragmentGroup>> queryAllSelectedFragmentGroups() async {
    final sel = select(fragmentGroups);
    sel.where((tbl) => tbl.client_be_selected.equals(true));
    final result = await sel.get();
    return result;
  }

  /// 查询全部已选的碎片数量。
  Future<int> querySelectedFragmentCount() async {
    final count = rFragment2FragmentGroups.id.count();
    final sel = selectOnly(rFragment2FragmentGroups)
      ..where(rFragment2FragmentGroups.client_be_selected.equals(true))
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

  Future<List<FragmentGroupTag>> queryFragmentGroupTagsByFragmentGroupId({required String fragmentGroupId}) async {
    final sel = select(fragmentGroupTags);
    sel.where((tbl) => tbl.fragment_group_id.equals(fragmentGroupId));
    return await sel.get();
  }

  /// 每个 tag 都有唯一的 id，因此无需去重。
  Future<List<FragmentGroupTag>> queryFragmentGroupTagsByFragmentGroupIds({
    required List<String> fragmentGroupIds,
  }) async {
    final j = select(fragmentGroupTags)..where((tbl) => tbl.fragment_group_id.isIn(fragmentGroupIds));

    final result = await j.get();

    return result;
  }

  /// TODO: jump 的目标碎片组存在被原作者删除的情况。
  Future<FragmentGroup?> queryJumpTargetFragmentGroup({required String jumpTargetFragmentGroupId}) async {
    final j = select(fragmentGroups)..where((tbl) => tbl.id.equals(jumpTargetFragmentGroupId));
    return await j.getSingleOrNull();
  }
}
