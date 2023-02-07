
part of drift_db;

@ReferenceTo([])
class FragmentGroupConfigs extends CloudTableBase  {
  @override
  String? get tableName => "fragment_group_configs";
  
  @override
  Set<Column>? get primaryKey => {id};

  BoolColumn get be_private => boolean().named("be_private")();

  BoolColumn get be_publish => boolean().named("be_publish")();

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([FragmentGroups])
  TextColumn get fragment_group_id => text().named("fragment_group_id")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        