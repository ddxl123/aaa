
part of drift_db_table_part;

@ReferenceTo([])
class Users extends Table {

  @override
  Set<Column>? get primaryKey => {id};

  IntColumn get age => integer().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get password => text().nullable()();

  TextColumn get username => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        