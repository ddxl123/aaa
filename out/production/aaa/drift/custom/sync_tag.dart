part of drift_db;

/// 给 tag 创建一个对象，方便引用。
class SyncTag {
  SyncTag._();

  /// 见 [Syncs.tag] 注释。
  late final int tag;

  /// 创建一个新的 sync。
  ///
  /// [tag] 值将被设为 [Syncs] 表中的 sync 列的最大值+1，
  /// 若 [Syncs] 表没有数据，则 [tag] 值将被设为 0.
  static Future<SyncTag> create() async {
    final syncTag = SyncTag._();
    final db = DriftDb.instance;
    final maxExpr = db.syncs.tag.max();
    final result = await (db.selectOnly(db.syncs)..addColumns([maxExpr])).get();
    final max = result.isEmpty ? null : result.first.read(maxExpr);
    syncTag.tag = max == null ? 0 : max + 1;
    return syncTag;
  }

  @override
  bool operator ==(Object other) {
    return (other is SyncTag) ? tag == other.tag : false;
  }

  @override
  int get hashCode => tag.hashCode;
}
