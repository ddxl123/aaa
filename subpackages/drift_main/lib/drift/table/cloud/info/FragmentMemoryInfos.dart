
part of drift_db;

@ReferenceTo([])
class FragmentMemoryInfos extends CloudTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get clickTime => text().nullable()();

  TextColumn get clickValue => text().nullable()();

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  TextColumn get currentActualShowTime => text().nullable()();

  @ReferenceTo([Fragments])
  TextColumn get fragmentId => text()();

  @ReferenceTo([MemoryGroups])
  TextColumn get memoryGroupId => text()();

  TextColumn get nextPlanShowTime => text().nullable()();

  TextColumn get showFamiliarity => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        