part of drift_db;


/// 给 tag 创建一个对象，方便引用。
class SyncTag {
  SyncTag() {
    tag = Helper.uuidV4;
  }

  /// 见 [Syncs.tag] 注释。
  late final String tag;

  /// 见 [Syncs.tag] 注释 (同表同 id 部分)。
  final List<String> _tableAndIds = [];

  bool hasCheckedOnce = false;

  /// 检查是否重复:
  ///   1. 同表同 id 是否使用同一个 SyncTag。
  ///   2. 不同 SyncTag 之间的 tag 是否相同。(只需检查一次)
  Future<void> check({required String tableName, required int id}) async {
    // 1
    final String tableAndId = tableName + id.toString();
    _tableAndIds.contains(tableAndId) ? (throw '同表同 id 不能使用同一个 SyncTag！可能对同表同 id 连续多次进行 sync 操作！') : _tableAndIds.add(tableAndId);

    // 2
    if (!hasCheckedOnce) {
      hasCheckedOnce = true;
      final List<Sync> syncs = await (DriftDb.instance.select(DriftDb.instance.syncs)..where((tbl) => tbl.tag.equals(tag))).get();
      if (syncs.isNotEmpty) {
        throw '不同 SyncTag 之间的 tag 不能相同！可能生成了重复的 uuid ！';
      }
    }
  }

  @override
  String toString() => tag;

  @override
  bool operator ==(Object other) {
    return (other is SyncTag) ? tag == other.tag : false;
  }

  @override
  int get hashCode => tag.hashCode;
}
