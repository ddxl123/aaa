part of drift_db;

@DriftAccessor(
  tables: [
    ...cloudTableClass,
  ],
)
class MultiDAO extends DatabaseAccessor<DriftDb> with _$MultiDAOMixin {
  MultiDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  Future<void> insertFragmentGroupWithFC(FragmentGroupsCompanion fragmentGroupsCompanion) async {
    await transaction(
      () async {
        await into(fragmentGroups).insert(fragmentGroupsCompanion);
      },
    );
  }
}
