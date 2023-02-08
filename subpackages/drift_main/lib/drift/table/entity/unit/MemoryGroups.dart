
part of drift_db;

@ReferenceTo([])
class MemoryGroups extends CloudTableBase  {
  @override
  String? get tableName => "memory_groups";
  
  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([MemoryModels])
  TextColumn get memory_model_id => text().named("memory_model_id").nullable()();

  IntColumn get new_display_order => intEnum<NewDisplayOrder>().named("new_display_order")();

  IntColumn get new_review_display_order => intEnum<NewReviewDisplayOrder>().named("new_review_display_order")();

  DateTimeColumn get review_interval => dateTime().named("review_interval")();

  DateTimeColumn get start_time => dateTime().named("start_time").nullable()();

  TextColumn get title => text().named("title")();

  @ReferenceTo([FragmentMemoryInfos])
  IntColumn get will_new_learn_count => integer().named("will_new_learn_count")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        