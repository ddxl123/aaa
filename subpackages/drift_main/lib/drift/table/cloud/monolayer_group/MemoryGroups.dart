
part of drift_db;

@ReferenceTo([])
class MemoryGroups extends CloudTableBase {

  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([MemoryModels])
  TextColumn get memoryModelId => text().nullable()();

  IntColumn get newDisplayOrder => intEnum<NewDisplayOrder>()();

  IntColumn get newReviewDisplayOrder => intEnum<NewReviewDisplayOrder>()();

  DateTimeColumn get reviewInterval => dateTime()();

  DateTimeColumn get startTime => dateTime().nullable()();

  TextColumn get title => text()();

  IntColumn get willNewLearnCount => integer()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        