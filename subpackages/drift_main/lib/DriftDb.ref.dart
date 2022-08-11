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
    await DriftDb.instance.transaction(
      () async {
        await users(DriftDb.instance.users);
      },
    );
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
    required Future<void> Function($RAssistedMemory2FragmentsTable table)?
        rAssistedMemory2Fragments_1,
    required Future<void> Function($RAssistedMemory2FragmentsTable table)?
        rAssistedMemory2Fragments_2,
  }) async {
    await DriftDb.instance.transaction(
      () async {
        await fragments(DriftDb.instance.fragments);
        await child_fragments?.call(DriftDb.instance.fragments);
        await fragmentPermanentMemoryInfos
            ?.call(DriftDb.instance.fragmentPermanentMemoryInfos);
        await rFragment2FragmentGroups
            ?.call(DriftDb.instance.rFragment2FragmentGroups);
        await rFragment2MemoryGroups
            ?.call(DriftDb.instance.rFragment2MemoryGroups);
        await rAssistedMemory2Fragments_1
            ?.call(DriftDb.instance.rAssistedMemory2Fragments);
        await rAssistedMemory2Fragments_2
            ?.call(DriftDb.instance.rAssistedMemory2Fragments);
      },
    );
  }

  static Future<void> fragmentGroups(
    Future<void> Function($FragmentGroupsTable table) fragmentGroups, {
    required Future<void> Function($FragmentGroupsTable table)?
        child_fragmentGroups,
    required Future<void> Function($RFragment2FragmentGroupsTable table)?
        rFragment2FragmentGroups,
  }) async {
    await DriftDb.instance.transaction(
      () async {
        await fragmentGroups(DriftDb.instance.fragmentGroups);
        await child_fragmentGroups?.call(DriftDb.instance.fragmentGroups);
        await rFragment2FragmentGroups
            ?.call(DriftDb.instance.rFragment2FragmentGroups);
      },
    );
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
    await DriftDb.instance.transaction(
      () async {
        await memoryGroups(DriftDb.instance.memoryGroups);
        await fragmentPermanentMemoryInfos
            ?.call(DriftDb.instance.fragmentPermanentMemoryInfos);
        await rFragment2MemoryGroups
            ?.call(DriftDb.instance.rFragment2MemoryGroups);
        await rMemoryModel2MemoryGroups
            ?.call(DriftDb.instance.rMemoryModel2MemoryGroups);
      },
    );
  }

  static Future<void> memoryModels(
    Future<void> Function($MemoryModelsTable table) memoryModels, {
    required Future<void> Function($FragmentPermanentMemoryInfosTable table)?
        fragmentPermanentMemoryInfos,
    required Future<void> Function($RMemoryModel2MemoryGroupsTable table)?
        rMemoryModel2MemoryGroups,
  }) async {
    await DriftDb.instance.transaction(
      () async {
        await memoryModels(DriftDb.instance.memoryModels);
        await fragmentPermanentMemoryInfos
            ?.call(DriftDb.instance.fragmentPermanentMemoryInfos);
        await rMemoryModel2MemoryGroups
            ?.call(DriftDb.instance.rMemoryModel2MemoryGroups);
      },
    );
  }

  static Future<void> fragmentPermanentMemoryInfos(
    Future<void> Function($FragmentPermanentMemoryInfosTable table)
        fragmentPermanentMemoryInfos,
  ) async {
    await DriftDb.instance.transaction(
      () async {
        await fragmentPermanentMemoryInfos(
            DriftDb.instance.fragmentPermanentMemoryInfos);
      },
    );
  }

  static Future<void> rFragment2FragmentGroups(
    Future<void> Function($RFragment2FragmentGroupsTable table)
        rFragment2FragmentGroups,
  ) async {
    await DriftDb.instance.transaction(
      () async {
        await rFragment2FragmentGroups(
            DriftDb.instance.rFragment2FragmentGroups);
      },
    );
  }

  static Future<void> rFragment2MemoryGroups(
    Future<void> Function($RFragment2MemoryGroupsTable table)
        rFragment2MemoryGroups,
  ) async {
    await DriftDb.instance.transaction(
      () async {
        await rFragment2MemoryGroups(DriftDb.instance.rFragment2MemoryGroups);
      },
    );
  }

  static Future<void> rMemoryModel2MemoryGroups(
    Future<void> Function($RMemoryModel2MemoryGroupsTable table)
        rMemoryModel2MemoryGroups,
  ) async {
    await DriftDb.instance.transaction(
      () async {
        await rMemoryModel2MemoryGroups(
            DriftDb.instance.rMemoryModel2MemoryGroups);
      },
    );
  }

  static Future<void> rAssistedMemory2Fragments(
    Future<void> Function($RAssistedMemory2FragmentsTable table)
        rAssistedMemory2Fragments,
  ) async {
    await DriftDb.instance.transaction(
      () async {
        await rAssistedMemory2Fragments(
            DriftDb.instance.rAssistedMemory2Fragments);
      },
    );
  }

  static Future<void> appInfos(
    Future<void> Function($AppInfosTable table) appInfos,
  ) async {
    await DriftDb.instance.transaction(
      () async {
        await appInfos(DriftDb.instance.appInfos);
      },
    );
  }
}
