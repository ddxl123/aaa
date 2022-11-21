
part of drift_db_table_part;

@ReferenceTo([])
class RMemoryModel2MemoryModelGroups extends Table {

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([MemoryModelGroups])
  IntColumn get memoryModelGroupId => integer()();

  @ReferenceTo([MemoryModels])
  IntColumn get memoryModelId => integer()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        