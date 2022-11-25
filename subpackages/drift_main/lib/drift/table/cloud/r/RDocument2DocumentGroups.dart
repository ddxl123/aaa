
part of drift_db;

@ReferenceTo([])
class RDocument2DocumentGroups extends CloudTableBase {

  @override
  Set<Column>? get primaryKey => {id};

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  @ReferenceTo([DocumentGroups])
  TextColumn get documentGroupId => text().nullable()();

  @ReferenceTo([Documents])
  TextColumn get documentId => text()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get id => text()();

  DateTimeColumn get updatedAt => dateTime()();

}
        