
part of drift_db;

@ReferenceTo([])
class FragmentGroupBeSaveds extends CloudTableBase  {
  @override
  String? get tableName => "fragment_group_be_saveds";
  
  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([FragmentGroups])
  IntColumn get fragment_group_id => integer().named("fragment_group_id").nullable()();

  @ReferenceTo([Users])
  IntColumn get saved_user_id => integer().named("saved_user_id")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        