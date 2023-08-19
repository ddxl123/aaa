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

/// [ClientSyncInfos]
extension ClientSyncInfoExt on ClientSyncInfo {
  Future<void> delete({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.clientSyncInfos,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: false,
    );
  }

  Future<void> resetByEntity({
    required ClientSyncInfo clientSyncInfo,
    required SyncTag syncTag,
  }) async {
    await reset(
      device_info: clientSyncInfo.device_info.toValue(),
      recent_sync_time: clientSyncInfo.recent_sync_time.toValue(),
      token: clientSyncInfo.token.toValue(),
      syncTag: syncTag,
    );
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<ClientSyncInfo> reset({
    required Value<String> device_info,
    required Value<DateTime?> recent_sync_time,
    required Value<String?> token,
    required SyncTag syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (device_info.present && this.device_info != device_info.value) {
      isLocalModify = true;
      this.device_info = device_info.value;
    }

    if (recent_sync_time.present &&
        this.recent_sync_time != recent_sync_time.value) {
      isLocalModify = true;
      this.recent_sync_time = recent_sync_time.value;
    }

    if (token.present && this.token != token.value) {
      isLocalModify = true;
      this.token = token.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.clientSyncInfos,
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: false);
    }
    return this;
  }
}

/// [Syncs]
extension SyncExt on Sync {
  Future<void> delete({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.syncs,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: false,
    );
  }

  Future<void> resetByEntity({
    required Sync sync,
    required SyncTag syncTag,
  }) async {
    await reset(
      row_id: sync.row_id.toValue(),
      sync_curd_type: sync.sync_curd_type.toValue(),
      sync_table_name: sync.sync_table_name.toValue(),
      tag: sync.tag.toValue(),
      syncTag: syncTag,
    );
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<Sync> reset({
    required Value<String> row_id,
    required Value<SyncCurdType> sync_curd_type,
    required Value<String> sync_table_name,
    required Value<int> tag,
    required SyncTag syncTag,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (row_id.present && this.row_id != row_id.value) {
      isLocalModify = true;
      this.row_id = row_id.value;
    }

    if (sync_curd_type.present && this.sync_curd_type != sync_curd_type.value) {
      isLocalModify = true;
      this.sync_curd_type = sync_curd_type.value;
    }

    if (sync_table_name.present &&
        this.sync_table_name != sync_table_name.value) {
      isLocalModify = true;
      this.sync_table_name = sync_table_name.value;
    }

    if (tag.present && this.tag != tag.value) {
      isLocalModify = true;
      this.tag = tag.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.syncs,
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: false);
    }
    return this;
  }
}

/// [FragmentMemoryInfos]
extension FragmentMemoryInfoExt on FragmentMemoryInfo {
  Future<void> delete(
      {required SyncTag syncTag, required bool isCloudTableWithSync}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.fragmentMemoryInfos,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: isCloudTableWithSync,
    );
  }

