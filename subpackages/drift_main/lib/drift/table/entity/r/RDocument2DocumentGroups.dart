
part of drift_db;

@ReferenceTo([])
class RDocument2DocumentGroups extends CloudTableBase  {
  @override
  String? get tableName => "r_document2_document_groups";
  
  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([DocumentGroups])
  TextColumn get document_group_id => text().named("document_group_id").nullable()();

  @ReferenceTo([Documents])
  TextColumn get document_id => text().named("document_id")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        