// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ConstructorGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

class WithCrts {
  static UsersCompanion usersCompanion({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required String username,
    required String password,
    required String email,
    required int age,
  }) {
    return UsersCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      username: Value(username),
      password: Value(password),
      email: Value(email),
      age: Value(age),
    );
  }

  static FragmentsCompanion fragmentsCompanion({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String?> fatherFragmentId,
    required String title,
    required int priority,
  }) {
    return FragmentsCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      fatherFragmentId: fatherFragmentId,
      title: Value(title),
      priority: Value(priority),
    );
  }

  static FragmentGroupsCompanion fragmentGroupsCompanion({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String?> fatherFragmentGroupId,
    required String title,
  }) {
    return FragmentGroupsCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      fatherFragmentGroupId: fatherFragmentGroupId,
      title: Value(title),
    );
  }

  static MemoryGroupsCompanion memoryGroupsCompanion({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required String memoryModelId,
    required String title,
    required MemoryGroupType type,
    required MemoryGroupStatus status,
    required int newLearnCount,
    required DateTime reviewInterval,
    required String filterOut,
    required NewReviewDisplayOrder newReviewDisplayOrder,
    required NewDisplayOrder newDisplayOrder,
  }) {
    return MemoryGroupsCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      memoryModelId: Value(memoryModelId),
      title: Value(title),
      type: Value(type),
      status: Value(status),
      newLearnCount: Value(newLearnCount),
      reviewInterval: Value(reviewInterval),
      filterOut: Value(filterOut),
      newReviewDisplayOrder: Value(newReviewDisplayOrder),
      newDisplayOrder: Value(newDisplayOrder),
    );
  }

  static MemoryModelsCompanion memoryModelsCompanion({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required String title,
    required String familiarityAlgorithm,
    required String nextTimeAlgorithm,
    required String buttonData,
  }) {
    return MemoryModelsCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      title: Value(title),
      familiarityAlgorithm: Value(familiarityAlgorithm),
      nextTimeAlgorithm: Value(nextTimeAlgorithm),
      buttonData: Value(buttonData),
    );
  }

  static FragmentMemoryInfosCompanion fragmentMemoryInfosCompanion({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required String fragmentId,
    required String memoryGroupId,
    required double stageButtonValue,
    required double stageFamiliarity,
    required DateTime planedNextShowTime,
    required Value<DateTime?> actualNextShowTime,
    required double showDuration,
    required bool isLatestRecord,
  }) {
    return FragmentMemoryInfosCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      fragmentId: Value(fragmentId),
      memoryGroupId: Value(memoryGroupId),
      stageButtonValue: Value(stageButtonValue),
      stageFamiliarity: Value(stageFamiliarity),
      planedNextShowTime: Value(planedNextShowTime),
      actualNextShowTime: actualNextShowTime,
      showDuration: Value(showDuration),
      isLatestRecord: Value(isLatestRecord),
    );
  }

  static RFragment2FragmentGroupsCompanion rFragment2FragmentGroupsCompanion({
    required Value<String?> fatherId,
    required String sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
  }) {
    return RFragment2FragmentGroupsCompanion(
      fatherId: fatherId,
      sonId: Value(sonId),
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static RFragment2MemoryGroupsCompanion rFragment2MemoryGroupsCompanion({
    required Value<String?> fatherId,
    required String sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
  }) {
    return RFragment2MemoryGroupsCompanion(
      fatherId: fatherId,
      sonId: Value(sonId),
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static RAssistedMemory2FragmentsCompanion rAssistedMemory2FragmentsCompanion({
    required Value<String?> fatherId,
    required String sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
  }) {
    return RAssistedMemory2FragmentsCompanion(
      fatherId: fatherId,
      sonId: Value(sonId),
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static AppInfosCompanion appInfosCompanion({
    required Value<int> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String> token,
    required Value<bool> hasDownloadedInitData,
  }) {
    return AppInfosCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      token: token,
      hasDownloadedInitData: hasDownloadedInitData,
    );
  }

  static SyncsCompanion syncsCompanion({
    required Value<int> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required String syncTableName,
    required String rowId,
    required Value<SyncCurdType?> syncCurdType,
    required int tag,
  }) {
    return SyncsCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncTableName: Value(syncTableName),
      rowId: Value(rowId),
      syncCurdType: syncCurdType,
      tag: Value(tag),
    );
  }
}
