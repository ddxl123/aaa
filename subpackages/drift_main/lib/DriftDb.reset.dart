// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ResetGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

extension DriftValueExt<T> on T {
  /// 赋予新值
  ///
  /// drift.Value('value') 的快捷方法。
  ///
  /// 使用方法： '123'.toValue()。
  Value<T> toValue() {
    return Value<T>(this);
  }

  /// 保持原值不变。
  ///
  /// drift.Value.absent() 的快捷方法。
  ///
  /// 使用方法：直接在任意对象中调用 toAbsent()。
  Value<A> toAbsent<A>() {
    return Value<A>.absent();
  }
}

/// [Users]
extension UserExt on User {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// createdAt updatedAt 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<User> reset({
    required Value<String> username,
    required Value<String> password,
    required Value<String> email,
    required Value<int> age,
    required SyncTag? writeSyncTag,
  }) async {
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

/// [Fragments]
extension FragmentExt on Fragment {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// createdAt updatedAt 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<Fragment> reset({
    required Value<String?> fatherFragmentId,
    required Value<String> title,
    required Value<int> priority,
    required SyncTag? writeSyncTag,
  }) async {
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

/// [FragmentGroups]
extension FragmentGroupExt on FragmentGroup {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// createdAt updatedAt 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<FragmentGroup> reset({
    required Value<String?> fatherFragmentGroupId,
    required Value<String> title,
    required SyncTag? writeSyncTag,
  }) async {
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

/// [MemoryGroups]
extension MemoryGroupExt on MemoryGroup {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// createdAt updatedAt 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<MemoryGroup> reset({
    required Value<String?> memoryModelId,
    required Value<String> title,
    required Value<int> willNewLearnCount,
    required Value<DateTime> reviewInterval,
    required Value<NewReviewDisplayOrder> newReviewDisplayOrder,
    required Value<NewDisplayOrder> newDisplayOrder,
    required Value<DateTime?> startTime,
    required Value<bool> isEnableFilterOutAlgorithm,
    required Value<bool> isFilterOutAlgorithmFollowMemoryModel,
    required Value<String> filterOutAlgorithm,
    required Value<bool> isEnableFloatingAlgorithm,
    required Value<bool> isFloatingAlgorithmFollowMemoryModel,
    required Value<String> floatingAlgorithm,
    required SyncTag? writeSyncTag,
  }) async {
    this.memoryModelId =
        memoryModelId.present ? memoryModelId.value : this.memoryModelId;
    this.title = title.present ? title.value : this.title;
    this.willNewLearnCount = willNewLearnCount.present
        ? willNewLearnCount.value
        : this.willNewLearnCount;
    this.reviewInterval =
        reviewInterval.present ? reviewInterval.value : this.reviewInterval;
    this.newReviewDisplayOrder = newReviewDisplayOrder.present
        ? newReviewDisplayOrder.value
        : this.newReviewDisplayOrder;
    this.newDisplayOrder =
        newDisplayOrder.present ? newDisplayOrder.value : this.newDisplayOrder;
    this.startTime = startTime.present ? startTime.value : this.startTime;
    this.isEnableFilterOutAlgorithm = isEnableFilterOutAlgorithm.present
        ? isEnableFilterOutAlgorithm.value
        : this.isEnableFilterOutAlgorithm;
    this.isFilterOutAlgorithmFollowMemoryModel =
        isFilterOutAlgorithmFollowMemoryModel.present
            ? isFilterOutAlgorithmFollowMemoryModel.value
            : this.isFilterOutAlgorithmFollowMemoryModel;
    this.filterOutAlgorithm = filterOutAlgorithm.present
        ? filterOutAlgorithm.value
        : this.filterOutAlgorithm;
    this.isEnableFloatingAlgorithm = isEnableFloatingAlgorithm.present
        ? isEnableFloatingAlgorithm.value
        : this.isEnableFloatingAlgorithm;
    this.isFloatingAlgorithmFollowMemoryModel =
        isFloatingAlgorithmFollowMemoryModel.present
            ? isFloatingAlgorithmFollowMemoryModel.value
            : this.isFloatingAlgorithmFollowMemoryModel;
    this.floatingAlgorithm = floatingAlgorithm.present
        ? floatingAlgorithm.value
        : this.floatingAlgorithm;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.memoryGroups,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

/// [MemoryModels]
extension MemoryModelExt on MemoryModel {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// createdAt updatedAt 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<MemoryModel> reset({
    required Value<String> title,
    required Value<String> familiarityAlgorithm,
    required Value<String> nextTimeAlgorithm,
    required Value<String> buttonAlgorithm,
    required Value<String> stimulateAlgorithm,
    required Value<String> applicableGroups,
    required Value<String> applicableFields,
    required SyncTag? writeSyncTag,
  }) async {
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

/// [FragmentMemoryInfos]
extension FragmentMemoryInfoExt on FragmentMemoryInfo {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// createdAt updatedAt 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<FragmentMemoryInfo> reset({
    required Value<String> fragmentId,
    required Value<String> memoryGroupId,
    required Value<bool> isLatestRecord,
    required Value<int> nextPlanShowTime,
    required Value<int> currentActualShowTime,
    required Value<double> showFamiliarity,
    required Value<int> clickTime,
    required Value<double> clickValue,
    required SyncTag? writeSyncTag,
  }) async {
    this.fragmentId = fragmentId.present ? fragmentId.value : this.fragmentId;
    this.memoryGroupId =
        memoryGroupId.present ? memoryGroupId.value : this.memoryGroupId;
    this.isLatestRecord =
        isLatestRecord.present ? isLatestRecord.value : this.isLatestRecord;
    this.nextPlanShowTime = nextPlanShowTime.present
        ? nextPlanShowTime.value
        : this.nextPlanShowTime;
    this.currentActualShowTime = currentActualShowTime.present
        ? currentActualShowTime.value
        : this.currentActualShowTime;
    this.showFamiliarity =
        showFamiliarity.present ? showFamiliarity.value : this.showFamiliarity;
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

/// [RFragment2FragmentGroups]
extension RFragment2FragmentGroupExt on RFragment2FragmentGroup {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// createdAt updatedAt 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<RFragment2FragmentGroup> reset({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required SyncTag? writeSyncTag,
  }) async {
    this.fatherId = fatherId.present ? fatherId.value : this.fatherId;
    this.sonId = sonId.present ? sonId.value : this.sonId;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rFragment2FragmentGroups,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

/// [RFragment2MemoryGroups]
extension RFragment2MemoryGroupExt on RFragment2MemoryGroup {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// createdAt updatedAt 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<RFragment2MemoryGroup> reset({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required SyncTag? writeSyncTag,
  }) async {
    this.fatherId = fatherId.present ? fatherId.value : this.fatherId;
    this.sonId = sonId.present ? sonId.value : this.sonId;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rFragment2MemoryGroups,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

/// [RAssistedMemory2Fragments]
extension RAssistedMemory2FragmentExt on RAssistedMemory2Fragment {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// createdAt updatedAt 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<RAssistedMemory2Fragment> reset({
    required Value<String?> fatherId,
    required Value<String> sonId,
    required SyncTag? writeSyncTag,
  }) async {
    this.fatherId = fatherId.present ? fatherId.value : this.fatherId;
    this.sonId = sonId.present ? sonId.value : this.sonId;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rAssistedMemory2Fragments,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

/// [AppInfos]
extension AppInfoExt on AppInfo {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// createdAt updatedAt 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<AppInfo> reset({
    required Value<String> token,
    required Value<bool> hasDownloadedInitData,
    required SyncTag? writeSyncTag,
  }) async {
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

/// [Syncs]
extension SyncExt on Sync {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// createdAt updatedAt 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<Sync> reset({
    required Value<String> syncTableName,
    required Value<String> rowId,
    required Value<SyncCurdType?> syncCurdType,
    required Value<int> tag,
    required SyncTag? writeSyncTag,
  }) async {
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
