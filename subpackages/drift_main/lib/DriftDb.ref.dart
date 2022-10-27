// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

/// 增删改时，必须用这个函数。
///
/// 增：[withRefs] + [DriftSyncExt.insertReturningWith]
/// 删：[withRefs] + [DriftSyncExt.deleteWith]
/// 改：[withRefs] + [UserExt.reset]
Future<void> withRefs({
  required SyncTag? syncTag,
  required FutureOr<Ref> Function(SyncTag syncTag) ref,
}) async {
  await DriftDb.instance.transaction(
    () async {
      final internalSyncTag = await SyncTag.create();
      await (await ref(syncTag ?? internalSyncTag))._run();
    },
  );
}

abstract class Ref {
  Future<void> _run();
}

/// [Users]
class RefUsers extends Ref {
  Future<void> Function($UsersTable table) self;

  RefUsers({
    required this.self,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.users);
  }
}

/// [Fragments]
class RefFragments extends Ref {
  Future<void> Function($FragmentsTable table) self;
  RefFragments? child_fragments;
  RefFragmentMemoryInfos? fragmentMemoryInfos;
  RefRFragment2FragmentGroups? rFragment2FragmentGroups;
  RefRFragment2MemoryGroups? rFragment2MemoryGroups;
  RefRAssistedMemory2Fragments? rAssistedMemory2Fragments_1;
  RefRAssistedMemory2Fragments? rAssistedMemory2Fragments_2;

  RefFragments({
    required this.self,
    required this.child_fragments,
    required this.fragmentMemoryInfos,
    required this.rFragment2FragmentGroups,
    required this.rFragment2MemoryGroups,
    required this.rAssistedMemory2Fragments_1,
    required this.rAssistedMemory2Fragments_2,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.fragments);
    await child_fragments?._run();
    await fragmentMemoryInfos?._run();
    await rFragment2FragmentGroups?._run();
    await rFragment2MemoryGroups?._run();
    await rAssistedMemory2Fragments_1?._run();
    await rAssistedMemory2Fragments_2?._run();
  }
}

/// [FragmentGroups]
class RefFragmentGroups extends Ref {
  Future<void> Function($FragmentGroupsTable table) self;
  RefFragmentGroups? child_fragmentGroups;
  RefRFragment2FragmentGroups? rFragment2FragmentGroups;

  RefFragmentGroups({
    required this.self,
    required this.child_fragmentGroups,
    required this.rFragment2FragmentGroups,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.fragmentGroups);
    await child_fragmentGroups?._run();
    await rFragment2FragmentGroups?._run();
  }
}

/// [MemoryModels]
class RefMemoryModels extends Ref {
  Future<void> Function($MemoryModelsTable table) self;
  RefMemoryGroups? memoryGroups;

  RefMemoryModels({
    required this.self,
    required this.memoryGroups,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.memoryModels);
    await memoryGroups?._run();
  }
}

/// [MemoryGroups]
class RefMemoryGroups extends Ref {
  Future<void> Function($MemoryGroupsTable table) self;
  RefFragmentMemoryInfos? fragmentMemoryInfos;
  RefRFragment2MemoryGroups? rFragment2MemoryGroups;

  RefMemoryGroups({
    required this.self,
    required this.fragmentMemoryInfos,
    required this.rFragment2MemoryGroups,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.memoryGroups);
    await fragmentMemoryInfos?._run();
    await rFragment2MemoryGroups?._run();
  }
}

/// [FragmentMemoryInfos]
class RefFragmentMemoryInfos extends Ref {
  Future<void> Function($FragmentMemoryInfosTable table) self;

  RefFragmentMemoryInfos({
    required this.self,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.fragmentMemoryInfos);
  }
}

/// [RFragment2FragmentGroups]
class RefRFragment2FragmentGroups extends Ref {
  Future<void> Function($RFragment2FragmentGroupsTable table) self;

  RefRFragment2FragmentGroups({
    required this.self,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.rFragment2FragmentGroups);
  }
}

/// [RFragment2MemoryGroups]
class RefRFragment2MemoryGroups extends Ref {
  Future<void> Function($RFragment2MemoryGroupsTable table) self;

  RefRFragment2MemoryGroups({
    required this.self,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.rFragment2MemoryGroups);
  }
}

/// [RAssistedMemory2Fragments]
class RefRAssistedMemory2Fragments extends Ref {
  Future<void> Function($RAssistedMemory2FragmentsTable table) self;

  RefRAssistedMemory2Fragments({
    required this.self,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.rAssistedMemory2Fragments);
  }
}

/// [AppInfos]
class RefAppInfos extends Ref {
  Future<void> Function($AppInfosTable table) self;

  RefAppInfos({
    required this.self,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.appInfos);
  }
}
