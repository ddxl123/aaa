// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

/// 增删改时，必须用这个函数。
///
/// 增：[withRefs] + [Crt] 和 [UsersCompanionExt]
/// 删：[withRefs] + [DriftSyncExt.deleteWith]
/// 改：[withRefs] + [UserExt.reset]
///
/// [syncTag] - 若为null，则内部会自动创建一个事务。
Future<void> withRefs({
  required SyncTag? syncTag,
  required Future<Ref> Function(SyncTag syncTag) ref,
}) async {
  await DriftDb.instance.transaction(
    () async {
      await (await ref(syncTag ?? await SyncTag.create()))._run();
    },
  );
}

abstract class Ref {
  Future<void> _run();
}

/// [Users]
class RefUsers extends Ref {
  Future<void> Function($UsersTable table) self;
  RefFragmentMemoryInfos? fragmentMemoryInfos;
  RefMemoryGroups? memoryGroups;
  RefRDocument2DocumentGroups? rDocument2DocumentGroups;
  RefRFragment2FragmentGroups? rFragment2FragmentGroups;
  RefRMemoryModel2MemoryModelGroups? rMemoryModel2MemoryModelGroups;
  RefRNote2NoteGroups? rNote2NoteGroups;
  RefDocuments? documents;
  RefFragments? fragments;
  RefMemoryModels? memoryModels;
  RefNotes? notes;
  RefDocumentGroups? documentGroups;
  RefFragmentGroups? fragmentGroups;
  RefMemoryModelGroups? memoryModelGroups;
  RefNoteGroups? noteGroups;

  RefUsers({
    required this.self,
    required this.fragmentMemoryInfos,
    required this.memoryGroups,
    required this.rDocument2DocumentGroups,
    required this.rFragment2FragmentGroups,
    required this.rMemoryModel2MemoryModelGroups,
    required this.rNote2NoteGroups,
    required this.documents,
    required this.fragments,
    required this.memoryModels,
    required this.notes,
    required this.documentGroups,
    required this.fragmentGroups,
    required this.memoryModelGroups,
    required this.noteGroups,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.users);
    await fragmentMemoryInfos?._run();
    await memoryGroups?._run();
    await rDocument2DocumentGroups?._run();
    await rFragment2FragmentGroups?._run();
    await rMemoryModel2MemoryModelGroups?._run();
    await rNote2NoteGroups?._run();
    await documents?._run();
    await fragments?._run();
    await memoryModels?._run();
    await notes?._run();
    await documentGroups?._run();
    await fragmentGroups?._run();
    await memoryModelGroups?._run();
    await noteGroups?._run();
  }
}

/// [Fragments]
class RefFragments extends Ref {
  Future<void> Function($FragmentsTable table) self;
  RefFragmentMemoryInfos? fragmentMemoryInfos;
  RefRFragment2FragmentGroups? rFragment2FragmentGroups;
  RefFragments? child_fragments;
  RefMemoryModels? memoryModels;

  RefFragments({
    required this.self,
    required this.fragmentMemoryInfos,
    required this.rFragment2FragmentGroups,
    required this.child_fragments,
    required this.memoryModels,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.fragments);
    await fragmentMemoryInfos?._run();
    await rFragment2FragmentGroups?._run();
    await child_fragments?._run();
    await memoryModels?._run();
  }
}

/// [MemoryGroups]
class RefMemoryGroups extends Ref {
  Future<void> Function($MemoryGroupsTable table) self;
  RefFragmentMemoryInfos? fragmentMemoryInfos;

