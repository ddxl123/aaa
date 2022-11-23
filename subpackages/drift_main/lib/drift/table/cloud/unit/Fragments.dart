
part of drift_db;

@ReferenceTo([])
class Fragments extends CloudTableBase {

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
        