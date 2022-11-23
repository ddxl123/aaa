
part of drift_db;

@ReferenceTo([])
class MemoryModelGroups extends CloudTableBase {

  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([MemoryModelGroups])
  IntColumn get fatherMemoryModelGroupsId => integer().nullable()();

  TextColumn get title => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        