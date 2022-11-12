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
    required String username,
    required String password,
    required String email,
    required int age,
  }) {
    return UsersCompanion(
      username: Value(username),
      password: Value(password),
      email: Value(email),
      age: Value(age),
    );
  }

  static FragmentsCompanion fragmentsCompanion({
    required Value<String?> fatherFragmentId,
    required String title,
    required int priority,
  }) {
    return FragmentsCompanion(
      fatherFragmentId: fatherFragmentId,
      title: Value(title),
      priority: Value(priority),
    );
  }

  static FragmentGroupsCompanion fragmentGroupsCompanion({
    required Value<String?> fatherFragmentGroupId,
    required String title,
  }) {
    return FragmentGroupsCompanion(
      fatherFragmentGroupId: fatherFragmentGroupId,
      title: Value(title),
    );
  }

  static MemoryGroupsCompanion memoryGroupsCompanion({
    required Value<String?> memoryModelId,
    required String title,
    required int willNewLearnCount,
    required DateTime reviewInterval,
    required NewReviewDisplayOrder newReviewDisplayOrder,
    required NewDisplayOrder newDisplayOrder,
    required Value<DateTime?> startTime,
    required bool isEnableFilterOutAlgorithm,
    required bool isFilterOutAlgorithmFollowMemoryModel,
    required String filterOutAlgorithm,
    required bool isEnableFloatingAlgorithm,
    required bool isFloatingAlgorithmFollowMemoryModel,
    required String floatingAlgorithm,
  }) {
    return MemoryGroupsCompanion(
      memoryModelId: memoryModelId,
      title: Value(title),
      willNewLearnCount: Value(willNewLearnCount),
      reviewInterval: Value(reviewInterval),
      newReviewDisplayOrder: Value(newReviewDisplayOrder),
      newDisplayOrder: Value(newDisplayOrder),
      startTime: startTime,
      isEnableFilterOutAlgorithm: Value(isEnableFilterOutAlgorithm),
      isFilterOutAlgorithmFollowMemoryModel:
          Value(isFilterOutAlgorithmFollowMemoryModel),
      filterOutAlgorithm: Value(filterOutAlgorithm),
      isEnableFloatingAlgorithm: Value(isEnableFloatingAlgorithm),
      isFloatingAlgorithmFollowMemoryModel:
          Value(isFloatingAlgorithmFollowMemoryModel),
      floatingAlgorithm: Value(floatingAlgorithm),
    );
  }

  static MemoryModelsCompanion memoryModelsCompanion({
    required String title,
    required String familiarityAlgorithm,
    required String nextTimeAlgorithm,
    required String buttonAlgorithm,
    required String stimulateAlgorithm,
    required String applicableGroups,
    required String applicableFields,
  }) {
    return MemoryModelsCompanion(
      title: Value(title),
      familiarityAlgorithm: Value(familiarityAlgorithm),
      nextTimeAlgorithm: Value(nextTimeAlgorithm),
      buttonAlgorithm: Value(buttonAlgorithm),
      stimulateAlgorithm: Value(stimulateAlgorithm),
      applicableGroups: Value(applicableGroups),
      applicableFields: Value(applicableFields),
    );
  }

  static FragmentMemoryInfosCompanion fragmentMemoryInfosCompanion({
    required String fragmentId,
    required String memoryGroupId,
    required bool isLatestRecord,
    required int nextPlanShowTime,
    required int currentActualShowTime,
    required double showFamiliarity,
    required int clickTime,
    required double clickValue,
  }) {
    return FragmentMemoryInfosCompanion(
      fragmentId: Value(fragmentId),
      memoryGroupId: Value(memoryGroupId),
      isLatestRecord: Value(isLatestRecord),
      nextPlanShowTime: Value(nextPlanShowTime),
      currentActualShowTime: Value(currentActualShowTime),
      showFamiliarity: Value(showFamiliarity),
      clickTime: Value(clickTime),
      clickValue: Value(clickValue),
    );
  }

  static RFragment2FragmentGroupsCompanion rFragment2FragmentGroupsCompanion({
    required Value<String?> fatherId,
    required String sonId,
  }) {
    return RFragment2FragmentGroupsCompanion(
      fatherId: fatherId,
      sonId: Value(sonId),
    );
  }

  static RFragment2MemoryGroupsCompanion rFragment2MemoryGroupsCompanion({
    required Value<String?> fatherId,
    required String sonId,
  }) {
    return RFragment2MemoryGroupsCompanion(
      fatherId: fatherId,
      sonId: Value(sonId),
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
