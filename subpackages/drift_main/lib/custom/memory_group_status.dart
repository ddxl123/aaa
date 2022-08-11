part of drift_db;

/// 记忆组类型
enum MemoryGroupType {
  /// 应用内
  inApp,

  /// 全部悬浮悬浮
  allFloating,

  /// 跟随模型
  followModel,
}

/// 记忆组状态 for [MemoryGroupType.inApp]
enum MemoryGroupStatusForInApp {
  /// 未开始
  notStart,

  /// 继续
  goon,

  /// 已完成
  completed,
}

/// 记忆组状态 for [MemoryGroupType.inApp] 的部分悬浮
enum MemoryGroupStatusForInAppPart {
  /// 已启用
  enabled,

  /// 未启用
  disabled,

  /// 已暂停
  paused,
}

/// 记忆组状态 for [MemoryGroupType.allFloating] 的部分悬浮
enum MemoryGroupStatusForAllFloating {
  /// 未开始
  notStarted,

  /// 记忆中
  remembering,

  /// 已暂停
  pause,

  /// 已完成
  completed,
}
