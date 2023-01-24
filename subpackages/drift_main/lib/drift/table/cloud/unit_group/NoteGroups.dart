
part of drift_db;

@ReferenceTo([])
class NoteGroups extends CloudTableBase  {
  @override
  String? get tableName => "note_groups";
  
  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([NoteGroups])
  TextColumn get father_note_groups_id => text().named("father_note_groups_id").nullable()();

  TextColumn get title => text().named("title")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        