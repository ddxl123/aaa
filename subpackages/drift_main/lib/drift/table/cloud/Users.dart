
part of drift_db;

@ReferenceTo([])
class Users extends CloudTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  IntColumn get age => integer()();

  TextColumn get email => text().nullable()();

  TextColumn get password => text().nullable()();

  TextColumn get username => text()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer()();

  DateTimeColumn get updatedAt => dateTime()();

}
        