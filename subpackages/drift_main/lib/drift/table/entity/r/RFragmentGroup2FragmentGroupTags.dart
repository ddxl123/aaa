
part of drift_db;

@ReferenceTo([])
class RFragmentGroup2FragmentGroupTags extends CloudTableBase  {
  @override
  String? get tableName => "r_fragment_group2_fragment_group_tags";
  
  @override
  Set<Column>? get primaryKey => {id};

  @override
  bool get withoutRowId => true;


  @ReferenceTo([Users])
  IntColumn get creator_user_id => integer().named("creator_user_id")();

  @ReferenceTo([FragmentGroups])
  TextColumn get fragment_group_id => text().named("fragment_group_id").nullable()();

  @ReferenceTo([FragmentGroupTags])
  IntColumn get tag_id => integer().named("tag_id")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        