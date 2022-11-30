
part of drift_db;

@ReferenceTo([])
class RMemoryModel2MemoryModelGroups extends CloudTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([MemoryModelGroups])
  TextColumn get memoryModelGroupId => text().nullable()();

  @ReferenceTo([MemoryModels])
  TextColumn get memoryModelId => text()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        