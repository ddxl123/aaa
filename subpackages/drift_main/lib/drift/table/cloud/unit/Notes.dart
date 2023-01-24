
part of drift_db;

@ReferenceTo([])
class Notes extends CloudTableBase  {
  @override
  String? get tableName => "notes";
  
  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get content => text().named("content")();

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([Documents])
  TextColumn get document_id => text().named("document_id").nullable()();

  @ReferenceTo([Notes])
  TextColumn get father_note_id => text().named("father_note_id").nullable()();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        