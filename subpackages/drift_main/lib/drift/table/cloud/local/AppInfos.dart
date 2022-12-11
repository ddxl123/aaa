
part of drift_db;

@ReferenceTo([])
class AppInfos extends LocalTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  BoolColumn get hasDownloadedInitData => boolean()();

  TextColumn get token => text()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get updatedAt => dateTime()();

}
        