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
enum MemoryGroupStatus {
  /// 未初始化
  notInit,

  /// 未开始
  notStart,

  /// 继续
  goon,

  /// 已完成
  completed,
}

/// 展示优先级。
/// 随机混合、优先新学、优先复习。
enum DisplayPriority {
  minx,
  newF,
  review,
}
