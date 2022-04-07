import 'package:drift/drift.dart';

import 'Base.dart';

class Users extends TableCloudBase {
  TextColumn get username => text().nullable()();

  TextColumn get password => text().nullable()();

  TextColumn get email => text().nullable()();

  IntColumn get age => integer().nullable()();
}

class FragmentGroups extends TableCloudBase {
  TextColumn get name => text().nullable()();

  IntColumn get fatherFragmentGroupId => integer().nullable()();

  IntColumn get fatherFragmentGroupCloudId => integer().nullable()();
}

class Fragments extends TableCloudBase {
  /// part1 为外显文本。
  TextColumn get part1 => text().nullable()();

  TextColumn get part2 => text().nullable()();

  TextColumn get part3 => text().nullable()();

  TextColumn get part4 => text().nullable()();

  TextColumn get part5 => text().nullable()();
}

/// [Fragments] 与 [FragmentGroups]
class RFragment2FragmentGroups extends TableCloudBase {
  IntColumn get fFragmentId => integer().nullable()();

  IntColumn get fFragmentCloudId => integer().nullable()();

  IntColumn get fFragmentGroupId => integer().nullable()();

  IntColumn get fFragmentGroupCloudId => integer().nullable()();
}

class MemoryGroup extends TableCloudBase {
  TextColumn get name => text().nullable()();
}

/// [Fragments] 与 [MemoryGroup]
class RFragment2MemoryGroup extends TableCloudBase {
  IntColumn get fFragmentId => integer().nullable()();

  IntColumn get fFragmentCloudId => integer().nullable()();

  IntColumn get fMemoryGroupId => integer().nullable()();

  IntColumn get fMemoryGroupCloudId => integer().nullable()();
}
