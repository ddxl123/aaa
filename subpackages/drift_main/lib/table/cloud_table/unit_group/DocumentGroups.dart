
part of drift_db_table_part;

@ReferenceTo([])
class DocumentGroups extends Table {

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([DocumentGroups])
  IntColumn get fatherDocumentGroupsId => integer().nullable()();

  TextColumn get title => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        