
part of drift_db;

@ReferenceTo([])
class FragmentTemplates extends CloudTableBase  {
  @override
  String? get tableName => "fragment_templates";
  
  @override
  Set<Column>? get primaryKey => {id};

  @override
  bool get withoutRowId => true;


  TextColumn get content => text().named("content")();

  @ReferenceTo([Users])
  IntColumn get owner_user_id => integer().named("owner_user_id")();

  IntColumn get type => intEnum<FragmentTemplateType>().named("type")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  TextColumn get id => text().named("id")();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        