part of drift_db;

/// 每次新增，都必须把新增的放到最后，否则将出现严重异常！
enum FatherChildType {
  /// 当前是碎片组的最上级。
  topFragmentGroup,

  /// 当前是记忆组的最上级
  topMemoryGroup,

  /// 当前是某个碎片组的子级。
  fragmentGroup,

  /// 当前是某个记忆组的子级。
  memoryGroup,

  /// 当前是回收站的最上级。
  topRecycleBin,
}

/// 只有 Cloud 类型才能存在父子关系， Local 类型不能存在父子关系。
class FatherChilds extends TableBase {
  IntColumn get type => intEnum<FatherChildType>()();

  IntColumn get fatherId => integer().nullable()();

  IntColumn get fatherCloudId => integer().nullable()();

  IntColumn get childId => integer().nullable()();

  IntColumn get childCloudId => integer().nullable()();
}
