part of drift_db;

/// 该文件全是关联表。

const List<Type> rTableClass = [
  RFragment2FragmentGroups,
  RFragment2MemoryGroups,
  RMemoryModel2MemoryGroups,
];

/// [Fragments]2[FragmentGroups]
class RFragment2FragmentGroups extends RCloudTableBase {}

/// [Fragments]2[MemoryGroups]
class RFragment2MemoryGroups extends RCloudTableBase {}

/// [MemoryModels]2[MemoryGroups]
class RMemoryModel2MemoryGroups extends RCloudTableBase {}
