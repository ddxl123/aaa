part of drift_db;

@DriftAccessor(
  tables: [
    ...cloudTableClass,
    ...rTableClass,
  ],
)
class SingleDAO extends DatabaseAccessor<DriftDb> with _$SingleDAOMixin {
  SingleDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<void> queryFragmentGroupBy(FragmentGroup? fatherFragmentGroup) async {
    late final List<TypedResult> result;

    result = await (select(fragmentGroups).join(
      [
        innerJoin(rFragmentGroup2FragmentGroups, rFragmentGroup2FragmentGroups.sonId.equalsExp(fragmentGroups.id)),
      ],
    )..where(rFragmentGroup2FragmentGroups.fatherId.isNull()))
        .get();

    // await (select(fragmentGroups).join(
    //   [
    //     innerJoin(rFragmentGroup2FragmentGroups, rFragmentGroup2FragmentGroups.fatherId.equalsExp(fragmentGroups.id)),
    //   ],
    // )).get();
    final f = result.map((e) {
      // Helper.logger.i(e.rawData.data);
      return e.rawData.data;
    });
    Helper.logger.i(f);
  }

  Future<void> queryFragmentBy(FragmentGroup? fragmentGroup) async {}

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
