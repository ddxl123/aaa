
part of drift_db_table_part;

@ReferenceTo([])
class Fragments extends Table {

  @override
  Set<Column>? get primaryKey => {id};

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
        