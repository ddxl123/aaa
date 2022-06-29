part of drift_db;

@DriftAccessor(
  tables: [
    ...cloudTableClass,
    ...rTableClass,
  ],
)
class SingleDAO extends DatabaseAccessor<DriftDb> with _$SingleDAOMixin {
  SingleDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  /// 查询已同步的、查询未同步的、查询未下载的
  Future<List<FragmentGroup>> queryFragmentGroups(int? fatherFragmentGroupId) async {
    final j = innerJoin(rFragmentGroup2FragmentGroups, rFragmentGroup2FragmentGroups.sonId.equalsExp(fragmentGroups.id));
    final w = fatherFragmentGroupId == null
        ? rFragmentGroup2FragmentGroups.fatherId.isNull()
        : rFragmentGroup2FragmentGroups.fatherId.equals(fatherFragmentGroupId);
    final List<TypedResult> result = await (select(fragmentGroups).join([j])..where(w)).get();
    return result.map((e) => e.readTable(fragmentGroups)).toList();
  }

  /// 只查询了未同步的。
  Future<List<Fragment>> queryFragments(int? fatherFragmentGroupId) async {
    final j = innerJoin(rFragment2FragmentGroups, rFragment2FragmentGroups.sonId.equalsExp(fragments.id));
    final w =
        fatherFragmentGroupId == null ? rFragment2FragmentGroups.fatherId.isNull() : rFragment2FragmentGroups.fatherId.equals(fatherFragmentGroupId);
    final List<TypedResult> result = await (select(fragments).join([j])..where(w)).get();
    return result.map((e) => e.readTable(fragments)).toList();
  }

  /// 只查询了未同步的。
  Future<List<Fragment>> queryFragmentsByIds(List<int> ids) async {
    return await (select(fragments)..where((tbl) => tbl.id.isIn(ids))).get();
  }

  /// 输入的 [ids] 与返回的对象是同一个对象。
  Future<List<int>> queryFragmentsForAllSubgroup(int fragmentGroupId, List<int> ids) async {
    final fIds = (await queryFragments(fragmentGroupId)).map((e) => e.id);
    ids.addAll(fIds);
    final fgIds = (await queryFragmentGroups(fragmentGroupId)).map((e) => e.id);
    await Future.forEach<int>(
      fgIds,
      (fgId) async {
        await queryFragmentsForAllSubgroup(fgId, ids);
      },
    );
    return ids;
  }

  /// 向当前 [FragmentGroups] 表中插入一条数据, 返回新插入的 [FragmentGroup]。
  Future<FragmentGroup> insertFragmentGroup(FragmentGroup? fatherEntity, FragmentGroupsCompanion willEntity) async {
    return await transaction(
      () async {
        return await insertReturningWithR(
          sonTable: fragmentGroups,
          sonEntity: willEntity,
          fatherEntity: fatherEntity,
          rTable: rFragmentGroup2FragmentGroups,
          rEntity: RFragmentGroup2FragmentGroupsCompanion(),
          syncTag: SyncTag(),
        );
        // return newEntity;
      },
    );
  }

  /// 向当前 [Fragments] 表中插入一条数据, 返回新插入的 [Fragment]。
  Future<Fragment> insertFragment(FragmentGroup? fatherEntity, FragmentsCompanion willEntity) async {
    return await transaction(
      () async {
        return await insertReturningWithR(
          sonTable: fragments,
          sonEntity: willEntity,
          fatherEntity: fatherEntity,
          rTable: rFragment2FragmentGroups,
          rEntity: RFragment2FragmentGroupsCompanion(),
          syncTag: SyncTag(),
        );
        // return newEntity;
      },
    );
  }

  /// 插入一条 [MemoryGroup]、多条 [RFragment2MemoryGroup]、一条 [RMemoryRule2MemoryGroup]
  Future<void> insertMemoryGroupWith(MemoryGroupsCompanion willMemoryGroup, List<Fragment> willFragments, MemoryModel? willMemoryModel) async {
    return await transaction(
      () async {
        final syncTag = SyncTag();
        final newMemoryGroup = await insertReturningWith(memoryGroups, entity: willMemoryGroup, syncTag: syncTag);
        await Future.forEach<Fragment>(
          willFragments,
          (element) async {
            await insertReturningWith(
              rFragment2MemoryGroups,
              entity: RFragment2MemoryGroupsCompanion(
                sonId: element.id.toDriftValue(),
                sonCloudId: element.cloudId.toDriftValue(),
                fatherId: newMemoryGroup.id.toDriftValue(),
                fatherCloudId: newMemoryGroup.cloudId.toDriftValue(),
              ),
              syncTag: syncTag,
            );
          },
        );
        if (willMemoryModel != null) {
          await insertReturningWith(
            rMemoryModel2MemoryGroups,
            entity: RMemoryModel2MemoryGroupsCompanion(
              sonId: willMemoryModel.id.toDriftValue(),
              sonCloudId: willMemoryModel.cloudId.toDriftValue(),
              fatherId: newMemoryGroup.id.toDriftValue(),
              fatherCloudId: newMemoryGroup.cloudId.toDriftValue(),
            ),
            syncTag: syncTag,
          );
        }
      },
    );
  }

  Future<List<MemoryGroup>> queryMemoryGroups() async {
    return await select(memoryGroups).get();
  }

  Future<MemoryModel> insertMemoryRule(MemoryModelsCompanion willEntry) async {
    return await transaction(
      () async {
        return await insertReturningWith(memoryModels, entity: willEntry, syncTag: SyncTag());
      },
    );
  }

  Future<List<MemoryModel>> queryMemoryRules() async {
    return await select(memoryModels).get();
  }

  Future<List<Fragment>> queryFragmentInMemoryGroup(int memoryGroupId) async {
    final j = select(fragments).join([innerJoin(rFragment2MemoryGroups, rFragment2MemoryGroups.sonId.equalsExp(fragments.id))]);
    j.where(rFragment2MemoryGroups.fatherId.equals(memoryGroupId));
    final gets = await j.get();
    return gets.map((e) => e.readTable(fragments)).toList();
  }

  Future<MemoryModel?> queryMemoryRuleInMemoryGroup(int memoryGroupId) async {
    final j = select(memoryModels).join([innerJoin(rMemoryModel2MemoryGroups, rMemoryModel2MemoryGroups.sonId.equalsExp(memoryModels.id))]);
    j.where(rMemoryModel2MemoryGroups.fatherId.equals(memoryGroupId));
    return (await j.getSingleOrNull())?.readTable(memoryModels);
  }
}
