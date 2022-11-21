
part of drift_db_table_part;

@ReferenceTo([])
class Documents extends Table {

  TextColumn get content => text().nullable()();

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        