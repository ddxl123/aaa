part of drift_db;

/// 记忆组类型
enum MemoryGroupType {
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
