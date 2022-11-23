
part of drift_db;

@ReferenceTo([])
class RFragment2FragmentGroups extends CloudTableBase {

  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([FragmentGroups])
  IntColumn get fragmentGroupId => integer()();

  @ReferenceTo([Fragments])
  IntColumn get fragmentId => integer()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        