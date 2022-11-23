
part of drift_db;

@ReferenceTo([])
class RDocument2DocumentGroups extends CloudTableBase {

  @override
  Set<Column>? get primaryKey => {id};

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
        