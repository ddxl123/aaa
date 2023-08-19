
part of drift_db;

@ReferenceTo([])
class FragmentGroups extends CloudTableBase  {
  @override
  String? get tableName => "fragment_groups";
  
  @override
  Set<Column>? get primaryKey => {id};

  @override
  bool get withoutRowId => true;


  BoolColumn get be_publish => boolean().named("be_publish")();

  BoolColumn get client_be_cloud_path_upload => boolean().named("client_be_cloud_path_upload")();

  BoolColumn get client_be_selected => boolean().named("client_be_selected")();

  TextColumn get client_cover_local_path => text().named("client_cover_local_path").nullable()();

  TextColumn get cover_cloud_path => text().named("cover_cloud_path").nullable()();

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([FragmentGroups])
  TextColumn get father_fragment_groups_id => text().named("father_fragment_groups_id").nullable()();

  @ReferenceTo([FragmentGroups])
  TextColumn get jump_to_fragment_groups_id => text().named("jump_to_fragment_groups_id").nullable()();

  TextColumn get profile => text().named("profile")();

  TextColumn get title => text().named("title")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        