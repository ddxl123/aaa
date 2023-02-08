
part of drift_db;

@ReferenceTo([])
class DocumentGroups extends CloudTableBase  {
  @override
  String? get tableName => "document_groups";
  
  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([DocumentGroups])
  TextColumn get father_document_groups_id => text().named("father_document_groups_id").nullable()();

  TextColumn get title => text().named("title")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        