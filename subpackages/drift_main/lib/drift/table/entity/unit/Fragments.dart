
part of drift_db;

@ReferenceTo([])
class Fragments extends CloudTableBase  {
  @override
  String? get tableName => "fragments";
  
  @override
  Set<Column>? get primaryKey => {id};

  BoolColumn get be_sep_publish => boolean().named("be_sep_publish")();

  TextColumn get content => text().named("content")();

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([Fragments])
  IntColumn get father_fragment_id => integer().named("father_fragment_id").nullable()();

  TextColumn get title => text().named("title")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        