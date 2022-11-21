
part of drift_db_table_part;

@ReferenceTo([])
class MemoryGroups extends Table {

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([MemoryModels])
  IntColumn get memoryModelId => integer().nullable()();

  IntColumn get newDisplayOrder => integer().nullable()();

  IntColumn get newReviewDisplayOrder => integer().nullable()();

  DateTimeColumn get reviewInterval => dateTime().nullable()();

  DateTimeColumn get startTime => dateTime().nullable()();

  TextColumn get title => text().nullable()();

  IntColumn get willNewLearnCount => integer().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        