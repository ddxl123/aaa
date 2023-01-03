// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// CrtGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

/// 这个类在创建表对象时，可以让每个 column 都能被编辑器提示，以防遗漏。
///
/// id createdAt updatedAt 已经在 [DriftSyncExt.insertReturningWith] 中自动更新了。
///
/// 使用方式查看 [withRefs]。
class Crt {
  Crt._();
  static UsersCompanion usersCompanion({
    required Value<int?> age,
    required Value<String?> email,
    required String local_token,
    required Value<String?> password,
    required Value<String?> phone,
    required String username,
  }) {
    return UsersCompanion(
      age: age,
      email: email,
      local_token: Value(local_token),
      password: password,
      phone: phone,
      username: Value(username),
    );
  }

  static FragmentMemoryInfosCompanion fragmentMemoryInfosCompanion({
    required Value<String?> clickTime,
    required Value<String?> clickValue,
    required int creatorUserId,
    required Value<String?> currentActualShowTime,
    required String fragmentId,
    required String memoryGroupId,
    required Value<String?> nextPlanShowTime,
    required Value<String?> showFamiliarity,
  }) {
    return FragmentMemoryInfosCompanion(
      clickTime: clickTime,
      clickValue: clickValue,
      creatorUserId: Value(creatorUserId),
      currentActualShowTime: currentActualShowTime,
      fragmentId: Value(fragmentId),
      memoryGroupId: Value(memoryGroupId),
      nextPlanShowTime: nextPlanShowTime,
      showFamiliarity: showFamiliarity,
    );
  }

  static SyncsCompanion syncsCompanion({
    required String rowId,
    required SyncCurdType syncCurdType,
    required String syncTableName,
    required int tag,
  }) {
    return SyncsCompanion(
      rowId: Value(rowId),
      syncCurdType: Value(syncCurdType),
      syncTableName: Value(syncTableName),
      tag: Value(tag),
    );
  }

  static RDocument2DocumentGroupsCompanion rDocument2DocumentGroupsCompanion({
    required int creatorUserId,
    required Value<String?> documentGroupId,
    required String documentId,
  }) {
    return RDocument2DocumentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      documentGroupId: documentGroupId,
      documentId: Value(documentId),
    );
  }

  static RFragment2FragmentGroupsCompanion rFragment2FragmentGroupsCompanion({
    required int creatorUserId,
    required Value<String?> fragmentGroupId,
    required String fragmentId,
  }) {
    return RFragment2FragmentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fragmentGroupId: fragmentGroupId,
      fragmentId: Value(fragmentId),
    );
  }

  static RNote2NoteGroupsCompanion rNote2NoteGroupsCompanion({
    required int creatorUserId,
    required Value<String?> noteGroupId,
    required String noteId,
  }) {
    return RNote2NoteGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      noteGroupId: noteGroupId,
      noteId: Value(noteId),
    );
  }

  static Test2sCompanion test2sCompanion({
    required String local_content,
  }) {
    return Test2sCompanion(
      local_content: Value(local_content),
    );
  }

  static TestsCompanion testsCompanion({
    required String local_content,
  }) {
    return TestsCompanion(
      local_content: Value(local_content),
    );
  }

  static ClientSyncInfosCompanion clientSyncInfosCompanion({
    required DateTime recentSyncTime,
  }) {
    return ClientSyncInfosCompanion(
      recentSyncTime: Value(recentSyncTime),
    );
  }

  static DocumentsCompanion documentsCompanion({
    required String content,
    required int creatorUserId,
  }) {
    return DocumentsCompanion(
      content: Value(content),
      creatorUserId: Value(creatorUserId),
    );
  }

  static FragmentTemplatesCompanion fragmentTemplatesCompanion({
    required String content,
    required int ownerUserId,
    required FragmentTemplateType type,
  }) {
    return FragmentTemplatesCompanion(
      content: Value(content),
      ownerUserId: Value(ownerUserId),
      type: Value(type),
    );
  }

  static FragmentsCompanion fragmentsCompanion({
    required String content,
    required int creatorUserId,
    required Value<String?> fatherFragmentId,
    required Value<String?> fragmentTemplateId,
    required bool local_be_Selected,
    required Value<String?> noteId,
    required String title,
  }) {
    return FragmentsCompanion(
      content: Value(content),
      creatorUserId: Value(creatorUserId),
      fatherFragmentId: fatherFragmentId,
      fragmentTemplateId: fragmentTemplateId,
      local_be_Selected: Value(local_be_Selected),
      noteId: noteId,
      title: Value(title),
    );
  }

  static MemoryGroupsCompanion memoryGroupsCompanion({
    required int creatorUserId,
    required Value<String?> memoryModelId,
    required NewDisplayOrder newDisplayOrder,
    required NewReviewDisplayOrder newReviewDisplayOrder,
    required DateTime reviewInterval,
    required Value<DateTime?> startTime,
    required String title,
    required int willNewLearnCount,
  }) {
    return MemoryGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      memoryModelId: memoryModelId,
      newDisplayOrder: Value(newDisplayOrder),
      newReviewDisplayOrder: Value(newReviewDisplayOrder),
      reviewInterval: Value(reviewInterval),
      startTime: startTime,
      title: Value(title),
      willNewLearnCount: Value(willNewLearnCount),
    );
  }

  static MemoryModelsCompanion memoryModelsCompanion({
    required String buttonAlgorithm,
    required int creatorUserId,
    required String familiarityAlgorithm,
    required Value<String?> fatherMemoryModelId,
    required String nextTimeAlgorithm,
    required String title,
  }) {
    return MemoryModelsCompanion(
      buttonAlgorithm: Value(buttonAlgorithm),
      creatorUserId: Value(creatorUserId),
      familiarityAlgorithm: Value(familiarityAlgorithm),
      fatherMemoryModelId: fatherMemoryModelId,
      nextTimeAlgorithm: Value(nextTimeAlgorithm),
      title: Value(title),
    );
  }

  static NotesCompanion notesCompanion({
    required String content,
    required int creatorUserId,
    required Value<String?> documentId,
    required Value<String?> fatherNoteId,
  }) {
    return NotesCompanion(
      content: Value(content),
      creatorUserId: Value(creatorUserId),
      documentId: documentId,
      fatherNoteId: fatherNoteId,
    );
  }

  static DocumentGroupsCompanion documentGroupsCompanion({
    required int creatorUserId,
    required Value<String?> fatherDocumentGroupsId,
    required String title,
  }) {
    return DocumentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherDocumentGroupsId: fatherDocumentGroupsId,
      title: Value(title),
    );
  }

  static FragmentGroupsCompanion fragmentGroupsCompanion({
    required int creatorUserId,
    required Value<String?> fatherFragmentGroupsId,
    required bool local_be_Selected,
    required String title,
  }) {
    return FragmentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherFragmentGroupsId: fatherFragmentGroupsId,
      local_be_Selected: Value(local_be_Selected),
      title: Value(title),
    );
  }

  static NoteGroupsCompanion noteGroupsCompanion({
    required int creatorUserId,
    required Value<String?> fatherNoteGroupsId,
    required String title,
  }) {
    return NoteGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherNoteGroupsId: fatherNoteGroupsId,
      title: Value(title),
    );
  }
}

