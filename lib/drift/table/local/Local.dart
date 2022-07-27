part of drift_db;

const List<Type> localTableClass = [
  AppInfos,
];

@ReferenceTo([])
class AppInfos extends LocalTableBase {
  TextColumn get token => text().withDefault(const Constant('unknown'))();

  BoolColumn get hasDownloadedInitData => boolean().withDefault(const Constant(false))();
}
