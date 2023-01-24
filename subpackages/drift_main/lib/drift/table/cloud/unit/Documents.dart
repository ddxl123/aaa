
part of drift_db;

@ReferenceTo([])
class Documents extends CloudTableBase  {
  @override
  String? get tableName => "documents";
  
  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get content => text().named("content")();

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        