part of drift_db;

const List<Type> localTableClass = [
  AppInfos,
];

class AppInfos extends TableBase {
  TextColumn get token => text().nullable()();

  BoolColumn get hasDownloadedInitData => boolean().withDefault(const Constant(false))();
}