  Future<void> resetByEntity({
    required FragmentMemoryInfo fragmentMemoryInfo,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await reset(
        actual_show_time: fragmentMemoryInfo.actual_show_time.toValue(),
        button_values: fragmentMemoryInfo.button_values.toValue(),
        click_familiarity: fragmentMemoryInfo.click_familiarity.toValue(),
        click_time: fragmentMemoryInfo.click_time.toValue(),
        click_value: fragmentMemoryInfo.click_value.toValue(),
        content_value: fragmentMemoryInfo.content_value.toValue(),
        creator_user_id: fragmentMemoryInfo.creator_user_id.toValue(),
        fragment_id: fragmentMemoryInfo.fragment_id.toValue(),
        memory_group_id: fragmentMemoryInfo.memory_group_id.toValue(),
        next_plan_show_time: fragmentMemoryInfo.next_plan_show_time.toValue(),
        show_familiarity: fragmentMemoryInfo.show_familiarity.toValue(),
        study_status: fragmentMemoryInfo.study_status.toValue(),
        syncTag: syncTag,
        isCloudTableWithSync: isCloudTableWithSync);
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<FragmentMemoryInfo> reset({
    required Value<String> actual_show_time,
    required Value<String> button_values,
    required Value<String> click_familiarity,
    required Value<String> click_time,
    required Value<String> click_value,
    required Value<String> content_value,
    required Value<int> creator_user_id,
    required Value<String> fragment_id,
    required Value<String> memory_group_id,
    required Value<String> next_plan_show_time,
    required Value<String> show_familiarity,
    required Value<StudyStatus> study_status,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (actual_show_time.present &&
        this.actual_show_time != actual_show_time.value) {
      isCloudModify = true;
      this.actual_show_time = actual_show_time.value;
    }

    if (button_values.present && this.button_values != button_values.value) {
      isCloudModify = true;
      this.button_values = button_values.value;
    }

    if (click_familiarity.present &&
        this.click_familiarity != click_familiarity.value) {
      isCloudModify = true;
      this.click_familiarity = click_familiarity.value;
    }

    if (click_time.present && this.click_time != click_time.value) {
      isCloudModify = true;
      this.click_time = click_time.value;
    }

    if (click_value.present && this.click_value != click_value.value) {
      isCloudModify = true;
      this.click_value = click_value.value;
    }

    if (content_value.present && this.content_value != content_value.value) {
      isCloudModify = true;
      this.content_value = content_value.value;
    }

    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
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

    if (study_status.present && this.study_status != study_status.value) {
      isCloudModify = true;
      this.study_status = study_status.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragmentMemoryInfos,
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync && isCloudModify);
    }
    return this;
  }
}

/// [FragmentGroupTags]
extension FragmentGroupTagExt on FragmentGroupTag {
  Future<void> delete(
      {required SyncTag syncTag, required bool isCloudTableWithSync}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.fragmentGroupTags,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: isCloudTableWithSync,
    );
  }

  Future<void> resetByEntity({
    required FragmentGroupTag fragmentGroupTag,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await reset(
        fragment_group_id: fragmentGroupTag.fragment_group_id.toValue(),
        tag: fragmentGroupTag.tag.toValue(),
        syncTag: syncTag,
        isCloudTableWithSync: isCloudTableWithSync);
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<FragmentGroupTag> reset({
    required Value<String> fragment_group_id,
    required Value<String> tag,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (fragment_group_id.present &&
        this.fragment_group_id != fragment_group_id.value) {
      isCloudModify = true;
      this.fragment_group_id = fragment_group_id.value;
    }

    if (tag.present && this.tag != tag.value) {
      isCloudModify = true;
      this.tag = tag.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragmentGroupTags,
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync && isCloudModify);
    }
    return this;
  }
}

/// [RFragment2FragmentGroups]
extension RFragment2FragmentGroupExt on RFragment2FragmentGroup {
  Future<void> delete(
      {required SyncTag syncTag, required bool isCloudTableWithSync}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.rFragment2FragmentGroups,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: isCloudTableWithSync,
    );
  }

  Future<void> resetByEntity({
    required RFragment2FragmentGroup rFragment2FragmentGroup,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await reset(
        client_be_selected:
            rFragment2FragmentGroup.client_be_selected.toValue(),
        creator_user_id: rFragment2FragmentGroup.creator_user_id.toValue(),
        fragment_group_id: rFragment2FragmentGroup.fragment_group_id.toValue(),
        fragment_id: rFragment2FragmentGroup.fragment_id.toValue(),
        syncTag: syncTag,
        isCloudTableWithSync: isCloudTableWithSync);
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<RFragment2FragmentGroup> reset({
    required Value<bool> client_be_selected,
    required Value<int> creator_user_id,
    required Value<String?> fragment_group_id,
    required Value<String> fragment_id,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
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
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync && isCloudModify);
    }
    return this;
  }
}

/// [Test2s]
extension Test2Ext on Test2 {
  Future<void> delete(
      {required SyncTag syncTag, required bool isCloudTableWithSync}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.test2s,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: isCloudTableWithSync,
    );
  }

  Future<void> resetByEntity({
    required Test2 test2,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await reset(
        client_content: test2.client_content.toValue(),
        syncTag: syncTag,
        isCloudTableWithSync: isCloudTableWithSync);
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<Test2> reset({
    required Value<String> client_content,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
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
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync && isCloudModify);
    }
    return this;
  }
}

/// [Tests]
extension TestExt on Test {
  Future<void> delete(
      {required SyncTag syncTag, required bool isCloudTableWithSync}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.tests,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: isCloudTableWithSync,
    );
  }

  Future<void> resetByEntity({
    required Test test,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await reset(
        client_a: test.client_a.toValue(),
        client_content: test.client_content.toValue(),
        syncTag: syncTag,
        isCloudTableWithSync: isCloudTableWithSync);
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<Test> reset({
    required Value<String> client_a,
    required Value<String> client_content,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
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
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync && isCloudModify);
    }
    return this;
  }
}

/// [Fragments]
extension FragmentExt on Fragment {
  Future<void> delete(
      {required SyncTag syncTag, required bool isCloudTableWithSync}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.fragments,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: isCloudTableWithSync,
    );
  }

  Future<void> resetByEntity({
    required Fragment fragment,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await reset(
        be_sep_publish: fragment.be_sep_publish.toValue(),
        content: fragment.content.toValue(),
        creator_user_id: fragment.creator_user_id.toValue(),
        father_fragment_id: fragment.father_fragment_id.toValue(),
        title: fragment.title.toValue(),
        syncTag: syncTag,
        isCloudTableWithSync: isCloudTableWithSync);
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<Fragment> reset({
    required Value<bool> be_sep_publish,
    required Value<String> content,
    required Value<int> creator_user_id,
    required Value<String?> father_fragment_id,
    required Value<String> title,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (be_sep_publish.present && this.be_sep_publish != be_sep_publish.value) {
      isCloudModify = true;
      this.be_sep_publish = be_sep_publish.value;
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

    if (title.present && this.title != title.value) {
      isCloudModify = true;
      this.title = title.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragments,
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync && isCloudModify);
    }
    return this;
  }
}

/// [MemoryGroups]
extension MemoryGroupExt on MemoryGroup {
  Future<void> delete(
      {required SyncTag syncTag, required bool isCloudTableWithSync}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.memoryGroups,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: isCloudTableWithSync,
    );
  }

  Future<void> resetByEntity({
    required MemoryGroup memoryGroup,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await reset(
        creator_user_id: memoryGroup.creator_user_id.toValue(),
        memory_model_id: memoryGroup.memory_model_id.toValue(),
        new_display_order: memoryGroup.new_display_order.toValue(),
        new_review_display_order:
            memoryGroup.new_review_display_order.toValue(),
        review_display_order: memoryGroup.review_display_order.toValue(),
        review_interval: memoryGroup.review_interval.toValue(),
        start_time: memoryGroup.start_time.toValue(),
        title: memoryGroup.title.toValue(),
        will_new_learn_count: memoryGroup.will_new_learn_count.toValue(),
        syncTag: syncTag,
        isCloudTableWithSync: isCloudTableWithSync);
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<MemoryGroup> reset({
    required Value<int> creator_user_id,
    required Value<String?> memory_model_id,
    required Value<NewDisplayOrder> new_display_order,
    required Value<NewReviewDisplayOrder> new_review_display_order,
    required Value<ReviewDisplayOrder> review_display_order,
    required Value<DateTime> review_interval,
    required Value<DateTime?> start_time,
    required Value<String> title,
    required Value<int> will_new_learn_count,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
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

    if (review_display_order.present &&
        this.review_display_order != review_display_order.value) {
      isCloudModify = true;
      this.review_display_order = review_display_order.value;
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
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync && isCloudModify);
    }
    return this;
  }
}

/// [MemoryModels]
extension MemoryModelExt on MemoryModel {
  Future<void> delete(
      {required SyncTag syncTag, required bool isCloudTableWithSync}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.memoryModels,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: isCloudTableWithSync,
    );
  }

  Future<void> resetByEntity({
    required MemoryModel memoryModel,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await reset(
        button_algorithm_a: memoryModel.button_algorithm_a.toValue(),
        button_algorithm_b: memoryModel.button_algorithm_b.toValue(),
        button_algorithm_c: memoryModel.button_algorithm_c.toValue(),
        button_algorithm_remark: memoryModel.button_algorithm_remark.toValue(),
        button_algorithm_usage_status:
            memoryModel.button_algorithm_usage_status.toValue(),
        creator_user_id: memoryModel.creator_user_id.toValue(),
        familiarity_algorithm_a: memoryModel.familiarity_algorithm_a.toValue(),
        familiarity_algorithm_b: memoryModel.familiarity_algorithm_b.toValue(),
        familiarity_algorithm_c: memoryModel.familiarity_algorithm_c.toValue(),
        familiarity_algorithm_remark:
            memoryModel.familiarity_algorithm_remark.toValue(),
        familiarity_algorithm_usage_status:
            memoryModel.familiarity_algorithm_usage_status.toValue(),
        father_memory_model_id: memoryModel.father_memory_model_id.toValue(),
        next_time_algorithm_a: memoryModel.next_time_algorithm_a.toValue(),
        next_time_algorithm_b: memoryModel.next_time_algorithm_b.toValue(),
        next_time_algorithm_c: memoryModel.next_time_algorithm_c.toValue(),
        next_time_algorithm_remark:
            memoryModel.next_time_algorithm_remark.toValue(),
        next_time_algorithm_usage_status:
            memoryModel.next_time_algorithm_usage_status.toValue(),
        title: memoryModel.title.toValue(),
        syncTag: syncTag,
        isCloudTableWithSync: isCloudTableWithSync);
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<MemoryModel> reset({
    required Value<String?> button_algorithm_a,
    required Value<String?> button_algorithm_b,
    required Value<String?> button_algorithm_c,
    required Value<String?> button_algorithm_remark,
    required Value<AlgorithmUsageStatus> button_algorithm_usage_status,
    required Value<int> creator_user_id,
    required Value<String?> familiarity_algorithm_a,
    required Value<String?> familiarity_algorithm_b,
    required Value<String?> familiarity_algorithm_c,
    required Value<String?> familiarity_algorithm_remark,
    required Value<AlgorithmUsageStatus> familiarity_algorithm_usage_status,
    required Value<String?> father_memory_model_id,
    required Value<String?> next_time_algorithm_a,
    required Value<String?> next_time_algorithm_b,
    required Value<String?> next_time_algorithm_c,
    required Value<String?> next_time_algorithm_remark,
    required Value<AlgorithmUsageStatus> next_time_algorithm_usage_status,
    required Value<String> title,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (button_algorithm_a.present &&
        this.button_algorithm_a != button_algorithm_a.value) {
      isCloudModify = true;
      this.button_algorithm_a = button_algorithm_a.value;
    }

    if (button_algorithm_b.present &&
        this.button_algorithm_b != button_algorithm_b.value) {
      isCloudModify = true;
      this.button_algorithm_b = button_algorithm_b.value;
    }

    if (button_algorithm_c.present &&
        this.button_algorithm_c != button_algorithm_c.value) {
      isCloudModify = true;
      this.button_algorithm_c = button_algorithm_c.value;
    }

    if (button_algorithm_remark.present &&
        this.button_algorithm_remark != button_algorithm_remark.value) {
      isCloudModify = true;
      this.button_algorithm_remark = button_algorithm_remark.value;
    }

    if (button_algorithm_usage_status.present &&
        this.button_algorithm_usage_status !=
            button_algorithm_usage_status.value) {
      isCloudModify = true;
      this.button_algorithm_usage_status = button_algorithm_usage_status.value;
    }

    if (creator_user_id.present &&
        this.creator_user_id != creator_user_id.value) {
      isCloudModify = true;
      this.creator_user_id = creator_user_id.value;
    }

    if (familiarity_algorithm_a.present &&
        this.familiarity_algorithm_a != familiarity_algorithm_a.value) {
      isCloudModify = true;
      this.familiarity_algorithm_a = familiarity_algorithm_a.value;
    }

    if (familiarity_algorithm_b.present &&
        this.familiarity_algorithm_b != familiarity_algorithm_b.value) {
      isCloudModify = true;
      this.familiarity_algorithm_b = familiarity_algorithm_b.value;
    }

    if (familiarity_algorithm_c.present &&
        this.familiarity_algorithm_c != familiarity_algorithm_c.value) {
      isCloudModify = true;
      this.familiarity_algorithm_c = familiarity_algorithm_c.value;
    }

    if (familiarity_algorithm_remark.present &&
        this.familiarity_algorithm_remark !=
            familiarity_algorithm_remark.value) {
      isCloudModify = true;
      this.familiarity_algorithm_remark = familiarity_algorithm_remark.value;
    }

    if (familiarity_algorithm_usage_status.present &&
        this.familiarity_algorithm_usage_status !=
            familiarity_algorithm_usage_status.value) {
      isCloudModify = true;
      this.familiarity_algorithm_usage_status =
          familiarity_algorithm_usage_status.value;
    }

    if (father_memory_model_id.present &&
        this.father_memory_model_id != father_memory_model_id.value) {
      isCloudModify = true;
      this.father_memory_model_id = father_memory_model_id.value;
    }

    if (next_time_algorithm_a.present &&
        this.next_time_algorithm_a != next_time_algorithm_a.value) {
      isCloudModify = true;
      this.next_time_algorithm_a = next_time_algorithm_a.value;
    }

    if (next_time_algorithm_b.present &&
        this.next_time_algorithm_b != next_time_algorithm_b.value) {
      isCloudModify = true;
      this.next_time_algorithm_b = next_time_algorithm_b.value;
    }

    if (next_time_algorithm_c.present &&
        this.next_time_algorithm_c != next_time_algorithm_c.value) {
      isCloudModify = true;
      this.next_time_algorithm_c = next_time_algorithm_c.value;
    }

    if (next_time_algorithm_remark.present &&
        this.next_time_algorithm_remark != next_time_algorithm_remark.value) {
      isCloudModify = true;
      this.next_time_algorithm_remark = next_time_algorithm_remark.value;
    }

    if (next_time_algorithm_usage_status.present &&
        this.next_time_algorithm_usage_status !=
            next_time_algorithm_usage_status.value) {
      isCloudModify = true;
      this.next_time_algorithm_usage_status =
          next_time_algorithm_usage_status.value;
    }

    if (title.present && this.title != title.value) {
      isCloudModify = true;
      this.title = title.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.memoryModels,
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync && isCloudModify);
    }
    return this;
  }
}

/// [Shorthands]
extension ShorthandExt on Shorthand {
  Future<void> delete(
      {required SyncTag syncTag, required bool isCloudTableWithSync}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.shorthands,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: isCloudTableWithSync,
    );
  }

  Future<void> resetByEntity({
    required Shorthand shorthand,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await reset(
        content: shorthand.content.toValue(),
        creator_user_id: shorthand.creator_user_id.toValue(),
        syncTag: syncTag,
        isCloudTableWithSync: isCloudTableWithSync);
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<Shorthand> reset({
    required Value<String> content,
    required Value<int> creator_user_id,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
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
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync && isCloudModify);
    }
    return this;
  }
}

/// [FragmentGroups]
extension FragmentGroupExt on FragmentGroup {
  Future<void> delete(
      {required SyncTag syncTag, required bool isCloudTableWithSync}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.fragmentGroups,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: isCloudTableWithSync,
    );
  }

  Future<void> resetByEntity({
    required FragmentGroup fragmentGroup,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await reset(
        be_publish: fragmentGroup.be_publish.toValue(),
        client_be_cloud_path_upload:
            fragmentGroup.client_be_cloud_path_upload.toValue(),
        client_be_selected: fragmentGroup.client_be_selected.toValue(),
        client_cover_local_path:
            fragmentGroup.client_cover_local_path.toValue(),
        cover_cloud_path: fragmentGroup.cover_cloud_path.toValue(),
        creator_user_id: fragmentGroup.creator_user_id.toValue(),
        father_fragment_groups_id:
            fragmentGroup.father_fragment_groups_id.toValue(),
        jump_to_fragment_groups_id:
            fragmentGroup.jump_to_fragment_groups_id.toValue(),
        profile: fragmentGroup.profile.toValue(),
        title: fragmentGroup.title.toValue(),
        syncTag: syncTag,
        isCloudTableWithSync: isCloudTableWithSync);
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<FragmentGroup> reset({
    required Value<bool> be_publish,
    required Value<bool> client_be_cloud_path_upload,
    required Value<bool> client_be_selected,
    required Value<String?> client_cover_local_path,
    required Value<String?> cover_cloud_path,
    required Value<int> creator_user_id,
    required Value<String?> father_fragment_groups_id,
    required Value<String?> jump_to_fragment_groups_id,
    required Value<String> profile,
    required Value<String> title,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (be_publish.present && this.be_publish != be_publish.value) {
      isCloudModify = true;
      this.be_publish = be_publish.value;
    }

    if (client_be_cloud_path_upload.present &&
        this.client_be_cloud_path_upload != client_be_cloud_path_upload.value) {
      isCloudModify = true;
      this.client_be_cloud_path_upload = client_be_cloud_path_upload.value;
    }

    if (client_be_selected.present &&
        this.client_be_selected != client_be_selected.value) {
      isCloudModify = true;
      this.client_be_selected = client_be_selected.value;
    }

    if (client_cover_local_path.present &&
        this.client_cover_local_path != client_cover_local_path.value) {
      isCloudModify = true;
      this.client_cover_local_path = client_cover_local_path.value;
    }

    if (cover_cloud_path.present &&
        this.cover_cloud_path != cover_cloud_path.value) {
      isCloudModify = true;
      this.cover_cloud_path = cover_cloud_path.value;
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

    if (jump_to_fragment_groups_id.present &&
        this.jump_to_fragment_groups_id != jump_to_fragment_groups_id.value) {
      isCloudModify = true;
      this.jump_to_fragment_groups_id = jump_to_fragment_groups_id.value;
    }

    if (profile.present && this.profile != profile.value) {
      isCloudModify = true;
      this.profile = profile.value;
    }

    if (title.present && this.title != title.value) {
      isCloudModify = true;
      this.title = title.value;
    }

    if (isCloudModify || isLocalModify) {
      final ins = DriftDb.instance;
      await ins.updateReturningWith(ins.fragmentGroups,
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync && isCloudModify);
    }
    return this;
  }
}

/// [UserComments]
extension UserCommentExt on UserComment {
  Future<void> delete(
      {required SyncTag syncTag, required bool isCloudTableWithSync}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.userComments,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: isCloudTableWithSync,
    );
  }

  Future<void> resetByEntity({
    required UserComment userComment,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await reset(
        comment_content: userComment.comment_content.toValue(),
        commentator_user_id: userComment.commentator_user_id.toValue(),
        fragment_group_id: userComment.fragment_group_id.toValue(),
        fragment_id: userComment.fragment_id.toValue(),
        syncTag: syncTag,
        isCloudTableWithSync: isCloudTableWithSync);
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<UserComment> reset({
    required Value<String> comment_content,
    required Value<int> commentator_user_id,
    required Value<String?> fragment_group_id,
    required Value<String?> fragment_id,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
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
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync && isCloudModify);
    }
    return this;
  }
}

/// [UserLikes]
extension UserLikeExt on UserLike {
  Future<void> delete(
      {required SyncTag syncTag, required bool isCloudTableWithSync}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.userLikes,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: isCloudTableWithSync,
    );
  }

  Future<void> resetByEntity({
    required UserLike userLike,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await reset(
        fragment_group_id: userLike.fragment_group_id.toValue(),
        fragment_id: userLike.fragment_id.toValue(),
        liker_user_id: userLike.liker_user_id.toValue(),
        syncTag: syncTag,
        isCloudTableWithSync: isCloudTableWithSync);
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<UserLike> reset({
    required Value<String?> fragment_group_id,
    required Value<String?> fragment_id,
    required Value<int> liker_user_id,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
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
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync && isCloudModify);
    }
    return this;
  }
}

/// [Users]
extension UserExt on User {
  Future<void> delete(
      {required SyncTag syncTag, required bool isCloudTableWithSync}) async {
    final ins = DriftDb.instance;
    await ins.deleteWith(
      ins.users,
      entity: this,
      syncTag: syncTag,
      isCloudTableWithSync: isCloudTableWithSync,
    );
  }

  Future<void> resetByEntity({
    required User user,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    await reset(
        age: user.age.toValue(),
        avatar_cloud_path: user.avatar_cloud_path.toValue(),
        client_avatar_local_path: user.client_avatar_local_path.toValue(),
        email: user.email.toValue(),
        password: user.password.toValue(),
        phone: user.phone.toValue(),
        username: user.username.toValue(),
        syncTag: syncTag,
        isCloudTableWithSync: isCloudTableWithSync);
  }

  /// 将传入的新数据覆盖掉旧数据类实例。
  ///
  /// 值覆写方式：[DriftValueExt]
  ///
  /// 只能修改当前 id 的行。
  ///
  /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
  FutureOr<User> reset({
    required Value<int?> age,
    required Value<String?> avatar_cloud_path,
    required Value<String?> client_avatar_local_path,
    required Value<String?> email,
    required Value<String?> password,
    required Value<String?> phone,
    required Value<String> username,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    bool isCloudModify = false;
    bool isLocalModify = false;
    if (age.present && this.age != age.value) {
      isCloudModify = true;
      this.age = age.value;
    }

    if (avatar_cloud_path.present &&
        this.avatar_cloud_path != avatar_cloud_path.value) {
      isCloudModify = true;
      this.avatar_cloud_path = avatar_cloud_path.value;
    }

    if (client_avatar_local_path.present &&
        this.client_avatar_local_path != client_avatar_local_path.value) {
      isCloudModify = true;
      this.client_avatar_local_path = client_avatar_local_path.value;
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
          entity: toCompanion(false),
          syncTag: syncTag,
          isCloudTableWithSync: isCloudTableWithSync && isCloudModify);
    }
    return this;
  }
}
