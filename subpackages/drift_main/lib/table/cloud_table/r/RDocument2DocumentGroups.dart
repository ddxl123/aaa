
part of drift_db_table_part;

@ReferenceTo([])
class RDocument2DocumentGroups extends Table {

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([DocumentGroups])
  IntColumn get documentGroupId => integer().nullable()();

  @ReferenceTo([Documents])
  IntColumn get documentId => integer()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        