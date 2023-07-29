
part of drift_db;

@ReferenceTo([])
class FragmentGroupTags extends CloudTableBase  {
  @override
  String? get tableName => "fragment_group_tags";
  
  @override
  Set<Column>? get primaryKey => {id};

  @override
  bool get withoutRowId => true;


  TextColumn get tag => text().named("tag")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        