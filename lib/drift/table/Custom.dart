part of drift_db;

/// 后面不带 'ing' - 暂未执行上传
/// 后面带 'ing' - 正在上传中
///
/// 原因：在客户端上传数据的过程中，客户端可能被断掉，从而客户端未对服务器所上传成功的响应消息进行接受处理。（若是服务器断掉，则客户端会收到失败的响应）
///
/// TODO: 带 'ing' 的处理方式：
///   - 服务端对比 updatedAt。
///   - 若相同，则服务端已同步过。
///   - 若客户端晚于服务端，则需要重新进行同步。
///   - 若客户端早于服务端， 则 1. 可能客户端、服务端时间被篡改；2. 该条数据在其他客户端已经被同步过了 TODO: 可依据此处设计多客户端登陆方案。
enum SyncCurdType {
  /// 增
  c,
  cing,

  /// 改
  u,
  uing,

  /// 删-暂未执行上传
  d,
  ding,
}

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

/// 记忆组类型
enum MemoryGroupType {
  /// 未分配
  none,

  /// 常规(非全悬浮)类型
  normal,

  /// 全悬浮类型
  fullFloating,
}

/// 记忆组状态 for [MemoryGroupType.normal]
enum MemoryGroupStatusForNormal {
  /// 未开始
  notStart,

  /// 继续
  goon,

  /// 已完成
  completed,
}

/// 记忆组状态 for [MemoryGroupType.normal] 的部分悬浮
enum MemoryGroupStatusForNormalPart {
  /// 已启用
  enabled,

  /// 未启用
  disabled,

  /// 已暂停
  paused,
}

/// 记忆组状态 for [MemoryGroupType.fullFloating] 的部分悬浮
enum MemoryGroupStatusForFullFloating {
  /// 未开始
  notStarted,

  /// 记忆中
  remembering,

  /// 已暂停
  pause,

  /// 已完成
  completed,
}
