part of drift_db;

// part 'SingleDAO.g.dart';

@DriftAccessor(
  tables: [
    ...cloudTableClass,
  ],
)
class SingleDAO extends DatabaseAccessor<DriftDb> with _$SingleDAOMixin {
  SingleDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<FragmentGroup> insertFragmentGroup(FragmentGroupsCompanion fragmentGroupsCompanion) async {
    await transaction(
      () async {},
    );
    return await into(fragmentGroups).insertReturning(fragmentGroupsCompanion);
  }

  Future<void> a() async {
    await into(users).insert(UsersCompanion.insert(username: '大苏打撒旦'.toDriftValue()));
    // await (delete(users)..where((tbl) => tbl.id.equals(444))).go();
  }

  /// 如果不存在，则不会执行。
  Future<void> b() async {
    await (update(users)..where((tbl) => tbl.id.equals(1))).write(UsersCompanion.insert(id: 444.toDriftValue()));
  }
}
