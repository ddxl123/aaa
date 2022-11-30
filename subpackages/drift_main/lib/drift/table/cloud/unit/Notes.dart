
part of drift_db;

@ReferenceTo([])
class Notes extends CloudTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get content => text()();

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([Documents])
  TextColumn get documentId => text().nullable()();

  @ReferenceTo([Notes])
  TextColumn get fatherNoteId => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        