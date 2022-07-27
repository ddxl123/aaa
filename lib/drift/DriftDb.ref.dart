// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

class WithRefs {
  static Future<void> users({
    required Future<void> Function(TableInfo table) users,
  }) async {
    await users(DriftDb.instance.users);
  }

  static Future<void> fragments({
    required Future<void> Function(TableInfo table) fragments,
    required Future<void> Function(TableInfo table) child_fragments,
    required Future<void> Function(TableInfo table)
        fragmentTemporaryMemoryInfo2,
    required Future<void> Function(TableInfo table) rFragment2FragmentGroups,
    required Future<void> Function(TableInfo table) rFragment2MemoryGroups,
  }) async {
    await fragments(DriftDb.instance.fragments);
    await child_fragments(DriftDb.instance.fragments);
    await fragmentTemporaryMemoryInfo2(
        DriftDb.instance.fragmentTemporaryMemoryInfo2);
    await rFragment2FragmentGroups(DriftDb.instance.rFragment2FragmentGroups);
    await rFragment2MemoryGroups(DriftDb.instance.rFragment2MemoryGroups);
  }

  static Future<void> fragmentGroups({
    required Future<void> Function(TableInfo table) fragmentGroups,
    required Future<void> Function(TableInfo table) child_fragmentGroups,
    required Future<void> Function(TableInfo table) rFragment2FragmentGroups,
  }) async {
    await fragmentGroups(DriftDb.instance.fragmentGroups);
    await child_fragmentGroups(DriftDb.instance.fragmentGroups);
    await rFragment2FragmentGroups(DriftDb.instance.rFragment2FragmentGroups);
  }

  static Future<void> memoryGroups({
    required Future<void> Function(TableInfo table) memoryGroups,
    required Future<void> Function(TableInfo table)
        fragmentTemporaryMemoryInfo2,
    required Future<void> Function(TableInfo table) rFragment2MemoryGroups,
    required Future<void> Function(TableInfo table) rMemoryModel2MemoryGroups,
  }) async {
    await memoryGroups(DriftDb.instance.memoryGroups);
    await fragmentTemporaryMemoryInfo2(
        DriftDb.instance.fragmentTemporaryMemoryInfo2);
    await rFragment2MemoryGroups(DriftDb.instance.rFragment2MemoryGroups);
    await rMemoryModel2MemoryGroups(DriftDb.instance.rMemoryModel2MemoryGroups);
  }

  static Future<void> memoryModels({
    required Future<void> Function(TableInfo table) memoryModels,
    required Future<void> Function(TableInfo table) rMemoryModel2MemoryGroups,
  }) async {
    await memoryModels(DriftDb.instance.memoryModels);
    await rMemoryModel2MemoryGroups(DriftDb.instance.rMemoryModel2MemoryGroups);
  }

  static Future<void> fragmentPermanentMemoryInfos({
    required Future<void> Function(TableInfo table)
        fragmentPermanentMemoryInfos,
  }) async {
    await fragmentPermanentMemoryInfos(
        DriftDb.instance.fragmentPermanentMemoryInfos);
  }

  static Future<void> fragmentTemporaryMemoryInfo2({
    required Future<void> Function(TableInfo table)
        fragmentTemporaryMemoryInfo2,
  }) async {
    await fragmentTemporaryMemoryInfo2(
        DriftDb.instance.fragmentTemporaryMemoryInfo2);
  }

  static Future<void> rFragment2FragmentGroups({
    required Future<void> Function(TableInfo table) rFragment2FragmentGroups,
  }) async {
    await rFragment2FragmentGroups(DriftDb.instance.rFragment2FragmentGroups);
  }

  static Future<void> rFragment2MemoryGroups({
    required Future<void> Function(TableInfo table) rFragment2MemoryGroups,
  }) async {
    await rFragment2MemoryGroups(DriftDb.instance.rFragment2MemoryGroups);
  }

  static Future<void> rMemoryModel2MemoryGroups({
    required Future<void> Function(TableInfo table) rMemoryModel2MemoryGroups,
  }) async {
    await rMemoryModel2MemoryGroups(DriftDb.instance.rMemoryModel2MemoryGroups);
  }

  static Future<void> appInfos({
    required Future<void> Function(TableInfo table) appInfos,
  }) async {
    await appInfos(DriftDb.instance.appInfos);
  }
}
