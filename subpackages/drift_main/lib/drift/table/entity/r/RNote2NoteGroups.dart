
part of drift_db;

@ReferenceTo([])
class RNote2NoteGroups extends CloudTableBase  {
  @override
  String? get tableName => "r_note2_note_groups";
  
  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([NoteGroups])
  TextColumn get note_group_id => text().named("note_group_id").nullable()();

  @ReferenceTo([Notes])
  TextColumn get note_id => text().named("note_id")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        