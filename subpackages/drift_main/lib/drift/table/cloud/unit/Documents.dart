
part of drift_db;

@ReferenceTo([])
class Documents extends CloudTableBase {

  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get content => text()();

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        