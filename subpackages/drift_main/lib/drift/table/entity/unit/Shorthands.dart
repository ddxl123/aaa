
part of drift_db;

@ReferenceTo([])
class Shorthands extends CloudTableBase  {
  @override
  String? get tableName => "shorthands";
  
  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get content => text().named("content")();

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        