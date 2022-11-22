
part of drift_db_table_part;

@ReferenceTo([])
class RNote2NoteGroups extends Table {

  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([NoteGroups])
  IntColumn get noteGroupId => integer()();

  @ReferenceTo([Notes])
  IntColumn get noteId => integer()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        