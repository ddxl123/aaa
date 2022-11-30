
part of drift_db;

@ReferenceTo([])
class MemoryModels extends CloudTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get buttonAlgorithm => text()();

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  TextColumn get familiarityAlgorithm => text()();

  @ReferenceTo([Fragments])
  TextColumn get fatherMemoryModelId => text().nullable()();

  TextColumn get nextTimeAlgorithm => text()();

  TextColumn get stimulateAlgorithm => text()();

  TextColumn get title => text()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        