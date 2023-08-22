
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
  IntColumn get fragment_group_id => integer().named("fragment_group_id").nullable()();

  @ReferenceTo([Fragments])
  IntColumn get fragment_id => integer().named("fragment_id").nullable()();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        