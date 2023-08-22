
part of drift_db;

@ReferenceTo([])
class FragmentGroupTags extends CloudTableBase  {
  @override
  String? get tableName => "fragment_group_tags";
  
  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([FragmentGroups])
  IntColumn get fragment_group_id => integer().named("fragment_group_id")();

  TextColumn get tag => text().named("tag")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        