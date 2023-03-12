
part of drift_db;

@ReferenceTo([])
class MemoryModels extends CloudTableBase  {
  @override
  String? get tableName => "memory_models";
  
  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get button_algorithm_a => text().named("button_algorithm_a").nullable()();

  TextColumn get button_algorithm_b => text().named("button_algorithm_b").nullable()();

  TextColumn get button_algorithm_c => text().named("button_algorithm_c").nullable()();

  TextColumn get button_algorithm_remark => text().named("button_algorithm_remark").nullable()();

  IntColumn get button_algorithm_usage_status => intEnum<AlgorithmUsageStatus>().named("button_algorithm_usage_status")();

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  TextColumn get familiarity_algorithm_a => text().named("familiarity_algorithm_a").nullable()();

  TextColumn get familiarity_algorithm_b => text().named("familiarity_algorithm_b").nullable()();

  TextColumn get familiarity_algorithm_c => text().named("familiarity_algorithm_c").nullable()();

  TextColumn get familiarity_algorithm_remark => text().named("familiarity_algorithm_remark").nullable()();

  IntColumn get familiarity_algorithm_usage_status => intEnum<AlgorithmUsageStatus>().named("familiarity_algorithm_usage_status")();

  @ReferenceTo([Fragments])
  TextColumn get father_memory_model_id => text().named("father_memory_model_id").nullable()();

  TextColumn get next_time_algorithm_a => text().named("next_time_algorithm_a").nullable()();

  TextColumn get next_time_algorithm_b => text().named("next_time_algorithm_b").nullable()();

  TextColumn get next_time_algorithm_c => text().named("next_time_algorithm_c").nullable()();

  TextColumn get next_time_algorithm_remark => text().named("next_time_algorithm_remark").nullable()();

  IntColumn get next_time_algorithm_usage_status => intEnum<AlgorithmUsageStatus>().named("next_time_algorithm_usage_status")();

  TextColumn get title => text().named("title")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        