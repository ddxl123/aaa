part of drift_db;

/// 说明：
///
/// 1. 每个 column 都不能设置默认值。
///
///
///

/// 不需要云同步的基类，主键为自增 int 类型。
abstract class LocalTableBase extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTimeColumn get createdAt => dateTime()();

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTimeColumn get updatedAt => dateTime()();
}

abstract class CloudTableBase extends Table {}
