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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<User> reset({
    required Value<int> age,
    required Value<String?> email,
    required Value<String?> password,
    required Value<String> username,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.age != age.value && age.present) {
      isCloudModify = true;
      this.age = age.value;
    }

    if (this.email != email.value && email.present) {
      isCloudModify = true;
      this.email = email.value;
    }

    if (this.password != password.value && password.present) {
      isCloudModify = true;
      this.password = password.value;
    }

    if (this.username != username.value && username.present) {
      isCloudModify = true;
      this.username = username.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.users,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<FragmentMemoryInfo> reset({
    required Value<DateTime> clickTime,
    required Value<double> clickValue,
    required Value<int> creatorUserId,
    required Value<DateTime> currentActualShowTime,
    required Value<String> fragmentId,
    required Value<bool> isLatestRecord,
    required Value<String> memoryGroupId,
    required Value<DateTime> nextPlanShowTime,
    required Value<double> showFamiliarity,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.clickTime != clickTime.value && clickTime.present) {
      isCloudModify = true;
      this.clickTime = clickTime.value;
    }

    if (this.clickValue != clickValue.value && clickValue.present) {
      isCloudModify = true;
      this.clickValue = clickValue.value;
    }

    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (this.currentActualShowTime != currentActualShowTime.value &&
        currentActualShowTime.present) {
      isCloudModify = true;
      this.currentActualShowTime = currentActualShowTime.value;
    }

    if (this.fragmentId != fragmentId.value && fragmentId.present) {
      isCloudModify = true;
      this.fragmentId = fragmentId.value;
    }

    if (this.isLatestRecord != isLatestRecord.value && isLatestRecord.present) {
      isCloudModify = true;
      this.isLatestRecord = isLatestRecord.value;
    }

    if (this.memoryGroupId != memoryGroupId.value && memoryGroupId.present) {
      isCloudModify = true;
      this.memoryGroupId = memoryGroupId.value;
    }

    if (this.nextPlanShowTime != nextPlanShowTime.value &&
        nextPlanShowTime.present) {
      isCloudModify = true;
      this.nextPlanShowTime = nextPlanShowTime.value;
    }

    if (this.showFamiliarity != showFamiliarity.value &&
        showFamiliarity.present) {
      isCloudModify = true;
      this.showFamiliarity = showFamiliarity.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragmentMemoryInfos,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<AppInfo> reset({
    required Value<bool> hasDownloadedInitData,
    required Value<String> token,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.hasDownloadedInitData != hasDownloadedInitData.value &&
        hasDownloadedInitData.present) {
      isLocalModify = true;
      this.hasDownloadedInitData = hasDownloadedInitData.value;
    }

    if (this.token != token.value && token.present) {
      isLocalModify = true;
      this.token = token.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.appInfos,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<Sync> reset({
    required Value<String> rowId,
    required Value<SyncCurdType> syncCurdType,
    required Value<String> syncTableName,
    required Value<int> tag,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.rowId != rowId.value && rowId.present) {
      isLocalModify = true;
      this.rowId = rowId.value;
    }

    if (this.syncCurdType != syncCurdType.value && syncCurdType.present) {
      isLocalModify = true;
      this.syncCurdType = syncCurdType.value;
    }

    if (this.syncTableName != syncTableName.value && syncTableName.present) {
      isLocalModify = true;
      this.syncTableName = syncTableName.value;
    }

    if (this.tag != tag.value && tag.present) {
      isLocalModify = true;
      this.tag = tag.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.syncs,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<MemoryGroup> reset({
    required Value<int> creatorUserId,
    required Value<String?> memoryModelId,
    required Value<NewDisplayOrder> newDisplayOrder,
    required Value<NewReviewDisplayOrder> newReviewDisplayOrder,
    required Value<DateTime> reviewInterval,
    required Value<DateTime?> startTime,
    required Value<String> title,
    required Value<int> willNewLearnCount,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (this.memoryModelId != memoryModelId.value && memoryModelId.present) {
      isCloudModify = true;
      this.memoryModelId = memoryModelId.value;
    }

    if (this.newDisplayOrder != newDisplayOrder.value &&
        newDisplayOrder.present) {
      isCloudModify = true;
      this.newDisplayOrder = newDisplayOrder.value;
    }

    if (this.newReviewDisplayOrder != newReviewDisplayOrder.value &&
        newReviewDisplayOrder.present) {
      isCloudModify = true;
      this.newReviewDisplayOrder = newReviewDisplayOrder.value;
    }

    if (this.reviewInterval != reviewInterval.value && reviewInterval.present) {
      isCloudModify = true;
      this.reviewInterval = reviewInterval.value;
    }

    if (this.startTime != startTime.value && startTime.present) {
      isCloudModify = true;
      this.startTime = startTime.value;
    }

    if (this.title != title.value && title.present) {
      isCloudModify = true;
      this.title = title.value;
    }

    if (this.willNewLearnCount != willNewLearnCount.value &&
        willNewLearnCount.present) {
      isCloudModify = true;
      this.willNewLearnCount = willNewLearnCount.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.memoryGroups,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<RDocument2DocumentGroup> reset({
    required Value<int> creatorUserId,
    required Value<String?> documentGroupId,
    required Value<String> documentId,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (this.documentGroupId != documentGroupId.value &&
        documentGroupId.present) {
      isCloudModify = true;
      this.documentGroupId = documentGroupId.value;
    }

    if (this.documentId != documentId.value && documentId.present) {
      isCloudModify = true;
      this.documentId = documentId.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rDocument2DocumentGroups,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<RFragment2FragmentGroup> reset({
    required Value<int> creatorUserId,
    required Value<String?> fragmentGroupId,
    required Value<String> fragmentId,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (this.fragmentGroupId != fragmentGroupId.value &&
        fragmentGroupId.present) {
      isCloudModify = true;
      this.fragmentGroupId = fragmentGroupId.value;
    }

    if (this.fragmentId != fragmentId.value && fragmentId.present) {
      isCloudModify = true;
      this.fragmentId = fragmentId.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rFragment2FragmentGroups,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<RMemoryModel2MemoryModelGroup> reset({
    required Value<int> creatorUserId,
    required Value<String?> memoryModelGroupId,
    required Value<String> memoryModelId,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (this.memoryModelGroupId != memoryModelGroupId.value &&
        memoryModelGroupId.present) {
      isCloudModify = true;
      this.memoryModelGroupId = memoryModelGroupId.value;
    }

    if (this.memoryModelId != memoryModelId.value && memoryModelId.present) {
      isCloudModify = true;
      this.memoryModelId = memoryModelId.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rMemoryModel2MemoryModelGroups,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<RNote2NoteGroup> reset({
    required Value<int> creatorUserId,
    required Value<String?> noteGroupId,
    required Value<String> noteId,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (this.noteGroupId != noteGroupId.value && noteGroupId.present) {
      isCloudModify = true;
      this.noteGroupId = noteGroupId.value;
    }

    if (this.noteId != noteId.value && noteId.present) {
      isCloudModify = true;
      this.noteId = noteId.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.rNote2NoteGroups,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<Document> reset({
    required Value<String> content,
    required Value<int> creatorUserId,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.content != content.value && content.present) {
      isCloudModify = true;
      this.content = content.value;
    }

    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.documents,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<Fragment> reset({
    required Value<String> content,
    required Value<int> creatorUserId,
    required Value<String?> fatherFragmentId,
    required Value<bool> local_isSelected,
    required Value<String?> noteId,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.content != content.value && content.present) {
      isCloudModify = true;
      this.content = content.value;
    }

    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (this.fatherFragmentId != fatherFragmentId.value &&
        fatherFragmentId.present) {
      isCloudModify = true;
      this.fatherFragmentId = fatherFragmentId.value;
    }

    if (this.local_isSelected != local_isSelected.value &&
        local_isSelected.present) {
      isLocalModify = true;
      this.local_isSelected = local_isSelected.value;
    }

    if (this.noteId != noteId.value && noteId.present) {
      isCloudModify = true;
      this.noteId = noteId.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragments,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<MemoryModel> reset({
    required Value<String> buttonAlgorithm,
    required Value<int> creatorUserId,
    required Value<String> familiarityAlgorithm,
    required Value<String?> fatherMemoryModelId,
    required Value<String> nextTimeAlgorithm,
    required Value<String> stimulateAlgorithm,
    required Value<String> title,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.buttonAlgorithm != buttonAlgorithm.value &&
        buttonAlgorithm.present) {
      isCloudModify = true;
      this.buttonAlgorithm = buttonAlgorithm.value;
    }

    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (this.familiarityAlgorithm != familiarityAlgorithm.value &&
        familiarityAlgorithm.present) {
      isCloudModify = true;
      this.familiarityAlgorithm = familiarityAlgorithm.value;
    }

    if (this.fatherMemoryModelId != fatherMemoryModelId.value &&
        fatherMemoryModelId.present) {
      isCloudModify = true;
      this.fatherMemoryModelId = fatherMemoryModelId.value;
    }

    if (this.nextTimeAlgorithm != nextTimeAlgorithm.value &&
        nextTimeAlgorithm.present) {
      isCloudModify = true;
      this.nextTimeAlgorithm = nextTimeAlgorithm.value;
    }

    if (this.stimulateAlgorithm != stimulateAlgorithm.value &&
        stimulateAlgorithm.present) {
      isCloudModify = true;
      this.stimulateAlgorithm = stimulateAlgorithm.value;
    }

    if (this.title != title.value && title.present) {
      isCloudModify = true;
      this.title = title.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.memoryModels,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<Note> reset({
    required Value<String> content,
    required Value<int> creatorUserId,
    required Value<String?> documentId,
    required Value<String?> fatherNoteId,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.content != content.value && content.present) {
      isCloudModify = true;
      this.content = content.value;
    }

    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (this.documentId != documentId.value && documentId.present) {
      isCloudModify = true;
      this.documentId = documentId.value;
    }

    if (this.fatherNoteId != fatherNoteId.value && fatherNoteId.present) {
      isCloudModify = true;
      this.fatherNoteId = fatherNoteId.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.notes,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<DocumentGroup> reset({
    required Value<int> creatorUserId,
    required Value<String?> fatherDocumentGroupsId,
    required Value<String> title,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (this.fatherDocumentGroupsId != fatherDocumentGroupsId.value &&
        fatherDocumentGroupsId.present) {
      isCloudModify = true;
      this.fatherDocumentGroupsId = fatherDocumentGroupsId.value;
    }

    if (this.title != title.value && title.present) {
      isCloudModify = true;
      this.title = title.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.documentGroups,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<FragmentGroup> reset({
    required Value<int> creatorUserId,
    required Value<String?> fatherFragmentGroupsId,
    required Value<bool> local_isSelected,
    required Value<String> title,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (this.fatherFragmentGroupsId != fatherFragmentGroupsId.value &&
        fatherFragmentGroupsId.present) {
      isCloudModify = true;
      this.fatherFragmentGroupsId = fatherFragmentGroupsId.value;
    }

    if (this.local_isSelected != local_isSelected.value &&
        local_isSelected.present) {
      isLocalModify = true;
      this.local_isSelected = local_isSelected.value;
    }

    if (this.title != title.value && title.present) {
      isCloudModify = true;
      this.title = title.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragmentGroups,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<MemoryModelGroup> reset({
    required Value<int> creatorUserId,
    required Value<String?> fatherMemoryModelGroupsId,
    required Value<String> title,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (this.fatherMemoryModelGroupsId != fatherMemoryModelGroupsId.value &&
        fatherMemoryModelGroupsId.present) {
      isCloudModify = true;
      this.fatherMemoryModelGroupsId = fatherMemoryModelGroupsId.value;
    }

    if (this.title != title.value && title.present) {
      isCloudModify = true;
      this.title = title.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.memoryModelGroups,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
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
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<NoteGroup> reset({
    required Value<int> creatorUserId,
    required Value<String?> fatherNoteGroupsId,
    required Value<String> title,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (this.creatorUserId != creatorUserId.value && creatorUserId.present) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (this.fatherNoteGroupsId != fatherNoteGroupsId.value &&
        fatherNoteGroupsId.present) {
      isCloudModify = true;
      this.fatherNoteGroupsId = fatherNoteGroupsId.value;
    }

    if (this.title != title.value && title.present) {
      isCloudModify = true;
      this.title = title.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.noteGroups,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
    }
    return this;
  }
}
