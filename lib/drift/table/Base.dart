part of drift_db;

/// 不需要云同步的基类。
class TableBase extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}

/// 需要云同步的基类。
class CloudTableBase extends TableBase {
  IntColumn get cloudId => integer().nullable().customConstraint('UNIQUE')();
}

/// 关联表基类。
///
/// 子类类名规范：RSon2Fathers
///   Son - 儿 - 多对一的多
///   Father - 父 - 多对一的一
///
/// 一个 son 可以存在于多个 father 时才能继承并使用这个表，否则应该直接在自身表内增加其 father 进行关联。
class RCloudTableBase extends CloudTableBase {
  IntColumn get sonId => integer().nullable()();

  IntColumn get sonCloudId => integer().nullable()();

  IntColumn get fatherId => integer().nullable()();

  IntColumn get fatherCloudId => integer().nullable()();
}
