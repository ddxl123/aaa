
part of drift_db;

@ReferenceTo([])
class Fragments extends CloudTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  BoolColumn get client_be_Selected => boolean()();

  TextColumn get content => text()();

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([Fragments])
  TextColumn get fatherFragmentId => text().nullable()();

  @ReferenceTo([FragmentTemplates])
  TextColumn get fragmentTemplateId => text().nullable()();

  @ReferenceTo([Notes])
  TextColumn get noteId => text().nullable()();

  TextColumn get title => text()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        