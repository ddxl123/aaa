
part of drift_db;

@ReferenceTo([])
class RNote2NoteGroups extends CloudTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([NoteGroups])
  TextColumn get noteGroupId => text().nullable()();

  @ReferenceTo([Notes])
  TextColumn get noteId => text()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        