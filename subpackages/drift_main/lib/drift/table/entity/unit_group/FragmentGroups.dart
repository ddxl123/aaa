
part of drift_db;

@ReferenceTo([])
class FragmentGroups extends CloudTableBase  {
  @override
  String? get tableName => "fragment_groups";
  
  @override
  Set<Column>? get primaryKey => {id};

  BoolColumn get be_publish => boolean().named("be_publish")();

  TextColumn get cover_cloud_path => text().named("cover_cloud_path").nullable()();

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([FragmentGroups])
  IntColumn get father_fragment_groups_id => integer().named("father_fragment_groups_id").nullable()();

  @ReferenceTo([FragmentGroups])
  IntColumn get jump_to_fragment_groups_id => integer().named("jump_to_fragment_groups_id").nullable()();

  TextColumn get profile => text().named("profile")();

  TextColumn get title => text().named("title")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        