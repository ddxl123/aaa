
part of drift_db;

@ReferenceTo([])
class MemoryGroups extends CloudTableBase {

  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([MemoryModels])
  IntColumn get memoryModelId => integer().nullable()();

  IntColumn get newDisplayOrder => intEnum<NewDisplayOrder>().nullable()();

  IntColumn get newReviewDisplayOrder => intEnum<NewReviewDisplayOrder>().nullable()();

  DateTimeColumn get reviewInterval => dateTime().nullable()();

  DateTimeColumn get startTime => dateTime().nullable()();

  TextColumn get title => text().nullable()();

  IntColumn get willNewLearnCount => integer().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        