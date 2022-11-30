// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ConstructorGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

/// 这个类在创建表对象时，可以让每个 column 都能被编辑器提示，以防遗漏。
///
/// id createdAt updatedAt 已经在 [DriftSyncExt.insertReturningWith] 中自动更新了。
///
/// 使用方式查看 [withRefs]。
class WithCrts {
  static UsersCompanion usersCompanion({
    required int age,
    required Value<String?> email,
    required Value<String?> password,
    required String username,
  }) {
    return UsersCompanion(
      age: Value(age),
      email: email,
      password: password,
      username: Value(username),
    );
  }

  static FragmentMemoryInfosCompanion fragmentMemoryInfosCompanion({
    required DateTime clickTime,
    required double clickValue,
    required int creatorUserId,
    required DateTime currentActualShowTime,
    required String fragmentId,
    required bool isLatestRecord,
    required String memoryGroupId,
    required DateTime nextPlanShowTime,
    required double showFamiliarity,
  }) {
    return FragmentMemoryInfosCompanion(
      clickTime: Value(clickTime),
      clickValue: Value(clickValue),
      creatorUserId: Value(creatorUserId),
      currentActualShowTime: Value(currentActualShowTime),
      fragmentId: Value(fragmentId),
      isLatestRecord: Value(isLatestRecord),
      memoryGroupId: Value(memoryGroupId),
      nextPlanShowTime: Value(nextPlanShowTime),
      showFamiliarity: Value(showFamiliarity),
    );
  }

  static AppInfosCompanion appInfosCompanion({
    required bool hasDownloadedInitData,
    required String token,
  }) {
    return AppInfosCompanion(
      hasDownloadedInitData: Value(hasDownloadedInitData),
      token: Value(token),
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

  static RMemoryModel2MemoryModelGroupsCompanion
      rMemoryModel2MemoryModelGroupsCompanion({
    required int creatorUserId,
    required Value<String?> memoryModelGroupId,
    required String memoryModelId,
  }) {
    return RMemoryModel2MemoryModelGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      memoryModelGroupId: memoryModelGroupId,
      memoryModelId: Value(memoryModelId),
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

  static DocumentsCompanion documentsCompanion({
    required String content,
    required int creatorUserId,
  }) {
    return DocumentsCompanion(
      content: Value(content),
      creatorUserId: Value(creatorUserId),
    );
  }

  static FragmentsCompanion fragmentsCompanion({
    required String content,
    required int creatorUserId,
    required Value<String?> fatherFragmentId,
    required bool isSelected,
    required Value<String?> noteId,
  }) {
    return FragmentsCompanion(
      content: Value(content),
      creatorUserId: Value(creatorUserId),
      fatherFragmentId: fatherFragmentId,
      isSelected: Value(isSelected),
      noteId: noteId,
    );
  }

  static MemoryModelsCompanion memoryModelsCompanion({
    required String buttonAlgorithm,
    required int creatorUserId,
    required String familiarityAlgorithm,
    required Value<String?> fatherMemoryModelId,
    required String nextTimeAlgorithm,
    required String stimulateAlgorithm,
    required String title,
  }) {
    return MemoryModelsCompanion(
      buttonAlgorithm: Value(buttonAlgorithm),
      creatorUserId: Value(creatorUserId),
      familiarityAlgorithm: Value(familiarityAlgorithm),
      fatherMemoryModelId: fatherMemoryModelId,
      nextTimeAlgorithm: Value(nextTimeAlgorithm),
      stimulateAlgorithm: Value(stimulateAlgorithm),
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
    required bool isSelected,
    required String title,
  }) {
    return FragmentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherFragmentGroupsId: fatherFragmentGroupsId,
      isSelected: Value(isSelected),
      title: Value(title),
    );
  }

  static MemoryModelGroupsCompanion memoryModelGroupsCompanion({
    required int creatorUserId,
    required Value<String?> fatherMemoryModelGroupsId,
    required String title,
  }) {
    return MemoryModelGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherMemoryModelGroupsId: fatherMemoryModelGroupsId,
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
