part of drift_db;

class TableBase extends Table {
  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}

/// 不需要云同步的基类，主键为自增 int 类型。
class LocalTableBase extends TableBase {
  IntColumn get id => integer().autoIncrement()();
}

/// 需要云同步的基类，主键 id 为 String 类型。
class CloudTableBase extends TableBase {
  @override
  Set<Column>? get primaryKey => {id};

  /// 当子表类为 [Users] 时，
  ///   - 云端创建、云端获取。
  ///   - 无需自增，无需作为主键。
  ///
  /// 当子表类为非 [Users] 时，
  ///   - 生成方案：user_id + uuid.v4
  ///
  /// 云端的 id 无论是创建还是存储，都用字符串类型，若为雪花id，则也要转成字符串类型，以方便开发减少业务逻辑。
  TextColumn get id => text()();
}

/// 关联表基类。
///
/// 子类类名规范：RSon2Fathers
///   Son - 儿 - 多对一的多
///   Father - 父 - 多对一的一
///
/// 一个 son 可以存在于多个 father 时才能继承并使用这个表，否则应该直接在自身表内增加其 father(id) 进行关联。
class RCloudTableBase extends CloudTableBase {
  TextColumn get fatherId => text().nullable()();

  TextColumn get sonId => text()();
}
