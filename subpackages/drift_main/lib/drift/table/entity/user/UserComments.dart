
part of drift_db;

@ReferenceTo([])
class UserComments extends CloudTableBase  {
  @override
  String? get tableName => "user_comments";
  
  @override
  Set<Column>? get primaryKey => {id};


  TextColumn get comment_content => text().named("comment_content")();

  @ReferenceTo([Users])
  IntColumn get commentator_user_id => integer().named("commentator_user_id")();

  @ReferenceTo([FragmentGroups])
  TextColumn get fragment_group_id => text().named("fragment_group_id").nullable()();

  @ReferenceTo([Fragments])
  TextColumn get fragment_id => text().named("fragment_id").nullable()();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        