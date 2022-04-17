part of drift_db;

class AppInfos extends TableBase {
  TextColumn get token => text().nullable()();

  BoolColumn get hasDownloadedInitData => boolean().withDefault(const Constant(false))();
}
