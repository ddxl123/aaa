
part of drift_db;

@ReferenceTo([])
class MemoryModels extends CloudTableBase  {
  @override
  String? get tableName => "memory_models";
  
  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get button_algorithm => text().named("button_algorithm").nullable()();

  TextColumn get button_algorithm_remark => text().named("button_algorithm_remark").nullable()();

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  TextColumn get familiarity_algorithm => text().named("familiarity_algorithm").nullable()();

  TextColumn get familiarity_algorithm_remark => text().named("familiarity_algorithm_remark").nullable()();

  @ReferenceTo([Fragments])
  IntColumn get father_memory_model_id => integer().named("father_memory_model_id").nullable()();

  TextColumn get next_time_algorithm => text().named("next_time_algorithm").nullable()();

  TextColumn get next_time_algorithm_remark => text().named("next_time_algorithm_remark").nullable()();

  TextColumn get title => text().named("title")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        