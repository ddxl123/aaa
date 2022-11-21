
part of drift_db_table_part;

@ReferenceTo([])
class FragmentMemoryInfos extends Table {

  IntColumn get clickTime => integer()();

  RealColumn get clickValue => real()();

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  IntColumn get currentActualShowTime => integer()();

  @ReferenceTo([Fragments])
  IntColumn get fragmentId => integer()();

  BoolColumn get isLatestRecord => boolean()();

  @ReferenceTo([MemoryGroups])
  IntColumn get memoryGroupId => integer()();

  DateTimeColumn get nextPlanShowTime => dateTime()();

  RealColumn get showFamiliarity => real()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        