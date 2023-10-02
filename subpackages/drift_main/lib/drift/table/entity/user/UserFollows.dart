
part of drift_db;

@ReferenceTo([])
class UserFollows extends CloudTableBase  {
  @override
  String? get tableName => "user_follows";
  
  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get be_followed_user_id => integer().named("be_followed_user_id")();

  @ReferenceTo([Users])
  IntColumn get follow_user_id => integer().named("follow_user_id")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        