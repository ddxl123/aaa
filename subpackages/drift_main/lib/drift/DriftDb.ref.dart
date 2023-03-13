// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

abstract class Ref {
  Ref({required this.order});

  final int order;

  Future<void> run();
}

/// [KnowledgeBaseCategorys]
class RefKnowledgeBaseCategorys extends Ref {
  Future<void> Function() self;

  RefKnowledgeBaseCategorys({
    required this.self,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [ClientSyncInfos]
class RefClientSyncInfos extends Ref {
  Future<void> Function() self;

  RefClientSyncInfos({
    required this.self,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [Syncs]
class RefSyncs extends Ref {
  Future<void> Function() self;

  RefSyncs({
    required this.self,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [Users]
class RefUsers extends Ref {
  Future<void> Function() self;
  RefFragmentMemoryInfos? fragmentMemoryInfos;
  RefRDocument2DocumentGroups? rDocument2DocumentGroups;
  RefRFragment2FragmentGroups? rFragment2FragmentGroups;
  RefRNote2NoteGroups? rNote2NoteGroups;
  RefDocuments? documents;
  RefFragmentTemplates? fragmentTemplates;
  RefFragments? fragments;
  RefMemoryGroups? memoryGroups;
  RefMemoryModels? memoryModels;
  RefNotes? notes;
  RefShorthands? shorthands;
  RefDocumentGroups? documentGroups;
  RefFragmentGroups? fragmentGroups;
  RefNoteGroups? noteGroups;
  RefUserComments? userComments;
  RefUserLikes? userLikes;

  RefUsers({
    required this.self,
    required this.fragmentMemoryInfos,
    required this.rDocument2DocumentGroups,
    required this.rFragment2FragmentGroups,
    required this.rNote2NoteGroups,
    required this.documents,
    required this.fragmentTemplates,
    required this.fragments,
    required this.memoryGroups,
    required this.memoryModels,
    required this.notes,
    required this.shorthands,
    required this.documentGroups,
    required this.fragmentGroups,
    required this.noteGroups,
    required this.userComments,
    required this.userLikes,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
          fragmentMemoryInfos,
          rDocument2DocumentGroups,
          rFragment2FragmentGroups,
          rNote2NoteGroups,
          documents,
          fragmentTemplates,
          fragments,
          memoryGroups,
          memoryModels,
          notes,
          shorthands,
          documentGroups,
          fragmentGroups,
          noteGroups,
          userComments,
          userLikes,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [Fragments]
class RefFragments extends Ref {
  Future<void> Function() self;
  RefFragmentMemoryInfos? fragmentMemoryInfos;
  RefRFragment2FragmentGroups? rFragment2FragmentGroups;
  RefFragments? child_fragments;
  RefMemoryModels? memoryModels;
  RefUserComments? userComments;
  RefUserLikes? userLikes;

  RefFragments({
    required this.self,
    required this.fragmentMemoryInfos,
    required this.rFragment2FragmentGroups,
    required this.child_fragments,
    required this.memoryModels,
    required this.userComments,
    required this.userLikes,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
          fragmentMemoryInfos,
          rFragment2FragmentGroups,
          child_fragments,
          memoryModels,
          userComments,
          userLikes,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [MemoryGroups]
class RefMemoryGroups extends Ref {
  Future<void> Function() self;
  RefFragmentMemoryInfos? fragmentMemoryInfos;

  RefMemoryGroups({
    required this.self,
    required this.fragmentMemoryInfos,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
          fragmentMemoryInfos,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [FragmentMemoryInfos]
class RefFragmentMemoryInfos extends Ref {
  Future<void> Function() self;
  RefMemoryGroups? memoryGroups;

  RefFragmentMemoryInfos({
    required this.self,
    required this.memoryGroups,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
          memoryGroups,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [DocumentGroups]
class RefDocumentGroups extends Ref {
  Future<void> Function() self;
  RefRDocument2DocumentGroups? rDocument2DocumentGroups;
  RefDocumentGroups? child_documentGroups;

  RefDocumentGroups({
    required this.self,
    required this.rDocument2DocumentGroups,
    required this.child_documentGroups,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
          rDocument2DocumentGroups,
          child_documentGroups,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [Documents]
class RefDocuments extends Ref {
  Future<void> Function() self;
  RefRDocument2DocumentGroups? rDocument2DocumentGroups;
  RefNotes? notes;

  RefDocuments({
    required this.self,
    required this.rDocument2DocumentGroups,
    required this.notes,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
          rDocument2DocumentGroups,
          notes,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [RDocument2DocumentGroups]
class RefRDocument2DocumentGroups extends Ref {
  Future<void> Function() self;

  RefRDocument2DocumentGroups({
    required this.self,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [FragmentGroups]
class RefFragmentGroups extends Ref {
  Future<void> Function() self;
  RefRFragment2FragmentGroups? rFragment2FragmentGroups;
  RefFragmentGroups? child_fragmentGroups;
  RefUserComments? userComments;
  RefUserLikes? userLikes;

  RefFragmentGroups({
    required this.self,
    required this.rFragment2FragmentGroups,
    required this.child_fragmentGroups,
    required this.userComments,
    required this.userLikes,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
          rFragment2FragmentGroups,
          child_fragmentGroups,
          userComments,
          userLikes,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [RFragment2FragmentGroups]
class RefRFragment2FragmentGroups extends Ref {
  Future<void> Function() self;

  RefRFragment2FragmentGroups({
    required this.self,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [NoteGroups]
class RefNoteGroups extends Ref {
  Future<void> Function() self;
  RefRNote2NoteGroups? rNote2NoteGroups;
  RefNoteGroups? child_noteGroups;

  RefNoteGroups({
    required this.self,
    required this.rNote2NoteGroups,
    required this.child_noteGroups,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
          rNote2NoteGroups,
          child_noteGroups,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [Notes]
class RefNotes extends Ref {
  Future<void> Function() self;
  RefRNote2NoteGroups? rNote2NoteGroups;
  RefFragments? fragments;
  RefNotes? child_notes;

  RefNotes({
    required this.self,
    required this.rNote2NoteGroups,
    required this.fragments,
    required this.child_notes,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
          rNote2NoteGroups,
          fragments,
          child_notes,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [RNote2NoteGroups]
class RefRNote2NoteGroups extends Ref {
  Future<void> Function() self;

  RefRNote2NoteGroups({
    required this.self,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [Test2s]
class RefTest2s extends Ref {
  Future<void> Function() self;

  RefTest2s({
    required this.self,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [Tests]
class RefTests extends Ref {
  Future<void> Function() self;

  RefTests({
    required this.self,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [FragmentTemplates]
class RefFragmentTemplates extends Ref {
  Future<void> Function() self;
  RefFragments? fragments;

  RefFragmentTemplates({
    required this.self,
    required this.fragments,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
          fragments,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [MemoryModels]
class RefMemoryModels extends Ref {
  Future<void> Function() self;
  RefMemoryGroups? memoryGroups;

  RefMemoryModels({
    required this.self,
    required this.memoryGroups,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
          memoryGroups,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [Shorthands]
class RefShorthands extends Ref {
  Future<void> Function() self;

  RefShorthands({
    required this.self,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [UserComments]
class RefUserComments extends Ref {
  Future<void> Function() self;

  RefUserComments({
    required this.self,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}

/// [UserLikes]
class RefUserLikes extends Ref {
  Future<void> Function() self;

  RefUserLikes({
    required this.self,
    required super.order,
  });

  @override
  Future<void> run() async {
    await DriftDb.instance.transaction(
      () async {
        final list = <Ref?>[
          this,
        ]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
        await Future.forEach<Ref?>(
          list,
          (element) async {
            if (element == this) {
              await self();
            } else {
              await element?.run();
            }
          },
        );
      },
    );
  }
}
