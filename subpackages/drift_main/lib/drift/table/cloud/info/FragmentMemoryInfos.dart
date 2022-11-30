
part of drift_db;

@ReferenceTo([])
class FragmentMemoryInfos extends CloudTableBase  {

  @override
  Set<Column>? get primaryKey => {id};

  DateTimeColumn get clickTime => dateTime()();

  RealColumn get clickValue => real()();

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  DateTimeColumn get currentActualShowTime => dateTime()();

  @ReferenceTo([Fragments])
  TextColumn get fragmentId => text()();

  BoolColumn get isLatestRecord => boolean()();

  @ReferenceTo([MemoryGroups])
  TextColumn get memoryGroupId => text()();

  DateTimeColumn get nextPlanShowTime => dateTime()();

  RealColumn get showFamiliarity => real()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        