
part of drift_db;

@ReferenceTo([])
class FragmentMemoryInfos extends CloudTableBase  {
  @override
  String? get tableName => "fragment_memory_infos";
  
  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get click_time => text().named("click_time").nullable()();

  TextColumn get click_value => text().named("click_value").nullable()();

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  TextColumn get current_actual_show_time => text().named("current_actual_show_time").nullable()();

  @ReferenceTo([Fragments])
  TextColumn get fragment_id => text().named("fragment_id")();

  @ReferenceTo([MemoryGroups])
  TextColumn get memory_group_id => text().named("memory_group_id")();

  TextColumn get next_plan_show_time => text().named("next_plan_show_time").nullable()();

  TextColumn get show_familiarity => text().named("show_familiarity").nullable()();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        