  RefMemoryGroups({
    required this.self,
    required this.fragmentMemoryInfos,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.memoryGroups);
    await fragmentMemoryInfos?._run();
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

/// [Syncs]
class RefSyncs extends Ref {
  Future<void> Function($SyncsTable table) self;

  RefSyncs({
    required this.self,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.syncs);
  }
}

/// [MemoryModels]
class RefMemoryModels extends Ref {
  Future<void> Function($MemoryModelsTable table) self;
  RefMemoryGroups? memoryGroups;
  RefRMemoryModel2MemoryModelGroups? rMemoryModel2MemoryModelGroups;

  RefMemoryModels({
    required this.self,
    required this.memoryGroups,
    required this.rMemoryModel2MemoryModelGroups,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.memoryModels);
    await memoryGroups?._run();
    await rMemoryModel2MemoryModelGroups?._run();
  }
}

/// [DocumentGroups]
class RefDocumentGroups extends Ref {
  Future<void> Function($DocumentGroupsTable table) self;
  RefRDocument2DocumentGroups? rDocument2DocumentGroups;
  RefDocumentGroups? child_documentGroups;

  RefDocumentGroups({
    required this.self,
    required this.rDocument2DocumentGroups,
    required this.child_documentGroups,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.documentGroups);
    await rDocument2DocumentGroups?._run();
    await child_documentGroups?._run();
  }
}

/// [Documents]
class RefDocuments extends Ref {
  Future<void> Function($DocumentsTable table) self;
  RefRDocument2DocumentGroups? rDocument2DocumentGroups;
  RefNotes? notes;

  RefDocuments({
    required this.self,
    required this.rDocument2DocumentGroups,
    required this.notes,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.documents);
    await rDocument2DocumentGroups?._run();
    await notes?._run();
  }
}

/// [RDocument2DocumentGroups]
class RefRDocument2DocumentGroups extends Ref {
  Future<void> Function($RDocument2DocumentGroupsTable table) self;

  RefRDocument2DocumentGroups({
    required this.self,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.rDocument2DocumentGroups);
  }
}

/// [FragmentGroups]
class RefFragmentGroups extends Ref {
  Future<void> Function($FragmentGroupsTable table) self;
  RefRFragment2FragmentGroups? rFragment2FragmentGroups;
  RefFragmentGroups? child_fragmentGroups;

  RefFragmentGroups({
    required this.self,
    required this.rFragment2FragmentGroups,
    required this.child_fragmentGroups,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.fragmentGroups);
    await rFragment2FragmentGroups?._run();
    await child_fragmentGroups?._run();
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

/// [MemoryModelGroups]
class RefMemoryModelGroups extends Ref {
  Future<void> Function($MemoryModelGroupsTable table) self;
  RefRMemoryModel2MemoryModelGroups? rMemoryModel2MemoryModelGroups;
  RefMemoryModelGroups? child_memoryModelGroups;

  RefMemoryModelGroups({
    required this.self,
    required this.rMemoryModel2MemoryModelGroups,
    required this.child_memoryModelGroups,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.memoryModelGroups);
    await rMemoryModel2MemoryModelGroups?._run();
    await child_memoryModelGroups?._run();
  }
}

/// [RMemoryModel2MemoryModelGroups]
class RefRMemoryModel2MemoryModelGroups extends Ref {
  Future<void> Function($RMemoryModel2MemoryModelGroupsTable table) self;

  RefRMemoryModel2MemoryModelGroups({
    required this.self,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.rMemoryModel2MemoryModelGroups);
  }
}

/// [NoteGroups]
class RefNoteGroups extends Ref {
  Future<void> Function($NoteGroupsTable table) self;
  RefRNote2NoteGroups? rNote2NoteGroups;
  RefNoteGroups? child_noteGroups;

  RefNoteGroups({
    required this.self,
    required this.rNote2NoteGroups,
    required this.child_noteGroups,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.noteGroups);
    await rNote2NoteGroups?._run();
    await child_noteGroups?._run();
  }
}

/// [Notes]
class RefNotes extends Ref {
  Future<void> Function($NotesTable table) self;
  RefRNote2NoteGroups? rNote2NoteGroups;
  RefFragments? fragments;
  RefNotes? child_notes;

  RefNotes({
    required this.self,
    required this.rNote2NoteGroups,
    required this.fragments,
    required this.child_notes,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.notes);
    await rNote2NoteGroups?._run();
    await fragments?._run();
    await child_notes?._run();
  }
}

/// [RNote2NoteGroups]
class RefRNote2NoteGroups extends Ref {
  Future<void> Function($RNote2NoteGroupsTable table) self;

  RefRNote2NoteGroups({
    required this.self,
  });

  @override
  Future<void> _run() async {
    await self(DriftDb.instance.rNote2NoteGroups);
  }
}
