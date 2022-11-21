
part of drift_db_table_part;

@ReferenceTo([])
class Fragments extends Table {

  TextColumn get content => text().nullable()();

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([Fragments])
  IntColumn get fatherFragmentId => integer().nullable()();

  @ReferenceTo([Notes])
  IntColumn get noteId => integer().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        