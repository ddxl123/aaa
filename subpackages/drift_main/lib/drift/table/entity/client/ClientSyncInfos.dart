
part of drift_db;

@ReferenceTo([])
class ClientSyncInfos extends ClientTableBase  {
  @override
  String? get tableName => "client_sync_infos";
  
  @override
  Set<Column>? get primaryKey => {id};

  TextColumn get device_info => text().named("device_info")();

  TextColumn get token => text().named("token").nullable()();

  DateTimeColumn get created_at => dateTime().named("created_at")();

  IntColumn get id => integer().named("id").autoIncrement()();

  DateTimeColumn get updated_at => dateTime().named("updated_at")();

}
        