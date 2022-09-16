part of drift_db;

/// 记忆组类型
enum MemoryGroupType {
  /// 应用内
  inApp,

  /// 全部悬浮悬浮
  allFloating,
}

/// 记忆组状态 for [MemoryGroupType.inApp]
enum MemoryGroupStatus {
  /// 未开始
  notStart,

  /// 继续
  goon,

  /// 已完成
  completed,
}

/// 新旧碎片展示先后顺序。
enum NewReviewDisplayOrder {
  /// 随机混合
  mix,

  /// 优先新的，[FragmentPermanentMemoryInfo]中在当前记忆组中没有记录的。
  newReview,

  /// 优先复习，，[FragmentPermanentMemoryInfo]中在当前记忆组中存在记录的，无论熟练度是不是0。
  reviewNew,
}

/// 新碎片展示先后顺序。
enum NewDisplayOrder {
  /// 随机顺序。
  random,

  /// 按照 [Fragments.title] 首字母 A~Z 顺序，会自动去掉空前缀。
  titleA2Z,

  /// 按照 [Fragments.createdAt] 创建时间早的先于晚的顺序。
  createEarly2Late,
}