extension UsersCompanionExt on UsersCompanion {
  Future<User> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.users,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension FragmentMemoryInfosCompanionExt on FragmentMemoryInfosCompanion {
  Future<FragmentMemoryInfo> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.fragmentMemoryInfos,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension SyncsCompanionExt on SyncsCompanion {
  Future<Sync> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.syncs,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension RDocument2DocumentGroupsCompanionExt
    on RDocument2DocumentGroupsCompanion {
  Future<RDocument2DocumentGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.rDocument2DocumentGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension RFragment2FragmentGroupsCompanionExt
    on RFragment2FragmentGroupsCompanion {
  Future<RFragment2FragmentGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.rFragment2FragmentGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension RNote2NoteGroupsCompanionExt on RNote2NoteGroupsCompanion {
  Future<RNote2NoteGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.rNote2NoteGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension Test2sCompanionExt on Test2sCompanion {
  Future<Test2> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.test2s,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension TestsCompanionExt on TestsCompanion {
  Future<Test> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.tests,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension ClientSyncInfosCompanionExt on ClientSyncInfosCompanion {
  Future<ClientSyncInfo> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.clientSyncInfos,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension DocumentsCompanionExt on DocumentsCompanion {
  Future<Document> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.documents,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension FragmentTemplatesCompanionExt on FragmentTemplatesCompanion {
  Future<FragmentTemplate> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.fragmentTemplates,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension FragmentsCompanionExt on FragmentsCompanion {
  Future<Fragment> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.fragments,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension MemoryGroupsCompanionExt on MemoryGroupsCompanion {
  Future<MemoryGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.memoryGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension MemoryModelsCompanionExt on MemoryModelsCompanion {
  Future<MemoryModel> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.memoryModels,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension NotesCompanionExt on NotesCompanion {
  Future<Note> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.notes,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension DocumentGroupsCompanionExt on DocumentGroupsCompanion {
  Future<DocumentGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.documentGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension FragmentGroupsCompanionExt on FragmentGroupsCompanion {
  Future<FragmentGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.fragmentGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension NoteGroupsCompanionExt on NoteGroupsCompanion {
  Future<NoteGroup> insert({required SyncTag? syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.noteGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}
