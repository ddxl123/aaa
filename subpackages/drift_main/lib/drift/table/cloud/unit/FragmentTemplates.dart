
part of drift_db;

@ReferenceTo([])
class FragmentTemplates extends CloudTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get content => text()();

  @ReferenceTo([Users])
  IntColumn get ownerUserId => integer()();

  IntColumn get type => intEnum<FragmentTemplateType>()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        