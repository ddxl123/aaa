// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ResetGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

extension UserExt on User {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 建议配合 [withRefs] 使用。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  FutureOr<User> reset({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String> username,
    required Value<String> password,
    required Value<String> email,
    required Value<int> age,
    required SyncTag? writeSyncTag,
  }) async {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.username = username.present ? username.value : this.username;
    this.password = password.present ? password.value : this.password;
    this.email = email.present ? email.value : this.email;
    this.age = age.present ? age.value : this.age;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.users,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

extension FragmentExt on Fragment {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 建议配合 [withRefs] 使用。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  FutureOr<Fragment> reset({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String?> fatherFragmentId,
    required Value<String> title,
    required Value<int> priority,
    required SyncTag? writeSyncTag,
  }) async {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.fatherFragmentId = fatherFragmentId.present
        ? fatherFragmentId.value
        : this.fatherFragmentId;
    this.title = title.present ? title.value : this.title;
    this.priority = priority.present ? priority.value : this.priority;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragments,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

extension FragmentGroupExt on FragmentGroup {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 建议配合 [withRefs] 使用。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  FutureOr<FragmentGroup> reset({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String?> fatherFragmentGroupId,
    required Value<String> title,
    required SyncTag? writeSyncTag,
  }) async {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.fatherFragmentGroupId = fatherFragmentGroupId.present
        ? fatherFragmentGroupId.value
        : this.fatherFragmentGroupId;
    this.title = title.present ? title.value : this.title;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragmentGroups,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

extension MemoryGroupExt on MemoryGroup {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 建议配合 [withRefs] 使用。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  FutureOr<MemoryGroup> reset({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String?> memoryModelId,
    required Value<String> title,
    required Value<MemoryGroupType> type,
    required Value<MemoryGroupStatus> status,
    required Value<int> willNewLearnCount,
    required Value<DateTime> reviewInterval,
    required Value<String> filterOut,
    required Value<NewReviewDisplayOrder> newReviewDisplayOrder,
    required Value<NewDisplayOrder> newDisplayOrder,
    required Value<DateTime?> startTime,
    required SyncTag? writeSyncTag,
  }) async {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.memoryModelId =
        memoryModelId.present ? memoryModelId.value : this.memoryModelId;
    this.title = title.present ? title.value : this.title;
    this.type = type.present ? type.value : this.type;
    this.status = status.present ? status.value : this.status;
    this.willNewLearnCount = willNewLearnCount.present
        ? willNewLearnCount.value
        : this.willNewLearnCount;
    this.reviewInterval =
        reviewInterval.present ? reviewInterval.value : this.reviewInterval;
    this.filterOut = filterOut.present ? filterOut.value : this.filterOut;
    this.newReviewDisplayOrder = newReviewDisplayOrder.present
        ? newReviewDisplayOrder.value
        : this.newReviewDisplayOrder;
    this.newDisplayOrder =
        newDisplayOrder.present ? newDisplayOrder.value : this.newDisplayOrder;
    this.startTime = startTime.present ? startTime.value : this.startTime;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.memoryGroups,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

extension MemoryModelExt on MemoryModel {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 建议配合 [withRefs] 使用。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  FutureOr<MemoryModel> reset({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String> title,
    required Value<String> familiarityAlgorithm,
    required Value<String> nextTimeAlgorithm,
    required Value<String> buttonAlgorithm,
    required Value<String> stimulateAlgorithm,
    required Value<String> applicableGroups,
    required Value<String> applicableFields,
    required SyncTag? writeSyncTag,
  }) async {
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
    this.buttonAlgorithm =
        buttonAlgorithm.present ? buttonAlgorithm.value : this.buttonAlgorithm;
    this.stimulateAlgorithm = stimulateAlgorithm.present
        ? stimulateAlgorithm.value
        : this.stimulateAlgorithm;
    this.applicableGroups = applicableGroups.present
        ? applicableGroups.value
        : this.applicableGroups;
    this.applicableFields = applicableFields.present
        ? applicableFields.value
        : this.applicableFields;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.memoryModels,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

extension FragmentMemoryInfoExt on FragmentMemoryInfo {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 建议配合 [withRefs] 使用。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  FutureOr<FragmentMemoryInfo> reset({
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String> fragmentId,
    required Value<String> memoryGroupId,
    required Value<bool> isLatestRecord,
    required Value<DateTime> planedShowTime,
    required Value<DateTime> actualShowTime,
    required Value<double> clickFamiliarity,
    required Value<DateTime> clickTime,
    required Value<double> clickValue,
    required SyncTag? writeSyncTag,
  }) async {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.fragmentId = fragmentId.present ? fragmentId.value : this.fragmentId;
    this.memoryGroupId =
        memoryGroupId.present ? memoryGroupId.value : this.memoryGroupId;
    this.isLatestRecord =
        isLatestRecord.present ? isLatestRecord.value : this.isLatestRecord;
    this.planedShowTime =
        planedShowTime.present ? planedShowTime.value : this.planedShowTime;
    this.actualShowTime =
        actualShowTime.present ? actualShowTime.value : this.actualShowTime;
    this.clickFamiliarity = clickFamiliarity.present
        ? clickFamiliarity.value
        : this.clickFamiliarity;
    this.clickTime = clickTime.present ? clickTime.value : this.clickTime;
    this.clickValue = clickValue.present ? clickValue.value : this.clickValue;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragmentMemoryInfos,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

extension RFragment2FragmentGroupExt on RFragment2FragmentGroup {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 建议配合 [withRefs] 使用。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  FutureOr<RFragment2FragmentGroup> reset({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required SyncTag? writeSyncTag,
  }) async {
    this.fatherId = fatherId.present ? fatherId.value : this.fatherId;
    this.sonId = sonId.present ? sonId.value : this.sonId;
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rFragment2FragmentGroups,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

extension RFragment2MemoryGroupExt on RFragment2MemoryGroup {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 建议配合 [withRefs] 使用。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  FutureOr<RFragment2MemoryGroup> reset({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required SyncTag? writeSyncTag,
  }) async {
    this.fatherId = fatherId.present ? fatherId.value : this.fatherId;
    this.sonId = sonId.present ? sonId.value : this.sonId;
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rFragment2MemoryGroups,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

extension RAssistedMemory2FragmentExt on RAssistedMemory2Fragment {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 建议配合 [withRefs] 使用。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  FutureOr<RAssistedMemory2Fragment> reset({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required Value<String> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required SyncTag? writeSyncTag,
  }) async {
    this.fatherId = fatherId.present ? fatherId.value : this.fatherId;
    this.sonId = sonId.present ? sonId.value : this.sonId;
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rAssistedMemory2Fragments,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

extension AppInfoExt on AppInfo {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 建议配合 [withRefs] 使用。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  FutureOr<AppInfo> reset({
    required Value<int> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String> token,
    required Value<bool> hasDownloadedInitData,
    required SyncTag? writeSyncTag,
  }) async {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.token = token.present ? token.value : this.token;
    this.hasDownloadedInitData = hasDownloadedInitData.present
        ? hasDownloadedInitData.value
        : this.hasDownloadedInitData;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.appInfos,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

extension SyncExt on Sync {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 建议配合 [withRefs] 使用。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  FutureOr<Sync> reset({
    required Value<int> id,
    required Value<DateTime> createdAt,
    required Value<DateTime> updatedAt,
    required Value<String> syncTableName,
    required Value<String> rowId,
    required Value<SyncCurdType?> syncCurdType,
    required Value<int> tag,
    required SyncTag? writeSyncTag,
  }) async {
    this.id = id.present ? id.value : this.id;
    this.createdAt = createdAt.present ? createdAt.value : this.createdAt;
    this.updatedAt = updatedAt.present ? updatedAt.value : this.updatedAt;
    this.syncTableName =
        syncTableName.present ? syncTableName.value : this.syncTableName;
    this.rowId = rowId.present ? rowId.value : this.rowId;
    this.syncCurdType =
        syncCurdType.present ? syncCurdType.value : this.syncCurdType;
    this.tag = tag.present ? tag.value : this.tag;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.syncs,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}
