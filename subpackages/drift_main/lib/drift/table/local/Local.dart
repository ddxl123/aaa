part of drift_db;

const List<Type> localTableClasses = [
  AppInfos,
];

@ReferenceTo([])
class AppInfos extends LocalTableBase {
  TextColumn get token => text()();

  BoolColumn get hasDownloadedInitData => boolean()();
}
