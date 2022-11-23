
part of drift_db;

@ReferenceTo([])
class MemoryModels extends CloudTableBase {

  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get applicableFields => text().nullable()();

  TextColumn get applicableGroups => text().nullable()();

  TextColumn get buttonAlgorithm => text().nullable()();

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  TextColumn get familiarityAlgorithm => text().nullable()();

  @ReferenceTo([Fragments])
  IntColumn get fatherFragmentId => integer().nullable()();

  TextColumn get nextTimeAlgorithm => text().nullable()();

  TextColumn get stimulateAlgorithm => text().nullable()();

  TextColumn get title => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        