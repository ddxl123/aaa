part of drift_db;

const List<Type> syncTableClass = [
  Syncs,
];

class Syncs extends TableBase {
  TextColumn get syncTableName => text()();

  IntColumn get rowId => integer()();

  /// 若 [syncCurdType] 为 [SyncCurdType.d]，则会根据 [rowCloudId] 来进行同步删除：
  ///   - [rowCloudId] 为空时，则无需同步，直接本地删除。
  ///   - [rowCloudId] 不为空时，则需根据该 id 进行同步删除。
  IntColumn get rowCloudId => integer().nullable()();

  IntColumn get syncCurdType => intEnum<SyncCurdType>().nullable()();

  /// 当为 [SyncCurdType.u] 时，[syncUpdateColumns] 不能为空。
  ///
  /// 值为字段名，如：'username,password'(字段名不能带有空格或英文逗号)
  TextColumn get syncUpdateColumns => text().nullable()();

  /// 成组标识符。
  ///
  /// 仅对 [CloudTableBase] 的子类表生效,
  /// 当多行 sync 是由同一事务或类似事务性的操作时, 需要对这些行设置相同的 tag。
  /// 当进行上传时, 会将具有相同 tag 的行, 组成一组进行上传。
  ///
  /// tag 具有唯一性(使用 uuid).
  ///
  /// 同表同 id：
  ///   - 不能设置相同的 tag,否则进行云同步时, 无法识别其晚者的 cloudId (因为晚者可能没有设置过 cloudId),
  ///   - 例如: 若两行同表同 id 的 sync 具有相同的 tag, 则会组成同一组被上传, 第一行为 c, 第二行为 u, 第一行在云端会生成 cloudId, 但是第二行并没有设置过 cloudId, 导致第二行没法被上传成功.
  TextColumn get tag => text()();
}
