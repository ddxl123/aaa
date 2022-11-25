part of drift_db;

@ReferenceTo([])
class AppInfos extends LocalTableBase {
  TextColumn get token => text()();

  BoolColumn get hasDownloadedInitData => boolean()();
}
