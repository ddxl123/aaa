
part of drift_db;

@ReferenceTo([])
class RFragment2FragmentGroups extends CloudTableBase  {
  @override
  String? get tableName => "r_fragment2_fragment_groups";
  
  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([FragmentGroups])
  IntColumn get fragment_group_id => integer().named("fragment_group_id").nullable()();

  @ReferenceTo([Fragments])
  IntColumn get fragment_id => integer().named("fragment_id")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        