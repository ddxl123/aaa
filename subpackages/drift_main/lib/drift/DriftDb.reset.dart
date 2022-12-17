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
    if (age.present && this.age != age.value) {
      isCloudModify = true;
      this.age = age.value;
    }

    if (email.present && this.email != email.value) {
      isCloudModify = true;
      this.email = email.value;
    }

    if (password.present && this.password != password.value) {
      isCloudModify = true;
      this.password = password.value;
    }

    if (username.present && this.username != username.value) {
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
    required Value<String?> clickTime,
    required Value<String?> clickValue,
    required Value<int> creatorUserId,
    required Value<String?> currentActualShowTime,
    required Value<String> fragmentId,
    required Value<String> memoryGroupId,
    required Value<String?> nextPlanShowTime,
    required Value<String?> showFamiliarity,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (clickTime.present && this.clickTime != clickTime.value) {
      isCloudModify = true;
      this.clickTime = clickTime.value;
    }

    if (clickValue.present && this.clickValue != clickValue.value) {
      isCloudModify = true;
      this.clickValue = clickValue.value;
    }

    if (creatorUserId.present && this.creatorUserId != creatorUserId.value) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (currentActualShowTime.present &&
        this.currentActualShowTime != currentActualShowTime.value) {
      isCloudModify = true;
      this.currentActualShowTime = currentActualShowTime.value;
    }

    if (fragmentId.present && this.fragmentId != fragmentId.value) {
      isCloudModify = true;
      this.fragmentId = fragmentId.value;
    }

    if (memoryGroupId.present && this.memoryGroupId != memoryGroupId.value) {
      isCloudModify = true;
      this.memoryGroupId = memoryGroupId.value;
    }

    if (nextPlanShowTime.present &&
        this.nextPlanShowTime != nextPlanShowTime.value) {
      isCloudModify = true;
      this.nextPlanShowTime = nextPlanShowTime.value;
    }

    if (showFamiliarity.present &&
        this.showFamiliarity != showFamiliarity.value) {
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
    if (hasDownloadedInitData.present &&
        this.hasDownloadedInitData != hasDownloadedInitData.value) {
      isLocalModify = true;
      this.hasDownloadedInitData = hasDownloadedInitData.value;
    }

    if (token.present && this.token != token.value) {
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
    if (rowId.present && this.rowId != rowId.value) {
      isLocalModify = true;
      this.rowId = rowId.value;
    }

    if (syncCurdType.present && this.syncCurdType != syncCurdType.value) {
      isLocalModify = true;
      this.syncCurdType = syncCurdType.value;
    }

    if (syncTableName.present && this.syncTableName != syncTableName.value) {
      isLocalModify = true;
      this.syncTableName = syncTableName.value;
    }

    if (tag.present && this.tag != tag.value) {
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
    if (creatorUserId.present && this.creatorUserId != creatorUserId.value) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (documentGroupId.present &&
        this.documentGroupId != documentGroupId.value) {
      isCloudModify = true;
      this.documentGroupId = documentGroupId.value;
    }

    if (documentId.present && this.documentId != documentId.value) {
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
    if (creatorUserId.present && this.creatorUserId != creatorUserId.value) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (fragmentGroupId.present &&
        this.fragmentGroupId != fragmentGroupId.value) {
      isCloudModify = true;
      this.fragmentGroupId = fragmentGroupId.value;
    }

    if (fragmentId.present && this.fragmentId != fragmentId.value) {
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
    if (creatorUserId.present && this.creatorUserId != creatorUserId.value) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (noteGroupId.present && this.noteGroupId != noteGroupId.value) {
      isCloudModify = true;
      this.noteGroupId = noteGroupId.value;
    }

    if (noteId.present && this.noteId != noteId.value) {
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

/// [Test2s]
extension Test2Ext on Test2 {
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
  FutureOr<Test2> reset({
    required Value<String> local_content,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (local_content.present && this.local_content != local_content.value) {
      isLocalModify = true;
      this.local_content = local_content.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.test2s,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
    }
    return this;
  }
}

/// [Tests]
extension TestExt on Test {
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
  FutureOr<Test> reset({
    required Value<String> local_content,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (local_content.present && this.local_content != local_content.value) {
      isLocalModify = true;
      this.local_content = local_content.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.tests,
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
    if (content.present && this.content != content.value) {
      isCloudModify = true;
      this.content = content.value;
    }

    if (creatorUserId.present && this.creatorUserId != creatorUserId.value) {
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
    required Value<String> title,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (content.present && this.content != content.value) {
      isCloudModify = true;
      this.content = content.value;
    }

    if (creatorUserId.present && this.creatorUserId != creatorUserId.value) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (fatherFragmentId.present &&
        this.fatherFragmentId != fatherFragmentId.value) {
      isCloudModify = true;
      this.fatherFragmentId = fatherFragmentId.value;
    }

    if (local_isSelected.present &&
        this.local_isSelected != local_isSelected.value) {
      isLocalModify = true;
      this.local_isSelected = local_isSelected.value;
    }

    if (noteId.present && this.noteId != noteId.value) {
      isCloudModify = true;
      this.noteId = noteId.value;
    }

    if (title.present && this.title != title.value) {
      isCloudModify = true;
      this.title = title.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragments,
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
    if (creatorUserId.present && this.creatorUserId != creatorUserId.value) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (memoryModelId.present && this.memoryModelId != memoryModelId.value) {
      isCloudModify = true;
      this.memoryModelId = memoryModelId.value;
    }

    if (newDisplayOrder.present &&
        this.newDisplayOrder != newDisplayOrder.value) {
      isCloudModify = true;
      this.newDisplayOrder = newDisplayOrder.value;
    }

    if (newReviewDisplayOrder.present &&
        this.newReviewDisplayOrder != newReviewDisplayOrder.value) {
      isCloudModify = true;
      this.newReviewDisplayOrder = newReviewDisplayOrder.value;
    }

    if (reviewInterval.present && this.reviewInterval != reviewInterval.value) {
      isCloudModify = true;
      this.reviewInterval = reviewInterval.value;
    }

    if (startTime.present && this.startTime != startTime.value) {
      isCloudModify = true;
      this.startTime = startTime.value;
    }

    if (title.present && this.title != title.value) {
      isCloudModify = true;
      this.title = title.value;
    }

    if (willNewLearnCount.present &&
        this.willNewLearnCount != willNewLearnCount.value) {
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
    required Value<String> title,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (buttonAlgorithm.present &&
        this.buttonAlgorithm != buttonAlgorithm.value) {
      isCloudModify = true;
      this.buttonAlgorithm = buttonAlgorithm.value;
    }

    if (creatorUserId.present && this.creatorUserId != creatorUserId.value) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (familiarityAlgorithm.present &&
        this.familiarityAlgorithm != familiarityAlgorithm.value) {
      isCloudModify = true;
      this.familiarityAlgorithm = familiarityAlgorithm.value;
    }

    if (fatherMemoryModelId.present &&
        this.fatherMemoryModelId != fatherMemoryModelId.value) {
      isCloudModify = true;
      this.fatherMemoryModelId = fatherMemoryModelId.value;
    }

    if (nextTimeAlgorithm.present &&
        this.nextTimeAlgorithm != nextTimeAlgorithm.value) {
      isCloudModify = true;
      this.nextTimeAlgorithm = nextTimeAlgorithm.value;
    }

    if (title.present && this.title != title.value) {
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
    if (content.present && this.content != content.value) {
      isCloudModify = true;
      this.content = content.value;
    }

    if (creatorUserId.present && this.creatorUserId != creatorUserId.value) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (documentId.present && this.documentId != documentId.value) {
      isCloudModify = true;
      this.documentId = documentId.value;
    }

    if (fatherNoteId.present && this.fatherNoteId != fatherNoteId.value) {
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
    if (creatorUserId.present && this.creatorUserId != creatorUserId.value) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (fatherDocumentGroupsId.present &&
        this.fatherDocumentGroupsId != fatherDocumentGroupsId.value) {
      isCloudModify = true;
      this.fatherDocumentGroupsId = fatherDocumentGroupsId.value;
    }

    if (title.present && this.title != title.value) {
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
    if (creatorUserId.present && this.creatorUserId != creatorUserId.value) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (fatherFragmentGroupsId.present &&
        this.fatherFragmentGroupsId != fatherFragmentGroupsId.value) {
      isCloudModify = true;
      this.fatherFragmentGroupsId = fatherFragmentGroupsId.value;
    }

    if (local_isSelected.present &&
        this.local_isSelected != local_isSelected.value) {
      isLocalModify = true;
      this.local_isSelected = local_isSelected.value;
    }

    if (title.present && this.title != title.value) {
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
    if (creatorUserId.present && this.creatorUserId != creatorUserId.value) {
      isCloudModify = true;
      this.creatorUserId = creatorUserId.value;
    }

    if (fatherNoteGroupsId.present &&
        this.fatherNoteGroupsId != fatherNoteGroupsId.value) {
      isCloudModify = true;
      this.fatherNoteGroupsId = fatherNoteGroupsId.value;
    }

    if (title.present && this.title != title.value) {
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
