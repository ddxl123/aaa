
part of drift_db_table_part;

@ReferenceTo([])
class Notes extends Table {

  TextColumn get content => text().nullable()();

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([Documents])
  IntColumn get documentId => integer().nullable()();

  @ReferenceTo([Notes])
  IntColumn get fatherNoteId => integer().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        