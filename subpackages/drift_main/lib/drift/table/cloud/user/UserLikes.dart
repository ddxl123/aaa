
part of drift_db;

@ReferenceTo([])
class UserLikes extends CloudTableBase  {
  @override
  String? get tableName => "user_likes";
  
  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([FragmentGroups])
  TextColumn get fragment_group_id => text().named("fragment_group_id").nullable()();

  @ReferenceTo([Fragments])
  TextColumn get fragment_id => text().named("fragment_id").nullable()();

  @ReferenceTo([Users])
  IntColumn get liker_user_id => integer().named("liker_user_id")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        