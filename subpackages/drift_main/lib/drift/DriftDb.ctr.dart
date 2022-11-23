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
    required Value<int?> age,
    required Value<String?> email,
    required Value<String?> password,
    required Value<String?> username,
  }) {
    return UsersCompanion(
      age: age,
      email: email,
      password: password,
      username: username,
    );
  }

  static FragmentMemoryInfosCompanion fragmentMemoryInfosCompanion({
    required int clickTime,
    required double clickValue,
    required int creatorUserId,
    required int currentActualShowTime,
    required int fragmentId,
    required bool isLatestRecord,
    required int memoryGroupId,
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

  static MemoryGroupsCompanion memoryGroupsCompanion({
    required int creatorUserId,
    required Value<int?> memoryModelId,
    required Value<NewDisplayOrder?> newDisplayOrder,
    required Value<NewReviewDisplayOrder?> newReviewDisplayOrder,
    required Value<DateTime?> reviewInterval,
    required Value<DateTime?> startTime,
    required Value<String?> title,
    required Value<int?> willNewLearnCount,
  }) {
    return MemoryGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      memoryModelId: memoryModelId,
      newDisplayOrder: newDisplayOrder,
      newReviewDisplayOrder: newReviewDisplayOrder,
      reviewInterval: reviewInterval,
      startTime: startTime,
      title: title,
      willNewLearnCount: willNewLearnCount,
    );
  }

  static RDocument2DocumentGroupsCompanion rDocument2DocumentGroupsCompanion({
    required int creatorUserId,
    required Value<int?> documentGroupId,
    required int documentId,
  }) {
    return RDocument2DocumentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      documentGroupId: documentGroupId,
      documentId: Value(documentId),
    );
  }

  static RFragment2FragmentGroupsCompanion rFragment2FragmentGroupsCompanion({
    required int creatorUserId,
    required int fragmentGroupId,
    required int fragmentId,
  }) {
    return RFragment2FragmentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fragmentGroupId: Value(fragmentGroupId),
      fragmentId: Value(fragmentId),
    );
  }

  static RMemoryModel2MemoryModelGroupsCompanion
      rMemoryModel2MemoryModelGroupsCompanion({
    required int creatorUserId,
    required int memoryModelGroupId,
    required int memoryModelId,
  }) {
    return RMemoryModel2MemoryModelGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      memoryModelGroupId: Value(memoryModelGroupId),
      memoryModelId: Value(memoryModelId),
    );
  }

  static RNote2NoteGroupsCompanion rNote2NoteGroupsCompanion({
    required int creatorUserId,
    required int noteGroupId,
    required int noteId,
  }) {
    return RNote2NoteGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      noteGroupId: Value(noteGroupId),
      noteId: Value(noteId),
    );
  }

  static DocumentsCompanion documentsCompanion({
    required Value<String?> content,
    required int creatorUserId,
  }) {
    return DocumentsCompanion(
      content: content,
      creatorUserId: Value(creatorUserId),
    );
  }

  static FragmentsCompanion fragmentsCompanion({
    required Value<String?> content,
    required int creatorUserId,
    required Value<int?> fatherFragmentId,
    required Value<int?> noteId,
  }) {
    return FragmentsCompanion(
      content: content,
      creatorUserId: Value(creatorUserId),
      fatherFragmentId: fatherFragmentId,
      noteId: noteId,
    );
  }

  static MemoryModelsCompanion memoryModelsCompanion({
    required Value<String?> applicableFields,
    required Value<String?> applicableGroups,
    required Value<String?> buttonAlgorithm,
    required int creatorUserId,
    required Value<String?> familiarityAlgorithm,
    required Value<int?> fatherFragmentId,
    required Value<String?> nextTimeAlgorithm,
    required Value<String?> stimulateAlgorithm,
    required Value<String?> title,
  }) {
    return MemoryModelsCompanion(
      applicableFields: applicableFields,
      applicableGroups: applicableGroups,
      buttonAlgorithm: buttonAlgorithm,
      creatorUserId: Value(creatorUserId),
      familiarityAlgorithm: familiarityAlgorithm,
      fatherFragmentId: fatherFragmentId,
      nextTimeAlgorithm: nextTimeAlgorithm,
      stimulateAlgorithm: stimulateAlgorithm,
      title: title,
    );
  }

  static NotesCompanion notesCompanion({
    required Value<String?> content,
    required int creatorUserId,
    required Value<int?> documentId,
    required Value<int?> fatherNoteId,
  }) {
    return NotesCompanion(
      content: content,
      creatorUserId: Value(creatorUserId),
      documentId: documentId,
      fatherNoteId: fatherNoteId,
    );
  }

  static DocumentGroupsCompanion documentGroupsCompanion({
    required int creatorUserId,
    required Value<int?> fatherDocumentGroupsId,
    required Value<String?> title,
  }) {
    return DocumentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherDocumentGroupsId: fatherDocumentGroupsId,
      title: title,
    );
  }

  static FragmentGroupsCompanion fragmentGroupsCompanion({
    required int creatorUserId,
    required Value<int?> fatherFragmentGroupsId,
    required Value<String?> title,
  }) {
    return FragmentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherFragmentGroupsId: fatherFragmentGroupsId,
      title: title,
    );
  }

  static MemoryModelGroupsCompanion memoryModelGroupsCompanion({
    required int creatorUserId,
    required Value<int?> fatherMemoryModelGroupsId,
    required Value<String?> title,
  }) {
    return MemoryModelGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherMemoryModelGroupsId: fatherMemoryModelGroupsId,
      title: title,
    );
  }

  static NoteGroupsCompanion noteGroupsCompanion({
    required int creatorUserId,
    required Value<int?> fatherNoteGroupsId,
    required Value<String?> title,
  }) {
    return NoteGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherNoteGroupsId: fatherNoteGroupsId,
      title: title,
    );
  }

  static AppInfosCompanion appInfosCompanion({
    required String token,
    required bool hasDownloadedInitData,
  }) {
    return AppInfosCompanion(
      token: Value(token),
      hasDownloadedInitData: Value(hasDownloadedInitData),
    );
  }

  static SyncsCompanion syncsCompanion({
    required String syncTableName,
    required String rowId,
    required Value<SyncCurdType?> syncCurdType,
    required int tag,
  }) {
    return SyncsCompanion(
      syncTableName: Value(syncTableName),
      rowId: Value(rowId),
      syncCurdType: syncCurdType,
      tag: Value(tag),
    );
  }
}
