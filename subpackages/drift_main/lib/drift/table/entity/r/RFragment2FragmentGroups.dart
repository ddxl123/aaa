
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
  TextColumn get fragment_group_id => text().named("fragment_group_id").nullable()();

  @ReferenceTo([Fragments])
  TextColumn get fragment_id => text().named("fragment_id")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        