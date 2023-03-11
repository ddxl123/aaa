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

/// [KnowledgeBaseCategorys]
extension KnowledgeBaseCategoryExt on KnowledgeBaseCategory {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<KnowledgeBaseCategory> reset({
    required Value<String> categorys,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (categorys.present && this.categorys != categorys.value) {
      isCloudModify = true;
      this.categorys = categorys.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.knowledgeBaseCategorys,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
    }
    return this;
  }
}

/// [ClientSyncInfos]
extension ClientSyncInfoExt on ClientSyncInfo {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<ClientSyncInfo> reset({
    required Value<String> device_info,
    required Value<DateTime?> recent_sync_time,
    required Value<String?> token,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (device_info.present && this.device_info != device_info.value) {
      isCloudModify = true;
      this.device_info = device_info.value;
    }

    if (recent_sync_time.present &&
        this.recent_sync_time != recent_sync_time.value) {
      isCloudModify = true;
      this.recent_sync_time = recent_sync_time.value;
    }

    if (token.present && this.token != token.value) {
      isCloudModify = true;
      this.token = token.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.clientSyncInfos,
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<Sync> reset({
    required Value<String> row_id,
    required Value<SyncCurdType> sync_curd_type,
    required Value<String> sync_table_name,
    required Value<int> tag,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (row_id.present && this.row_id != row_id.value) {
      isCloudModify = true;
      this.row_id = row_id.value;
    }

    if (sync_curd_type.present && this.sync_curd_type != sync_curd_type.value) {
      isCloudModify = true;
      this.sync_curd_type = sync_curd_type.value;
    }

    if (sync_table_name.present &&
        this.sync_table_name != sync_table_name.value) {
      isCloudModify = true;
      this.sync_table_name = sync_table_name.value;
    }

    if (tag.present && this.tag != tag.value) {
      isCloudModify = true;
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

/// [FragmentMemoryInfos]
extension FragmentMemoryInfoExt on FragmentMemoryInfo {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<FragmentMemoryInfo> reset({
    required Value<String?> click_time,
    required Value<String?> click_value,
    required Value<int> creator_user_id,
    required Value<String?> current_actual_show_time,
    required Value<String> fragment_id,
    required Value<String> memory_group_id,
    required Value<String?> next_plan_show_time,
    required Value<String?> show_familiarity,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (click_time.present && this.click_time != click_time.value) {
      isCloudModify = true;
      this.click_time = click_time.value;
    }

    if (click_value.present && this.click_value != click_value.value) {
      isCloudModify = true;
      this.click_value = click_value.value;
    }

    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (current_actual_show_time.present &&
        this.current_actual_show_time != current_actual_show_time.value) {
      isCloudModify = true;
      this.current_actual_show_time = current_actual_show_time.value;
    }

    if (fragment_id.present && this.fragment_id != fragment_id.value) {
      isCloudModify = true;
      this.fragment_id = fragment_id.value;
    }

    if (memory_group_id.present &&
        this.memory_group_id != memory_group_id.value) {
      isCloudModify = true;
      this.memory_group_id = memory_group_id.value;
    }

    if (next_plan_show_time.present &&
        this.next_plan_show_time != next_plan_show_time.value) {
      isCloudModify = true;
      this.next_plan_show_time = next_plan_show_time.value;
    }

    if (show_familiarity.present &&
        this.show_familiarity != show_familiarity.value) {
      isCloudModify = true;
      this.show_familiarity = show_familiarity.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragmentMemoryInfos,
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<RDocument2DocumentGroup> reset({
    required Value<int> creator_user_id,
    required Value<String?> document_group_id,
    required Value<String> document_id,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (document_group_id.present &&
        this.document_group_id != document_group_id.value) {
      isCloudModify = true;
      this.document_group_id = document_group_id.value;
    }

    if (document_id.present && this.document_id != document_id.value) {
      isCloudModify = true;
      this.document_id = document_id.value;
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<RFragment2FragmentGroup> reset({
    required Value<int> creator_user_id,
    required Value<String?> fragment_group_id,
    required Value<String> fragment_id,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (fragment_group_id.present &&
        this.fragment_group_id != fragment_group_id.value) {
      isCloudModify = true;
      this.fragment_group_id = fragment_group_id.value;
    }

    if (fragment_id.present && this.fragment_id != fragment_id.value) {
      isCloudModify = true;
      this.fragment_id = fragment_id.value;
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<RNote2NoteGroup> reset({
    required Value<int> creator_user_id,
    required Value<String?> note_group_id,
    required Value<String> note_id,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (note_group_id.present && this.note_group_id != note_group_id.value) {
      isCloudModify = true;
      this.note_group_id = note_group_id.value;
    }

    if (note_id.present && this.note_id != note_id.value) {
      isCloudModify = true;
      this.note_id = note_id.value;
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<Test2> reset({
    required Value<String> client_content,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (client_content.present && this.client_content != client_content.value) {
      isCloudModify = true;
      this.client_content = client_content.value;
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<Test> reset({
    required Value<String> client_a,
    required Value<String> client_content,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (client_a.present && this.client_a != client_a.value) {
      isCloudModify = true;
      this.client_a = client_a.value;
    }

    if (client_content.present && this.client_content != client_content.value) {
      isCloudModify = true;
      this.client_content = client_content.value;
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<Document> reset({
    required Value<String> content,
    required Value<int> creator_user_id,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (content.present && this.content != content.value) {
      isCloudModify = true;
      this.content = content.value;
    }

    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.documents,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
    }
    return this;
  }
}

/// [FragmentTemplates]
extension FragmentTemplateExt on FragmentTemplate {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<FragmentTemplate> reset({
    required Value<String> content,
    required Value<int> owner_user_id,
    required Value<FragmentTemplateType> type,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (content.present && this.content != content.value) {
      isCloudModify = true;
      this.content = content.value;
    }

    if (owner_user_id.present && this.owner_user_id != owner_user_id.value) {
      isCloudModify = true;
      this.owner_user_id = owner_user_id.value;
    }

    if (type.present && this.type != type.value) {
      isCloudModify = true;
      this.type = type.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragmentTemplates,
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<Fragment> reset({
    required Value<bool> be_sep_publish,
    required Value<bool> client_be_selected,
    required Value<String> content,
    required Value<int> creator_user_id,
    required Value<String?> father_fragment_id,
    required Value<String?> fragment_template_id,
    required Value<String?> note_id,
    required Value<String> tags,
    required Value<String> title,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (be_sep_publish.present && this.be_sep_publish != be_sep_publish.value) {
      isCloudModify = true;
      this.be_sep_publish = be_sep_publish.value;
    }

    if (client_be_selected.present &&
        this.client_be_selected != client_be_selected.value) {
      isCloudModify = true;
      this.client_be_selected = client_be_selected.value;
    }

    if (content.present && this.content != content.value) {
      isCloudModify = true;
      this.content = content.value;
    }

    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (father_fragment_id.present &&
        this.father_fragment_id != father_fragment_id.value) {
      isCloudModify = true;
      this.father_fragment_id = father_fragment_id.value;
    }

    if (fragment_template_id.present &&
        this.fragment_template_id != fragment_template_id.value) {
      isCloudModify = true;
      this.fragment_template_id = fragment_template_id.value;
    }

    if (note_id.present && this.note_id != note_id.value) {
      isCloudModify = true;
      this.note_id = note_id.value;
    }

    if (tags.present && this.tags != tags.value) {
      isCloudModify = true;
      this.tags = tags.value;
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<MemoryGroup> reset({
    required Value<int> creator_user_id,
    required Value<String?> memory_model_id,
    required Value<NewDisplayOrder> new_display_order,
    required Value<NewReviewDisplayOrder> new_review_display_order,
    required Value<DateTime> review_interval,
    required Value<DateTime?> start_time,
    required Value<String> title,
    required Value<int> will_new_learn_count,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (memory_model_id.present &&
        this.memory_model_id != memory_model_id.value) {
      isCloudModify = true;
      this.memory_model_id = memory_model_id.value;
    }

    if (new_display_order.present &&
        this.new_display_order != new_display_order.value) {
      isCloudModify = true;
      this.new_display_order = new_display_order.value;
    }

    if (new_review_display_order.present &&
        this.new_review_display_order != new_review_display_order.value) {
      isCloudModify = true;
      this.new_review_display_order = new_review_display_order.value;
    }

    if (review_interval.present &&
        this.review_interval != review_interval.value) {
      isCloudModify = true;
      this.review_interval = review_interval.value;
    }

    if (start_time.present && this.start_time != start_time.value) {
      isCloudModify = true;
      this.start_time = start_time.value;
    }

    if (title.present && this.title != title.value) {
      isCloudModify = true;
      this.title = title.value;
    }

    if (will_new_learn_count.present &&
        this.will_new_learn_count != will_new_learn_count.value) {
      isCloudModify = true;
      this.will_new_learn_count = will_new_learn_count.value;
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<MemoryModel> reset({
    required Value<String?> button_algorithm,
    required Value<int> creator_user_id,
    required Value<String?> familiarity_algorithm,
    required Value<String?> father_memory_model_id,
    required Value<String?> modified_button_algorithm,
    required Value<String?> modified_familiarity_algorithm,
    required Value<String?> modified_next_time_algorithm,
    required Value<String?> next_time_algorithm,
    required Value<String> title,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (button_algorithm.present &&
        this.button_algorithm != button_algorithm.value) {
      isCloudModify = true;
      this.button_algorithm = button_algorithm.value;
    }

    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (familiarity_algorithm.present &&
        this.familiarity_algorithm != familiarity_algorithm.value) {
      isCloudModify = true;
      this.familiarity_algorithm = familiarity_algorithm.value;
    }

    if (father_memory_model_id.present &&
        this.father_memory_model_id != father_memory_model_id.value) {
      isCloudModify = true;
      this.father_memory_model_id = father_memory_model_id.value;
    }

    if (modified_button_algorithm.present &&
        this.modified_button_algorithm != modified_button_algorithm.value) {
      isCloudModify = true;
      this.modified_button_algorithm = modified_button_algorithm.value;
    }

    if (modified_familiarity_algorithm.present &&
        this.modified_familiarity_algorithm !=
            modified_familiarity_algorithm.value) {
      isCloudModify = true;
      this.modified_familiarity_algorithm =
          modified_familiarity_algorithm.value;
    }

    if (modified_next_time_algorithm.present &&
        this.modified_next_time_algorithm !=
            modified_next_time_algorithm.value) {
      isCloudModify = true;
      this.modified_next_time_algorithm = modified_next_time_algorithm.value;
    }

    if (next_time_algorithm.present &&
        this.next_time_algorithm != next_time_algorithm.value) {
      isCloudModify = true;
      this.next_time_algorithm = next_time_algorithm.value;
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<Note> reset({
    required Value<String> content,
    required Value<int> creator_user_id,
    required Value<String?> document_id,
    required Value<String?> father_note_id,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (content.present && this.content != content.value) {
      isCloudModify = true;
      this.content = content.value;
    }

    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (document_id.present && this.document_id != document_id.value) {
      isCloudModify = true;
      this.document_id = document_id.value;
    }

    if (father_note_id.present && this.father_note_id != father_note_id.value) {
      isCloudModify = true;
      this.father_note_id = father_note_id.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.notes,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
    }
    return this;
  }
}

/// [Shorthands]
extension ShorthandExt on Shorthand {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<Shorthand> reset({
    required Value<String> content,
    required Value<int> creator_user_id,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (content.present && this.content != content.value) {
      isCloudModify = true;
      this.content = content.value;
    }

    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.shorthands,
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<DocumentGroup> reset({
    required Value<int> creator_user_id,
    required Value<String?> father_document_groups_id,
    required Value<String> title,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (father_document_groups_id.present &&
        this.father_document_groups_id != father_document_groups_id.value) {
      isCloudModify = true;
      this.father_document_groups_id = father_document_groups_id.value;
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<FragmentGroup> reset({
    required Value<bool> be_private,
    required Value<bool> be_publish,
    required Value<bool> client_be_selected,
    required Value<int> creator_user_id,
    required Value<String?> father_fragment_groups_id,
    required Value<String> tags,
    required Value<String> title,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (be_private.present && this.be_private != be_private.value) {
      isCloudModify = true;
      this.be_private = be_private.value;
    }

    if (be_publish.present && this.be_publish != be_publish.value) {
      isCloudModify = true;
      this.be_publish = be_publish.value;
    }

    if (client_be_selected.present &&
        this.client_be_selected != client_be_selected.value) {
      isCloudModify = true;
      this.client_be_selected = client_be_selected.value;
    }

    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (father_fragment_groups_id.present &&
        this.father_fragment_groups_id != father_fragment_groups_id.value) {
      isCloudModify = true;
      this.father_fragment_groups_id = father_fragment_groups_id.value;
    }

    if (tags.present && this.tags != tags.value) {
      isCloudModify = true;
      this.tags = tags.value;
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<NoteGroup> reset({
    required Value<int> creator_user_id,
    required Value<String?> father_note_groups_id,
    required Value<String> title,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (father_note_groups_id.present &&
        this.father_note_groups_id != father_note_groups_id.value) {
      isCloudModify = true;
      this.father_note_groups_id = father_note_groups_id.value;
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

/// [UserComments]
extension UserCommentExt on UserComment {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<UserComment> reset({
    required Value<String> comment_content,
    required Value<int> commentator_user_id,
    required Value<String?> fragment_group_id,
    required Value<String?> fragment_id,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (comment_content.present &&
        this.comment_content != comment_content.value) {
      isCloudModify = true;
      this.comment_content = comment_content.value;
    }

    if (commentator_user_id.present &&
        this.commentator_user_id != commentator_user_id.value) {
      isCloudModify = true;
      this.commentator_user_id = commentator_user_id.value;
    }

    if (fragment_group_id.present &&
        this.fragment_group_id != fragment_group_id.value) {
      isCloudModify = true;
      this.fragment_group_id = fragment_group_id.value;
    }

    if (fragment_id.present && this.fragment_id != fragment_id.value) {
      isCloudModify = true;
      this.fragment_id = fragment_id.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.userComments,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
    }
    return this;
  }
}

/// [UserLikes]
extension UserLikeExt on UserLike {
  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<UserLike> reset({
    required Value<String?> fragment_group_id,
    required Value<String?> fragment_id,
    required Value<int> liker_user_id,
    required SyncTag? syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (fragment_group_id.present &&
        this.fragment_group_id != fragment_group_id.value) {
      isCloudModify = true;
      this.fragment_group_id = fragment_group_id.value;
    }

    if (fragment_id.present && this.fragment_id != fragment_id.value) {
      isCloudModify = true;
      this.fragment_id = fragment_id.value;
    }

    if (liker_user_id.present && this.liker_user_id != liker_user_id.value) {
      isCloudModify = true;
      this.liker_user_id = liker_user_id.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.userLikes,
          entity: toCompanion(false), isSync: isCloudModify, syncTag: syncTag);
    }
    return this;
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
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  ///
  /// 若 [syncTag] 为空，内部会自动创建。
  ///
  /// 使用方式查看 [withRefs]。
  FutureOr<User> reset({
    required Value<int?> age,
    required Value<String?> email,
    required Value<String?> password,
    required Value<String?> phone,
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

    if (phone.present && this.phone != phone.value) {
      isCloudModify = true;
      this.phone = phone.value;
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
