
part of drift_db;

@ReferenceTo([])
class Test2s extends CloudTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get client_content => text()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer()();

  DateTimeColumn get updatedAt => dateTime()();

}
        