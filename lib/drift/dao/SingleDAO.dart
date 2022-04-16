part of drift_db;

// part 'SingleDAO.g.dart';

@DriftAccessor(
  tables: [
    /// Local
    AppInfos,

    /// FatherChild
    FatherChild,

    /// Cloud
    Users,
    FragmentGroups,
    Fragments,
    MemoryGroups,
  ],
)
class SingleDAO extends DatabaseAccessor<DriftDb> with _$SingleDAOMixin {
  SingleDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<FragmentGroup> insertFragmentGroup(FragmentGroupsCompanion fragmentGroupsCompanion) async {
    return await into(fragmentGroups).insertReturning(fragmentGroupsCompanion..syncCurd = SyncCurd.c.toDriftValue());
  }

  /// 如果不存在，则不会执行。
  Future<void> updateFragmentGroup() async {
    await (update(fragmentGroups)..where((tbl) => tbl.id.equals(1))).write(FragmentGroupsCompanion(name: 'new name'.toDriftValue()));
  }
}
