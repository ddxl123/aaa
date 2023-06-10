
part of drift_db;

@ReferenceTo([])
class Syncs extends ClientTableBase  {
  @override
  String? get tableName => "syncs";
  
  @override
  Set<Column>? get primaryKey => {id};


  TextColumn get row_id => text().named("row_id")();

  IntColumn get sync_curd_type => intEnum<SyncCurdType>().named("sync_curd_type")();

  TextColumn get sync_table_name => text().named("sync_table_name")();

  IntColumn get tag => integer().named("tag")();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id").autoIncrement()();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        