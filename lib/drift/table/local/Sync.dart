part of drift_db;

const List<Type> syncTableClass = [
  Syncs,
];

class Syncs extends LocalTableBase {
  TextColumn get syncTableName => text()();

  IntColumn get rowId => integer()();

  IntColumn get syncCurdType => intEnum<SyncCurdType>().nullable()();

  /// 当为 [SyncCurdType.u] 时，[syncUpdateColumns] 不能为空。
  ///
  /// 值为字段名，如：'username,password'(字段名不能带有空格或英文逗号)
  ///
  /// TODO: 可以去掉让整行都更新。
  TextColumn get syncUpdateColumns => text().nullable()();

  /// 成组标识符。
  ///
  /// 可以看 [SyncTag]。
  ///
  /// 仅对 [CloudTableBase] 的子类表生效,
  /// 当多行 sync 是由同一事务或类似事务性的操作时, 需要对这些行设置相同的 tag。
  /// 当进行上传时, 会将具有相同 tag 的行, 组成一组进行上传。
  ///
  /// 每组 tag 具有唯一性.
  TextColumn get tag => text()();
}
