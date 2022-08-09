// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

class WithRefs {
  static Future<void> users(
    Future<void> Function($UsersTable table) users,
  ) async {
    await users(DriftDb.instance.users);
  }

  static Future<void> fragments(
    Future<void> Function($FragmentsTable table) fragments, {
    required Future<void> Function($FragmentsTable table)? child_fragments,
    required Future<void> Function($FragmentPermanentMemoryInfosTable table)?
        fragmentPermanentMemoryInfos,
    required Future<void> Function($RFragment2FragmentGroupsTable table)?
        rFragment2FragmentGroups,
    required Future<void> Function($RFragment2MemoryGroupsTable table)?
        rFragment2MemoryGroups,
    required Future<void> Function(
            $RAssistedMemoryFragment2FragmentTable table)?
        rAssistedMemoryFragment2Fragment_1,
    required Future<void> Function(
            $RAssistedMemoryFragment2FragmentTable table)?
        rAssistedMemoryFragment2Fragment_2,
  }) async {
    await fragments(DriftDb.instance.fragments);
    await child_fragments?.call(DriftDb.instance.fragments);
    await fragmentPermanentMemoryInfos
        ?.call(DriftDb.instance.fragmentPermanentMemoryInfos);
    await rFragment2FragmentGroups
        ?.call(DriftDb.instance.rFragment2FragmentGroups);
    await rFragment2MemoryGroups?.call(DriftDb.instance.rFragment2MemoryGroups);
    await rAssistedMemoryFragment2Fragment_1
        ?.call(DriftDb.instance.rAssistedMemoryFragment2Fragment);
    await rAssistedMemoryFragment2Fragment_2
        ?.call(DriftDb.instance.rAssistedMemoryFragment2Fragment);
  }

  static Future<void> fragmentGroups(
    Future<void> Function($FragmentGroupsTable table) fragmentGroups, {
    required Future<void> Function($FragmentGroupsTable table)?
        child_fragmentGroups,
    required Future<void> Function($RFragment2FragmentGroupsTable table)?
        rFragment2FragmentGroups,
  }) async {
    await fragmentGroups(DriftDb.instance.fragmentGroups);
    await child_fragmentGroups?.call(DriftDb.instance.fragmentGroups);
    await rFragment2FragmentGroups
        ?.call(DriftDb.instance.rFragment2FragmentGroups);
  }

  static Future<void> memoryGroups(
    Future<void> Function($MemoryGroupsTable table) memoryGroups, {
    required Future<void> Function($FragmentPermanentMemoryInfosTable table)?
        fragmentPermanentMemoryInfos,
    required Future<void> Function($RFragment2MemoryGroupsTable table)?
        rFragment2MemoryGroups,
    required Future<void> Function($RMemoryModel2MemoryGroupsTable table)?
        rMemoryModel2MemoryGroups,
  }) async {
    await memoryGroups(DriftDb.instance.memoryGroups);
    await fragmentPermanentMemoryInfos
        ?.call(DriftDb.instance.fragmentPermanentMemoryInfos);
    await rFragment2MemoryGroups?.call(DriftDb.instance.rFragment2MemoryGroups);
    await rMemoryModel2MemoryGroups
        ?.call(DriftDb.instance.rMemoryModel2MemoryGroups);
  }

  static Future<void> memoryModels(
    Future<void> Function($MemoryModelsTable table) memoryModels, {
    required Future<void> Function($FragmentPermanentMemoryInfosTable table)?
        fragmentPermanentMemoryInfos,
    required Future<void> Function($RMemoryModel2MemoryGroupsTable table)?
        rMemoryModel2MemoryGroups,
  }) async {
    await memoryModels(DriftDb.instance.memoryModels);
    await fragmentPermanentMemoryInfos
        ?.call(DriftDb.instance.fragmentPermanentMemoryInfos);
    await rMemoryModel2MemoryGroups
        ?.call(DriftDb.instance.rMemoryModel2MemoryGroups);
  }

  static Future<void> fragmentPermanentMemoryInfos(
    Future<void> Function($FragmentPermanentMemoryInfosTable table)
        fragmentPermanentMemoryInfos,
  ) async {
    await fragmentPermanentMemoryInfos(
        DriftDb.instance.fragmentPermanentMemoryInfos);
  }

  static Future<void> rFragment2FragmentGroups(
    Future<void> Function($RFragment2FragmentGroupsTable table)
        rFragment2FragmentGroups,
  ) async {
    await rFragment2FragmentGroups(DriftDb.instance.rFragment2FragmentGroups);
  }

  static Future<void> rFragment2MemoryGroups(
    Future<void> Function($RFragment2MemoryGroupsTable table)
        rFragment2MemoryGroups,
  ) async {
    await rFragment2MemoryGroups(DriftDb.instance.rFragment2MemoryGroups);
  }

  static Future<void> rMemoryModel2MemoryGroups(
    Future<void> Function($RMemoryModel2MemoryGroupsTable table)
        rMemoryModel2MemoryGroups,
  ) async {
    await rMemoryModel2MemoryGroups(DriftDb.instance.rMemoryModel2MemoryGroups);
  }

  static Future<void> rAssistedMemoryFragment2Fragment(
    Future<void> Function($RAssistedMemoryFragment2FragmentTable table)
        rAssistedMemoryFragment2Fragment,
  ) async {
    await rAssistedMemoryFragment2Fragment(
        DriftDb.instance.rAssistedMemoryFragment2Fragment);
  }

  static Future<void> appInfos(
    Future<void> Function($AppInfosTable table) appInfos,
  ) async {
    await appInfos(DriftDb.instance.appInfos);
  }
}
