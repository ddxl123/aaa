// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ResetGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

extension UserExt on User {
  User reset({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String> username,
    required Value<String?> password,
    required Value<String> email,
    required Value<int> age,
  }) {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.username = username.present ? username.value : this.username;
    this.password = password.present ? password.value : this.password;
    this.email = email.present ? email.value : this.email;
    this.age = age.present ? age.value : this.age;
    return this;
  }
}

extension FragmentExt on Fragment {
  Fragment reset({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String?> fatherFragmentId,
    required Value<String> title,
    required Value<int> priority,
  }) {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.fatherFragmentId = fatherFragmentId.present
        ? fatherFragmentId.value
        : this.fatherFragmentId;
    this.title = title.present ? title.value : this.title;
    this.priority = priority.present ? priority.value : this.priority;
    return this;
  }
}

extension FragmentGroupExt on FragmentGroup {
  FragmentGroup reset({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String?> fatherFragmentGroupId,
    required Value<String> title,
  }) {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.fatherFragmentGroupId = fatherFragmentGroupId.present
        ? fatherFragmentGroupId.value
        : this.fatherFragmentGroupId;
    this.title = title.present ? title.value : this.title;
    return this;
  }
}

extension MemoryGroupExt on MemoryGroup {
  MemoryGroup reset({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String> title,
    required Value<MemoryGroupType> type,
    required Value<MemoryGroupStatusForNormal> normalStatus,
    required Value<MemoryGroupStatusForNormalPart> normalPartStatus,
    required Value<MemoryGroupStatusForFullFloating> fullFloatingStatus,
  }) {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.title = title.present ? title.value : this.title;
    this.type = type.present ? type.value : this.type;
    this.normalStatus =
        normalStatus.present ? normalStatus.value : this.normalStatus;
    this.normalPartStatus = normalPartStatus.present
        ? normalPartStatus.value
        : this.normalPartStatus;
    this.fullFloatingStatus = fullFloatingStatus.present
        ? fullFloatingStatus.value
        : this.fullFloatingStatus;
    return this;
  }
}

extension MemoryModelExt on MemoryModel {
  MemoryModel reset({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String> title,
    required Value<String?> familiarityAlgorithm,
    required Value<String?> nextTimeAlgorithm,
  }) {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.title = title.present ? title.value : this.title;
    this.familiarityAlgorithm = familiarityAlgorithm.present
        ? familiarityAlgorithm.value
        : this.familiarityAlgorithm;
    this.nextTimeAlgorithm = nextTimeAlgorithm.present
        ? nextTimeAlgorithm.value
        : this.nextTimeAlgorithm;
    return this;
  }
}

extension FragmentPermanentMemoryInfoExt on FragmentPermanentMemoryInfo {
  FragmentPermanentMemoryInfo reset({
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
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.fragmentId = fragmentId.present ? fragmentId.value : this.fragmentId;
    this.memoryModelId =
        memoryModelId.present ? memoryModelId.value : this.memoryModelId;
    this.memoryGroupId =
        memoryGroupId.present ? memoryGroupId.value : this.memoryGroupId;
    this.stageButtonValue = stageButtonValue.present
        ? stageButtonValue.value
        : this.stageButtonValue;
    this.stageFamiliarity = stageFamiliarity.present
        ? stageFamiliarity.value
        : this.stageFamiliarity;
    this.nextShowTime =
        nextShowTime.present ? nextShowTime.value : this.nextShowTime;
    this.showDuration =
        showDuration.present ? showDuration.value : this.showDuration;
    return this;
  }
}

extension RFragment2FragmentGroupExt on RFragment2FragmentGroup {
  RFragment2FragmentGroup reset({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
  }) {
    this.fatherId = fatherId.present ? fatherId.value : this.fatherId;
    this.sonId = sonId.present ? sonId.value : this.sonId;
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    return this;
  }
}

extension RFragment2MemoryGroupExt on RFragment2MemoryGroup {
  RFragment2MemoryGroup reset({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
  }) {
    this.fatherId = fatherId.present ? fatherId.value : this.fatherId;
    this.sonId = sonId.present ? sonId.value : this.sonId;
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    return this;
  }
}

extension RMemoryModel2MemoryGroupExt on RMemoryModel2MemoryGroup {
  RMemoryModel2MemoryGroup reset({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
  }) {
    this.fatherId = fatherId.present ? fatherId.value : this.fatherId;
    this.sonId = sonId.present ? sonId.value : this.sonId;
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    return this;
  }
}

extension RAssistedMemoryFragment2FragmentDataExt
    on RAssistedMemoryFragment2FragmentData {
  RAssistedMemoryFragment2FragmentData reset({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
  }) {
    this.fatherId = fatherId.present ? fatherId.value : this.fatherId;
    this.sonId = sonId.present ? sonId.value : this.sonId;
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    return this;
  }
}

extension AppInfoExt on AppInfo {
  AppInfo reset({
    required Value<int> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String> token,
    required Value<bool> hasDownloadedInitData,
  }) {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.token = token.present ? token.value : this.token;
    this.hasDownloadedInitData = hasDownloadedInitData.present
        ? hasDownloadedInitData.value
        : this.hasDownloadedInitData;
    return this;
  }
}

extension SyncExt on Sync {
  Sync reset({
    required Value<int> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String> syncTableName,
    required Value<String> rowId,
    required Value<SyncCurdType?> syncCurdType,
    required Value<String?> syncUpdateColumns,
    required Value<int> tag,
  }) {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.syncTableName =
        syncTableName.present ? syncTableName.value : this.syncTableName;
    this.rowId = rowId.present ? rowId.value : this.rowId;
    this.syncCurdType =
        syncCurdType.present ? syncCurdType.value : this.syncCurdType;
    this.syncUpdateColumns = syncUpdateColumns.present
        ? syncUpdateColumns.value
        : this.syncUpdateColumns;
    this.tag = tag.present ? tag.value : this.tag;
    return this;
  }
}
