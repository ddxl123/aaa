
part of drift_db;

@ReferenceTo([])
class Notes extends CloudTableBase {

  @override
  Set<Column>? get primaryKey => {id};

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
        