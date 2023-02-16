
part of drift_db;

@ReferenceTo([])
class Fragments extends CloudTableBase  {
  @override
  String? get tableName => "fragments";
  
  @override
  Set<Column>? get primaryKey => {id};

  BoolColumn get be_sep_publish => boolean().named("be_sep_publish")();

  BoolColumn get client_be_selected => boolean().named("client_be_selected")();

  TextColumn get content => text().named("content")();

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([Fragments])
  TextColumn get father_fragment_id => text().named("father_fragment_id").nullable()();

  @ReferenceTo([FragmentTemplates])
  TextColumn get fragment_template_id => text().named("fragment_template_id").nullable()();

  @ReferenceTo([Notes])
  TextColumn get note_id => text().named("note_id").nullable()();

  TextColumn get tags => text().named("tags")();

  TextColumn get title => text().named("title")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        