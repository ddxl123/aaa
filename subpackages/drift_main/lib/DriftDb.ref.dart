// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

Future<void> withRefs(Ref ref) async {
  await ref._run();
}

abstract class Ref {
  Future<void> _run();
}

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

class RefFragments extends Ref {
  Future<void> Function($FragmentsTable table) self;
  RefFragments? child_fragments;
  RefFragmentPermanentMemoryInfos? fragmentPermanentMemoryInfos;
  RefRFragment2FragmentGroups? rFragment2FragmentGroups;
  RefRFragment2MemoryGroups? rFragment2MemoryGroups;
  RefRAssistedMemory2Fragments? rAssistedMemory2Fragments_1;
  RefRAssistedMemory2Fragments? rAssistedMemory2Fragments_2;

  RefFragments({
    required this.self,
    required this.child_fragments,
    required this.fragmentPermanentMemoryInfos,
    required this.rFragment2FragmentGroups,
    required this.rFragment2MemoryGroups,
    required this.rAssistedMemory2Fragments_1,
    required this.rAssistedMemory2Fragments_2,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.fragments);
    await child_fragments?._run();
    await fragmentPermanentMemoryInfos?._run();
    await rFragment2FragmentGroups?._run();
    await rFragment2MemoryGroups?._run();
    await rAssistedMemory2Fragments_1?._run();
    await rAssistedMemory2Fragments_2?._run();
  }
}

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

class RefMemoryModels extends Ref {
  Future<void> Function($MemoryModelsTable table) self;
  RefMemoryGroups? memoryGroups;
  RefFragmentPermanentMemoryInfos? fragmentPermanentMemoryInfos;

  RefMemoryModels({
    required this.self,
    required this.memoryGroups,
    required this.fragmentPermanentMemoryInfos,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.memoryModels);
    await memoryGroups?._run();
    await fragmentPermanentMemoryInfos?._run();
  }
}

class RefMemoryGroups extends Ref {
  Future<void> Function($MemoryGroupsTable table) self;
  RefFragmentPermanentMemoryInfos? fragmentPermanentMemoryInfos;
  RefRFragment2MemoryGroups? rFragment2MemoryGroups;

  RefMemoryGroups({
    required this.self,
    required this.fragmentPermanentMemoryInfos,
    required this.rFragment2MemoryGroups,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.memoryGroups);
    await fragmentPermanentMemoryInfos?._run();
    await rFragment2MemoryGroups?._run();
  }
}

class RefFragmentPermanentMemoryInfos extends Ref {
  Future<void> Function($FragmentPermanentMemoryInfosTable table) self;

  RefFragmentPermanentMemoryInfos({
    required this.self,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.fragmentPermanentMemoryInfos);
  }
}

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
