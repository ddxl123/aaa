
part of drift_db;

@ReferenceTo([])
class Documents extends CloudTableBase {

  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get content => text().nullable()();

  @ReferenceTo([Users])
  IntColumn get creatorUserId => integer()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get id => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

}
        