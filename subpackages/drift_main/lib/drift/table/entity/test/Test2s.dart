
part of drift_db;

@ReferenceTo([])
class Test2s extends CloudTableBase  {
  @override
  String? get tableName => "test2s";
  
  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get client_content => text().named("client_content")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        