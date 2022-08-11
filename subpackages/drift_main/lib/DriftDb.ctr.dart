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
    required Value<String> username,
    required Value<String?> password,
    required Value<String> email,
    required Value<int> age,
  }) {
    return UsersCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      username: username,
      password: password,
      email: email,
      age: age,
    );
  }

  static FragmentsCompanion fragmentsCompanion({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String?> fatherFragmentId,
    required Value<String> title,
    required Value<int> priority,
  }) {
    return FragmentsCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      fatherFragmentId: fatherFragmentId,
      title: title,
      priority: priority,
    );
  }

  static FragmentGroupsCompanion fragmentGroupsCompanion({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String?> fatherFragmentGroupId,
    required Value<String> title,
  }) {
    return FragmentGroupsCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      fatherFragmentGroupId: fatherFragmentGroupId,
      title: title,
    );
  }

  static MemoryGroupsCompanion memoryGroupsCompanion({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String> title,
    required Value<MemoryGroupType> type,
    required Value<MemoryGroupStatusForInApp> normalStatus,
    required Value<MemoryGroupStatusForInAppPart> normalPartStatus,
    required Value<MemoryGroupStatusForAllFloating> fullFloatingStatus,
  }) {
    return MemoryGroupsCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      title: title,
      type: type,
      normalStatus: normalStatus,
      normalPartStatus: normalPartStatus,
      fullFloatingStatus: fullFloatingStatus,
    );
  }

  static MemoryModelsCompanion memoryModelsCompanion({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String> title,
    required Value<String?> familiarityAlgorithm,
    required Value<String?> nextTimeAlgorithm,
  }) {
    return MemoryModelsCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      title: title,
      familiarityAlgorithm: familiarityAlgorithm,
      nextTimeAlgorithm: nextTimeAlgorithm,
    );
  }

  static FragmentPermanentMemoryInfosCompanion
      fragmentPermanentMemoryInfosCompanion({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String?> fragmentId,
    required Value<String?> memoryModelId,
    required Value<String?> memoryGroupId,
    required Value<double?> stageButtonValue,
    required Value<double> stageFamiliarity,
    required Value<DateTime?> nextShowTime,
    required Value<double> showDuration,
  }) {
    return FragmentPermanentMemoryInfosCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      fragmentId: fragmentId,
      memoryModelId: memoryModelId,
      memoryGroupId: memoryGroupId,
      stageButtonValue: stageButtonValue,
      stageFamiliarity: stageFamiliarity,
      nextShowTime: nextShowTime,
      showDuration: showDuration,
    );
  }

  static RFragment2FragmentGroupsCompanion rFragment2FragmentGroupsCompanion({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
  }) {
    return RFragment2FragmentGroupsCompanion(
      fatherId: fatherId,
      sonId: sonId,
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static RFragment2MemoryGroupsCompanion rFragment2MemoryGroupsCompanion({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
  }) {
    return RFragment2MemoryGroupsCompanion(
      fatherId: fatherId,
      sonId: sonId,
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static RMemoryModel2MemoryGroupsCompanion rMemoryModel2MemoryGroupsCompanion({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
  }) {
    return RMemoryModel2MemoryGroupsCompanion(
      fatherId: fatherId,
      sonId: sonId,
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static RAssistedMemory2FragmentsCompanion rAssistedMemory2FragmentsCompanion({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
  }) {
    return RAssistedMemory2FragmentsCompanion(
      fatherId: fatherId,
      sonId: sonId,
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
    required Value<String> syncTableName,
    required Value<String> rowId,
    required Value<SyncCurdType?> syncCurdType,
    required Value<int> tag,
  }) {
    return SyncsCompanion(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncTableName: syncTableName,
      rowId: rowId,
      syncCurdType: syncCurdType,
      tag: tag,
    );
  }
}
