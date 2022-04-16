part of drift_db;

class AppInfos extends TableBase {
  TextColumn get token => text()();

  BoolColumn get hasDownloadedInitData => boolean().withDefault(const Constant(false))();
}
