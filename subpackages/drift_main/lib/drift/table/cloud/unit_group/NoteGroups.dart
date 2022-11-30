
part of drift_db;

@ReferenceTo([])
class NoteGroups extends CloudTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([NoteGroups])
  TextColumn get fatherNoteGroupsId => text().nullable()();

  TextColumn get title => text()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        