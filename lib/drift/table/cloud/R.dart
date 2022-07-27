part of drift_db;

/// 该文件全是关联表。

const List<Type> rTableClass = [
  RFragment2FragmentGroups,
  RFragment2MemoryGroups,
  RMemoryModel2MemoryGroups,
];

@ReferenceTo([Fragments, FragmentGroups])
class RFragment2FragmentGroups extends RCloudTableBase {}

@ReferenceTo([Fragments, MemoryGroups])
class RFragment2MemoryGroups extends RCloudTableBase {}

@ReferenceTo([MemoryModels, MemoryGroups])
class RMemoryModel2MemoryGroups extends RCloudTableBase {}
