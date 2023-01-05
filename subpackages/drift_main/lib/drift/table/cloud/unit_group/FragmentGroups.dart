
part of drift_db;

@ReferenceTo([])
class FragmentGroups extends CloudTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  BoolColumn get client_be_Selected => boolean()();

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([FragmentGroups])
  TextColumn get fatherFragmentGroupsId => text().nullable()();

  TextColumn get title => text()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        