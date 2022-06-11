part of drift_db;

@DriftAccessor(
  tables: [
    ...cloudTableClass,
    ...rTableClass,
  ],
)
class SingleDAO extends DatabaseAccessor<DriftDb> with _$SingleDAOMixin {
  SingleDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  /// 只查询了未同步的。
  Future<List<FragmentGroup>> queryFragmentGroupsBy(FragmentGroup? fatherFragmentGroup) async {
    final j = innerJoin(rFragmentGroup2FragmentGroups, rFragmentGroup2FragmentGroups.sonId.equalsExp(fragmentGroups.id));
    final w = fatherFragmentGroup == null
        ? rFragmentGroup2FragmentGroups.fatherId.isNull()
        : rFragmentGroup2FragmentGroups.fatherId.equals(fatherFragmentGroup.id);
    final List<TypedResult> result = await (select(fragmentGroups).join([j])..where(w)).get();
    return result.map((e) => e.readTable(fragmentGroups)).toList();
  }

  /// 只查询了未同步的。
  Future<List<Fragment>> queryFragmentsBy(FragmentGroup? fatherFragmentGroup) async {
    final j = innerJoin(rFragment2FragmentGroups, rFragment2FragmentGroups.sonId.equalsExp(fragments.id));
    final w =
        fatherFragmentGroup == null ? rFragment2FragmentGroups.fatherId.isNull() : rFragment2FragmentGroups.fatherId.equals(fatherFragmentGroup.id);
    final List<TypedResult> result = await (select(fragments).join([j])..where(w)).get();
    return result.map((e) => e.readTable(fragments)).toList();
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
}
