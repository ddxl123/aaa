
part of drift_db;

@ReferenceTo([])
class Users extends CloudTableBase  {
  @override
  String? get tableName => "users";
  
  @override
  Set<Column>? get primaryKey => {id};

  IntColumn get age => integer().named("age").nullable()();

  TextColumn get avatar_cloud_path => text().named("avatar_cloud_path").nullable()();

  TextColumn get client_avatar_local_path => text().named("client_avatar_local_path").nullable()();

  TextColumn get email => text().named("email").nullable()();

  TextColumn get password => text().named("password").nullable()();

  TextColumn get phone => text().named("phone").nullable()();

  TextColumn get username => text().named("username")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        