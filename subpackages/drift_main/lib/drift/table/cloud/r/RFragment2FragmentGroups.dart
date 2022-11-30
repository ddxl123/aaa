
part of drift_db;

@ReferenceTo([])
class RFragment2FragmentGroups extends CloudTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([FragmentGroups])
  TextColumn get fragmentGroupId => text().nullable()();

  @ReferenceTo([Fragments])
  TextColumn get fragmentId => text()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        