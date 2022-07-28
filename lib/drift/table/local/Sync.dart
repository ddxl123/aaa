part of drift_db;

const List<Type> syncTableClass = [
  Syncs,
];

class Syncs extends LocalTableBase {
  TextColumn get syncTableName => text()();

  TextColumn get rowId => text()();

  IntColumn get syncCurdType => intEnum<SyncCurdType>().nullable()();

  /// 当为 [SyncCurdType.u] 时，[syncUpdateColumns] 不能为空。
  ///
  /// 值为字段名，如：'username,password'(字段名不能带有空格或英文逗号)
  ///
  /// TODO: 可以去掉让整行都更新。
  TextColumn get syncUpdateColumns => text().nullable()();

  /// 同组标识符，可以看 [SyncTag]。
  ///
  /// 当多行 sync 是由同一事务或同一组合的操作时, 需要对这些行设置相同的 tag。
  ///
  /// 当进行上传时, 会将具有相同 tag 的行, 组成一组进行上传，再由云端对该组进行事务操作。
  ///
  /// 仅对 [CloudTableBase] 的子类表生效。
  /// 每组 tag 具有唯一性.
  IntColumn get tag => integer()();
}
