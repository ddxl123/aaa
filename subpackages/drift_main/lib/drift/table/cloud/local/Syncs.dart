
part of drift_db;

@ReferenceTo([])
class Syncs extends LocalTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get rowId => text()();

  IntColumn get syncCurdType => intEnum<SyncCurdType>()();

  TextColumn get syncTableName => text()();

  IntColumn get tag => integer()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer()();

  DateTimeColumn get updatedAt => dateTime()();

}
        