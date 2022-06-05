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
  Future<FragmentGroup> insertFragmentGroup(FragmentGroup? fatherEntry, FragmentGroupsCompanion willEntry) async {
    return await transaction(
      () async {
        final st = SyncTag();
        final newEntry = await insertReturningWith(fragmentGroups, entity: willEntry, syncTag: st);
        final r = RFragmentGroup2FragmentGroupsCompanion(
          sonId: newEntry.id.toDriftValue(),
          sonCloudId: newEntry.cloudId.toDriftValue(),
          fatherId: (fatherEntry?.id).toDriftValue(),
          fatherCloudId: (fatherEntry?.cloudId).toDriftValue(),
        );
        await insertReturningWith(rFragmentGroup2FragmentGroups, entity: r, syncTag: st);
        return newEntry;
      },
    );
  }

  /// 向当前 [Fragments] 表中插入一条数据, 返回新插入的 [Fragment]。
  Future<Fragment> insertFragment(FragmentGroup? fatherEntry, FragmentsCompanion willEntry) async {
    return await transaction(
      () async {
        final st = SyncTag();
        final newEntry = await insertReturningWith(fragments, entity: willEntry, syncTag: st);
        final r = RFragment2FragmentGroupsCompanion(
          sonId: newEntry.id.toDriftValue(),
          sonCloudId: newEntry.cloudId.toDriftValue(),
          fatherId: (fatherEntry?.id).toDriftValue(),
          fatherCloudId: (fatherEntry?.cloudId).toDriftValue(),
        );
        await insertReturningWith(rFragment2FragmentGroups, entity: r, syncTag: st);
        return newEntry;
      },
    );
  }
}
