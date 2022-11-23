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
    required Value<int?> age,
    required Value<String?> email,
    required Value<String?> password,
    required Value<String?> username,
    required SyncTag? writeSyncTag,
  }) async {
    this.age = age.present ? age.value : this.age;
    this.email = email.present ? email.value : this.email;
    this.password = password.present ? password.value : this.password;
    this.username = username.present ? username.value : this.username;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.users,
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
    required Value<int> clickTime,
    required Value<double> clickValue,
    required Value<int> creatorUserId,
    required Value<int> currentActualShowTime,
    required Value<int> fragmentId,
    required Value<bool> isLatestRecord,
    required Value<int> memoryGroupId,
    required Value<DateTime> nextPlanShowTime,
    required Value<double> showFamiliarity,
    required SyncTag? writeSyncTag,
  }) async {
    this.clickTime = clickTime.present ? clickTime.value : this.clickTime;
    this.clickValue = clickValue.present ? clickValue.value : this.clickValue;
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    this.currentActualShowTime = currentActualShowTime.present
        ? currentActualShowTime.value
        : this.currentActualShowTime;
    this.fragmentId = fragmentId.present ? fragmentId.value : this.fragmentId;
    this.isLatestRecord =
        isLatestRecord.present ? isLatestRecord.value : this.isLatestRecord;
    this.memoryGroupId =
        memoryGroupId.present ? memoryGroupId.value : this.memoryGroupId;
    this.nextPlanShowTime = nextPlanShowTime.present
        ? nextPlanShowTime.value
        : this.nextPlanShowTime;
    this.showFamiliarity =
        showFamiliarity.present ? showFamiliarity.value : this.showFamiliarity;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragmentMemoryInfos,
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
    required Value<int> creatorUserId,
    required Value<int?> memoryModelId,
    required Value<NewDisplayOrder?> newDisplayOrder,
    required Value<NewReviewDisplayOrder?> newReviewDisplayOrder,
    required Value<DateTime?> reviewInterval,
    required Value<DateTime?> startTime,
    required Value<String?> title,
    required Value<int?> willNewLearnCount,
    required SyncTag? writeSyncTag,
  }) async {
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    this.memoryModelId =
        memoryModelId.present ? memoryModelId.value : this.memoryModelId;
    this.newDisplayOrder =
        newDisplayOrder.present ? newDisplayOrder.value : this.newDisplayOrder;
    this.newReviewDisplayOrder = newReviewDisplayOrder.present
        ? newReviewDisplayOrder.value
        : this.newReviewDisplayOrder;
    this.reviewInterval =
        reviewInterval.present ? reviewInterval.value : this.reviewInterval;
    this.startTime = startTime.present ? startTime.value : this.startTime;
    this.title = title.present ? title.value : this.title;
    this.willNewLearnCount = willNewLearnCount.present
        ? willNewLearnCount.value
        : this.willNewLearnCount;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.memoryGroups,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

/// [RDocument2DocumentGroups]
extension RDocument2DocumentGroupExt on RDocument2DocumentGroup {
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
  FutureOr<RDocument2DocumentGroup> reset({
    required Value<int> creatorUserId,
    required Value<int?> documentGroupId,
    required Value<int> documentId,
    required SyncTag? writeSyncTag,
  }) async {
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    this.documentGroupId =
        documentGroupId.present ? documentGroupId.value : this.documentGroupId;
    this.documentId = documentId.present ? documentId.value : this.documentId;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rDocument2DocumentGroups,
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
    required Value<int> creatorUserId,
    required Value<int> fragmentGroupId,
    required Value<int> fragmentId,
    required SyncTag? writeSyncTag,
  }) async {
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    this.fragmentGroupId =
        fragmentGroupId.present ? fragmentGroupId.value : this.fragmentGroupId;
    this.fragmentId = fragmentId.present ? fragmentId.value : this.fragmentId;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rFragment2FragmentGroups,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

/// [RMemoryModel2MemoryModelGroups]
extension RMemoryModel2MemoryModelGroupExt on RMemoryModel2MemoryModelGroup {
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
  FutureOr<RMemoryModel2MemoryModelGroup> reset({
    required Value<int> creatorUserId,
    required Value<int> memoryModelGroupId,
    required Value<int> memoryModelId,
    required SyncTag? writeSyncTag,
  }) async {
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    this.memoryModelGroupId = memoryModelGroupId.present
        ? memoryModelGroupId.value
        : this.memoryModelGroupId;
    this.memoryModelId =
        memoryModelId.present ? memoryModelId.value : this.memoryModelId;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rMemoryModel2MemoryModelGroups,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

/// [RNote2NoteGroups]
extension RNote2NoteGroupExt on RNote2NoteGroup {
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
  FutureOr<RNote2NoteGroup> reset({
    required Value<int> creatorUserId,
    required Value<int> noteGroupId,
    required Value<int> noteId,
    required SyncTag? writeSyncTag,
  }) async {
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    this.noteGroupId =
        noteGroupId.present ? noteGroupId.value : this.noteGroupId;
    this.noteId = noteId.present ? noteId.value : this.noteId;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rNote2NoteGroups,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

/// [Documents]
extension DocumentExt on Document {
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
  FutureOr<Document> reset({
    required Value<String?> content,
    required Value<int> creatorUserId,
    required SyncTag? writeSyncTag,
  }) async {
    this.content = content.present ? content.value : this.content;
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.documents,
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
    required Value<String?> content,
    required Value<int> creatorUserId,
    required Value<int?> fatherFragmentId,
    required Value<int?> noteId,
    required SyncTag? writeSyncTag,
  }) async {
    this.content = content.present ? content.value : this.content;
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    this.fatherFragmentId = fatherFragmentId.present
        ? fatherFragmentId.value
        : this.fatherFragmentId;
    this.noteId = noteId.present ? noteId.value : this.noteId;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragments,
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
    required Value<String?> applicableFields,
    required Value<String?> applicableGroups,
    required Value<String?> buttonAlgorithm,
    required Value<int> creatorUserId,
    required Value<String?> familiarityAlgorithm,
    required Value<int?> fatherFragmentId,
    required Value<String?> nextTimeAlgorithm,
    required Value<String?> stimulateAlgorithm,
    required Value<String?> title,
    required SyncTag? writeSyncTag,
  }) async {
    this.applicableFields = applicableFields.present
        ? applicableFields.value
        : this.applicableFields;
    this.applicableGroups = applicableGroups.present
        ? applicableGroups.value
        : this.applicableGroups;
    this.buttonAlgorithm =
        buttonAlgorithm.present ? buttonAlgorithm.value : this.buttonAlgorithm;
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    this.familiarityAlgorithm = familiarityAlgorithm.present
        ? familiarityAlgorithm.value
        : this.familiarityAlgorithm;
    this.fatherFragmentId = fatherFragmentId.present
        ? fatherFragmentId.value
        : this.fatherFragmentId;
    this.nextTimeAlgorithm = nextTimeAlgorithm.present
        ? nextTimeAlgorithm.value
        : this.nextTimeAlgorithm;
    this.stimulateAlgorithm = stimulateAlgorithm.present
        ? stimulateAlgorithm.value
        : this.stimulateAlgorithm;
    this.title = title.present ? title.value : this.title;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.memoryModels,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

/// [Notes]
extension NoteExt on Note {
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
  FutureOr<Note> reset({
    required Value<String?> content,
    required Value<int> creatorUserId,
    required Value<int?> documentId,
    required Value<int?> fatherNoteId,
    required SyncTag? writeSyncTag,
  }) async {
    this.content = content.present ? content.value : this.content;
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    this.documentId = documentId.present ? documentId.value : this.documentId;
    this.fatherNoteId =
        fatherNoteId.present ? fatherNoteId.value : this.fatherNoteId;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.notes,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

/// [DocumentGroups]
extension DocumentGroupExt on DocumentGroup {
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
  FutureOr<DocumentGroup> reset({
    required Value<int> creatorUserId,
    required Value<int?> fatherDocumentGroupsId,
    required Value<String?> title,
    required SyncTag? writeSyncTag,
  }) async {
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    this.fatherDocumentGroupsId = fatherDocumentGroupsId.present
        ? fatherDocumentGroupsId.value
        : this.fatherDocumentGroupsId;
    this.title = title.present ? title.value : this.title;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.documentGroups,
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
    required Value<int> creatorUserId,
    required Value<int?> fatherFragmentGroupsId,
    required Value<String?> title,
    required SyncTag? writeSyncTag,
  }) async {
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    this.fatherFragmentGroupsId = fatherFragmentGroupsId.present
        ? fatherFragmentGroupsId.value
        : this.fatherFragmentGroupsId;
    this.title = title.present ? title.value : this.title;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragmentGroups,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

/// [MemoryModelGroups]
extension MemoryModelGroupExt on MemoryModelGroup {
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
  FutureOr<MemoryModelGroup> reset({
    required Value<int> creatorUserId,
    required Value<int?> fatherMemoryModelGroupsId,
    required Value<String?> title,
    required SyncTag? writeSyncTag,
  }) async {
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    this.fatherMemoryModelGroupsId = fatherMemoryModelGroupsId.present
        ? fatherMemoryModelGroupsId.value
        : this.fatherMemoryModelGroupsId;
    this.title = title.present ? title.value : this.title;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.memoryModelGroups,
          entity: toCompanion(false), syncTag: writeSyncTag);
    }
    return this;
  }
}

/// [NoteGroups]
extension NoteGroupExt on NoteGroup {
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
  FutureOr<NoteGroup> reset({
    required Value<int> creatorUserId,
    required Value<int?> fatherNoteGroupsId,
    required Value<String?> title,
    required SyncTag? writeSyncTag,
  }) async {
    this.creatorUserId =
        creatorUserId.present ? creatorUserId.value : this.creatorUserId;
    this.fatherNoteGroupsId = fatherNoteGroupsId.present
        ? fatherNoteGroupsId.value
        : this.fatherNoteGroupsId;
    this.title = title.present ? title.value : this.title;
    if (writeSyncTag != null) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.noteGroups,
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
