
part of drift_db;

@ReferenceTo([])
class MemoryModels extends CloudTableBase  {
  @override
  String? get tableName => "memory_models";
  
  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get button_algorithm => text().named("button_algorithm").nullable()();

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  TextColumn get familiarity_algorithm => text().named("familiarity_algorithm").nullable()();

  @ReferenceTo([Fragments])
  TextColumn get father_memory_model_id => text().named("father_memory_model_id").nullable()();

  TextColumn get modified_button_algorithm => text().named("modified_button_algorithm").nullable()();

  TextColumn get modified_familiarity_algorithm => text().named("modified_familiarity_algorithm").nullable()();

  TextColumn get modified_next_time_algorithm => text().named("modified_next_time_algorithm").nullable()();

  TextColumn get next_time_algorithm => text().named("next_time_algorithm").nullable()();

  TextColumn get title => text().named("title")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        