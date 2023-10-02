
part of drift_db;

@ReferenceTo([])
class Users extends CloudTableBase  {
  @override
  String? get tableName => "users";
  
  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get area => text().named("area").nullable()();

  TextColumn get avatar_cloud_path => text().named("avatar_cloud_path").nullable()();

  TextColumn get bind_email => text().named("bind_email").nullable()();

  TextColumn get bind_phone => text().named("bind_phone").nullable()();

  DateTimeColumn get birth => dateTime().named("birth").nullable()();

  TextColumn get career => text().named("career").nullable()();

  TextColumn get gender => textEnum<Gender>().named("gender").nullable()();

  TextColumn get interest => text().named("interest").nullable()();

  TextColumn get password => text().named("password").nullable()();

  TextColumn get personalized_tags => text().named("personalized_tags").nullable()();

  TextColumn get profile => text().named("profile").nullable()();

  TextColumn get username => text().named("username")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        