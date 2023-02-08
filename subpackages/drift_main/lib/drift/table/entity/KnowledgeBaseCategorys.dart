
part of drift_db;

@ReferenceTo([])
class KnowledgeBaseCategorys extends CloudTableBase  {
  @override
  String? get tableName => "knowledge_base_categorys";
  
  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get categorys => text().named("categorys")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        