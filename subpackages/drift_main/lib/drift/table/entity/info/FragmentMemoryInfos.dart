
part of drift_db;

@ReferenceTo([])
class FragmentMemoryInfos extends CloudTableBase  {
  @override
  String? get tableName => "fragment_memory_infos";
  
  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get actual_show_time => text().named("actual_show_time")();

  BoolColumn get be_synced => boolean().named("be_synced")();

  TextColumn get button_values => text().named("button_values")();

  TextColumn get click_familiarity => text().named("click_familiarity")();

  TextColumn get click_time => text().named("click_time")();

  TextColumn get click_value => text().named("click_value")();

  TextColumn get content_value => text().named("content_value")();

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([Fragments])
  IntColumn get fragment_id => integer().named("fragment_id")();

  @ReferenceTo([MemoryGroups])
  IntColumn get memory_group_id => integer().named("memory_group_id")();

  TextColumn get next_plan_show_time => text().named("next_plan_show_time")();

  TextColumn get show_familiarity => text().named("show_familiarity")();

  TextColumn get study_status => textEnum<StudyStatus>().named("study_status")();

  IntColumn get sync_version => integer().named("sync_version")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        