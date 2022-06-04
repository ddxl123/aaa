part of drift_db;

/// 每个表都需要的基类。
class TableBase extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}

/// 需要云同步基类。
class CloudTableBase extends TableBase {
  IntColumn get cloudId => integer().nullable().customConstraint('UNIQUE')();
}

/// 关联表基类。
///
/// 子类类名规范：RSon2Fathers
///   Son - 儿
///   Father - 父
class RCloudTableBase extends CloudTableBase {
  IntColumn get sonId => integer()();

  IntColumn get sonCloudId => integer().nullable()();

  IntColumn get fatherId => integer().nullable()();

  IntColumn get fatherCloudId => integer().nullable()();
}
