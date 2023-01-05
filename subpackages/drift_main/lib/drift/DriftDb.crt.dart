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
    required String client_token,
    required Value<String?> email,
    required Value<String?> password,
    required Value<String?> phone,
    required String username,
    DateTime? createdAt,
    Value<int>? id,
    DateTime? updatedAt,
  }) {
    return UsersCompanion(
      age: age,
      client_token: Value(client_token),
      email: email,
      password: password,
      phone: phone,
      username: Value(username),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : id,
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static SyncsCompanion syncsCompanion({
    required String rowId,
    required SyncCurdType syncCurdType,
    required String syncTableName,
    required int tag,
    DateTime? createdAt,
    Value<int>? id,
    DateTime? updatedAt,
  }) {
    return SyncsCompanion(
      rowId: Value(rowId),
      syncCurdType: Value(syncCurdType),
      syncTableName: Value(syncTableName),
      tag: Value(tag),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : id,
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
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
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
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
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : Value(id),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static RDocument2DocumentGroupsCompanion rDocument2DocumentGroupsCompanion({
    required int creatorUserId,
    required Value<String?> documentGroupId,
    required String documentId,
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
  }) {
    return RDocument2DocumentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      documentGroupId: documentGroupId,
      documentId: Value(documentId),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : Value(id),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static RFragment2FragmentGroupsCompanion rFragment2FragmentGroupsCompanion({
    required int creatorUserId,
    required Value<String?> fragmentGroupId,
    required String fragmentId,
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
  }) {
    return RFragment2FragmentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fragmentGroupId: fragmentGroupId,
      fragmentId: Value(fragmentId),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : Value(id),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static RNote2NoteGroupsCompanion rNote2NoteGroupsCompanion({
    required int creatorUserId,
    required Value<String?> noteGroupId,
    required String noteId,
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
  }) {
    return RNote2NoteGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      noteGroupId: noteGroupId,
      noteId: Value(noteId),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : Value(id),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static Test2sCompanion test2sCompanion({
    required String client_content,
    DateTime? createdAt,
    Value<int>? id,
    DateTime? updatedAt,
  }) {
    return Test2sCompanion(
      client_content: Value(client_content),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : id,
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static TestsCompanion testsCompanion({
    required String client_content,
    DateTime? createdAt,
    Value<int>? id,
    DateTime? updatedAt,
  }) {
    return TestsCompanion(
      client_content: Value(client_content),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : id,
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static ClientSyncInfosCompanion clientSyncInfosCompanion({
    required DateTime recentSyncTime,
    DateTime? createdAt,
    Value<int>? id,
    DateTime? updatedAt,
  }) {
    return ClientSyncInfosCompanion(
      recentSyncTime: Value(recentSyncTime),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : id,
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static DocumentsCompanion documentsCompanion({
    required String content,
    required int creatorUserId,
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
  }) {
    return DocumentsCompanion(
      content: Value(content),
      creatorUserId: Value(creatorUserId),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : Value(id),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static FragmentTemplatesCompanion fragmentTemplatesCompanion({
    required String content,
    required int ownerUserId,
    required FragmentTemplateType type,
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
  }) {
    return FragmentTemplatesCompanion(
      content: Value(content),
      ownerUserId: Value(ownerUserId),
      type: Value(type),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : Value(id),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static FragmentsCompanion fragmentsCompanion({
    required bool client_be_Selected,
    required String content,
    required int creatorUserId,
    required Value<String?> fatherFragmentId,
    required Value<String?> fragmentTemplateId,
    required Value<String?> noteId,
    required String title,
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
  }) {
    return FragmentsCompanion(
      client_be_Selected: Value(client_be_Selected),
      content: Value(content),
      creatorUserId: Value(creatorUserId),
      fatherFragmentId: fatherFragmentId,
      fragmentTemplateId: fragmentTemplateId,
      noteId: noteId,
      title: Value(title),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : Value(id),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
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
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
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
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : Value(id),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static MemoryModelsCompanion memoryModelsCompanion({
    required String buttonAlgorithm,
    required int creatorUserId,
    required String familiarityAlgorithm,
    required Value<String?> fatherMemoryModelId,
    required String nextTimeAlgorithm,
    required String title,
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
  }) {
    return MemoryModelsCompanion(
      buttonAlgorithm: Value(buttonAlgorithm),
      creatorUserId: Value(creatorUserId),
      familiarityAlgorithm: Value(familiarityAlgorithm),
      fatherMemoryModelId: fatherMemoryModelId,
      nextTimeAlgorithm: Value(nextTimeAlgorithm),
      title: Value(title),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : Value(id),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static NotesCompanion notesCompanion({
    required String content,
    required int creatorUserId,
    required Value<String?> documentId,
    required Value<String?> fatherNoteId,
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
  }) {
    return NotesCompanion(
      content: Value(content),
      creatorUserId: Value(creatorUserId),
      documentId: documentId,
      fatherNoteId: fatherNoteId,
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : Value(id),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static DocumentGroupsCompanion documentGroupsCompanion({
    required int creatorUserId,
    required Value<String?> fatherDocumentGroupsId,
    required String title,
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
  }) {
    return DocumentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherDocumentGroupsId: fatherDocumentGroupsId,
      title: Value(title),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : Value(id),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static FragmentGroupsCompanion fragmentGroupsCompanion({
    required bool client_be_Selected,
    required int creatorUserId,
    required Value<String?> fatherFragmentGroupsId,
    required String title,
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
  }) {
    return FragmentGroupsCompanion(
      client_be_Selected: Value(client_be_Selected),
      creatorUserId: Value(creatorUserId),
      fatherFragmentGroupsId: fatherFragmentGroupsId,
      title: Value(title),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : Value(id),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
    );
  }

  static NoteGroupsCompanion noteGroupsCompanion({
    required int creatorUserId,
    required Value<String?> fatherNoteGroupsId,
    required String title,
    DateTime? createdAt,
    String? id,
    DateTime? updatedAt,
  }) {
    return NoteGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherNoteGroupsId: fatherNoteGroupsId,
      title: Value(title),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt),
      id: id == null ? const Value.absent() : Value(id),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt),
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
