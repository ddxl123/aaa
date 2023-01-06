
part of drift_db;

@ReferenceTo([])
class ClientSyncInfos extends ClientTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get deviceInfo => text()();

  DateTimeColumn get recentSyncTime => dateTime().nullable()();

  TextColumn get token => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get updatedAt => dateTime()();

}
        