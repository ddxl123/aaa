part of drift_db;

/// 该文件全是关联表。

const List<Type> rTableClass = [
  RFragment2FragmentGroups,
  RFragment2MemoryGroups,
  RAssistedMemory2Fragments,
];

/// 碎片存放于碎片组内
@ReferenceTo([Fragments, FragmentGroups])
class RFragment2FragmentGroups extends RCloudTableBase {}

/// 碎片存放于记忆组内
@ReferenceTo([Fragments, MemoryGroups])
class RFragment2MemoryGroups extends RCloudTableBase {}

/// 辅记碎片所服务的主碎片
@ReferenceTo([Fragments, Fragments])
class RAssistedMemory2Fragments extends RCloudTableBase {}
