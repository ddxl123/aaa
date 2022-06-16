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

  Future<MemoryGroup> insertMemoryGroup(MemoryGroupsCompanion willEntry) async {
    return await transaction(
      () async {
        return await insertReturningWith(memoryGroups, entity: willEntry, syncTag: SyncTag());
      },
    );
  }

  Future<List<MemoryGroup>> queryMemoryGroups() async {
    return await select(memoryGroups).get();
  }

  Future<MemoryRule> insertMemoryRule(MemoryRulesCompanion willEntry) async {
    return await transaction(
      () async {
        return await insertReturningWith(memoryRules, entity: willEntry, syncTag: SyncTag());
      },
    );
  }

  Future<List<MemoryRule>> queryMemoryRules() async {
    return await select(memoryRules).get();
  }
}
