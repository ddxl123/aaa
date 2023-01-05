
part of drift_db;

@ReferenceTo([])
class ClientSyncInfos extends ClientTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  DateTimeColumn get recentSyncTime => dateTime()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get updatedAt => dateTime()();

}
        