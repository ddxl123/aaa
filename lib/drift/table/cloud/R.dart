import 'package:aaa/drift/DriftDb.dart';
import 'package:drift/drift.dart';

/// 该文件全是关联表。

const List<Type> rTableClass = [
  RFragment2FragmentGroups,
  RFragment2MemoryGroups,
];

/// [Fragments]2[FragmentGroups]
class RFragment2FragmentGroups extends CloudRTableBase {}

/// [Fragments]2[MemoryGroups]
class RFragment2MemoryGroups extends CloudRTableBase {}
