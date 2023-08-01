// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// CrtGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

/// 这个类在创建表对象时，可以让每个 column 都能被编辑器提示，以防遗漏。
///
/// id createdAt updatedAt 已经在 [DriftSyncExt.insertReturningWith] 中自动更新了。
///
/// 使用方式查看 [withRefs]。
class Crt {
  Crt._();
  static KnowledgeBaseCategorysCompanion knowledgeBaseCategorysCompanion({
    required String categorys,
    DateTime? created_at,
    Value<int>? id,
    DateTime? updated_at,
  }) {
    return KnowledgeBaseCategorysCompanion(
      categorys: Value(categorys),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : id,
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static ClientSyncInfosCompanion clientSyncInfosCompanion({
    required String device_info,
    required Value<DateTime?> recent_sync_time,
    required Value<String?> token,
    DateTime? created_at,
    Value<int>? id,
    DateTime? updated_at,
  }) {
    return ClientSyncInfosCompanion(
      device_info: Value(device_info),
      recent_sync_time: recent_sync_time,
      token: token,
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : id,
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static SyncsCompanion syncsCompanion({
    required String row_id,
    required SyncCurdType sync_curd_type,
    required String sync_table_name,
    required int tag,
    DateTime? created_at,
    Value<int>? id,
    DateTime? updated_at,
  }) {
    return SyncsCompanion(
      row_id: Value(row_id),
      sync_curd_type: Value(sync_curd_type),
      sync_table_name: Value(sync_table_name),
      tag: Value(tag),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : id,
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static FragmentMemoryInfosCompanion fragmentMemoryInfosCompanion({
    required String actual_show_time,
    required String button_values,
    required String click_familiarity,
    required String click_time,
    required String click_value,
    required String content_value,
    required int creator_user_id,
    required String fragment_id,
    required String memory_group_id,
    required String next_plan_show_time,
    required String show_familiarity,
    required StudyStatus study_status,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return FragmentMemoryInfosCompanion(
      actual_show_time: Value(actual_show_time),
      button_values: Value(button_values),
      click_familiarity: Value(click_familiarity),
      click_time: Value(click_time),
      click_value: Value(click_value),
      content_value: Value(content_value),
      creator_user_id: Value(creator_user_id),
      fragment_id: Value(fragment_id),
      memory_group_id: Value(memory_group_id),
      next_plan_show_time: Value(next_plan_show_time),
      show_familiarity: Value(show_familiarity),
      study_status: Value(study_status),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static FragmentGroupTagsCompanion fragmentGroupTagsCompanion({
    required String fragment_group_id,
    required String tag,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return FragmentGroupTagsCompanion(
      fragment_group_id: Value(fragment_group_id),
      tag: Value(tag),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static RFragment2FragmentGroupsCompanion rFragment2FragmentGroupsCompanion({
    required int creator_user_id,
    required Value<String?> fragment_group_id,
    required String fragment_id,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return RFragment2FragmentGroupsCompanion(
      creator_user_id: Value(creator_user_id),
      fragment_group_id: fragment_group_id,
      fragment_id: Value(fragment_id),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static Test2sCompanion test2sCompanion({
    required String client_content,
    DateTime? created_at,
    Value<int>? id,
    DateTime? updated_at,
  }) {
    return Test2sCompanion(
      client_content: Value(client_content),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : id,
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static TestsCompanion testsCompanion({
    required String client_a,
    required String client_content,
    DateTime? created_at,
    Value<int>? id,
    DateTime? updated_at,
  }) {
    return TestsCompanion(
      client_a: Value(client_a),
      client_content: Value(client_content),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : id,
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static FragmentsCompanion fragmentsCompanion({
    required bool be_sep_publish,
    required bool client_be_selected,
    required String content,
    required int creator_user_id,
    required Value<String?> father_fragment_id,
    required String title,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return FragmentsCompanion(
      be_sep_publish: Value(be_sep_publish),
      client_be_selected: Value(client_be_selected),
      content: Value(content),
      creator_user_id: Value(creator_user_id),
      father_fragment_id: father_fragment_id,
      title: Value(title),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static MemoryGroupsCompanion memoryGroupsCompanion({
    required int creator_user_id,
    required Value<String?> memory_model_id,
    required NewDisplayOrder new_display_order,
    required NewReviewDisplayOrder new_review_display_order,
    required ReviewDisplayOrder review_display_order,
    required DateTime review_interval,
    required Value<DateTime?> start_time,
    required String title,
    required int will_new_learn_count,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return MemoryGroupsCompanion(
      creator_user_id: Value(creator_user_id),
      memory_model_id: memory_model_id,
      new_display_order: Value(new_display_order),
      new_review_display_order: Value(new_review_display_order),
      review_display_order: Value(review_display_order),
      review_interval: Value(review_interval),
      start_time: start_time,
      title: Value(title),
      will_new_learn_count: Value(will_new_learn_count),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static MemoryModelsCompanion memoryModelsCompanion({
    required Value<String?> button_algorithm_a,
    required Value<String?> button_algorithm_b,
    required Value<String?> button_algorithm_c,
    required Value<String?> button_algorithm_remark,
    required AlgorithmUsageStatus button_algorithm_usage_status,
    required int creator_user_id,
    required Value<String?> familiarity_algorithm_a,
    required Value<String?> familiarity_algorithm_b,
    required Value<String?> familiarity_algorithm_c,
    required Value<String?> familiarity_algorithm_remark,
    required AlgorithmUsageStatus familiarity_algorithm_usage_status,
    required Value<String?> father_memory_model_id,
    required Value<String?> next_time_algorithm_a,
    required Value<String?> next_time_algorithm_b,
    required Value<String?> next_time_algorithm_c,
    required Value<String?> next_time_algorithm_remark,
    required AlgorithmUsageStatus next_time_algorithm_usage_status,
    required String title,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return MemoryModelsCompanion(
      button_algorithm_a: button_algorithm_a,
      button_algorithm_b: button_algorithm_b,
      button_algorithm_c: button_algorithm_c,
      button_algorithm_remark: button_algorithm_remark,
      button_algorithm_usage_status: Value(button_algorithm_usage_status),
      creator_user_id: Value(creator_user_id),
      familiarity_algorithm_a: familiarity_algorithm_a,
      familiarity_algorithm_b: familiarity_algorithm_b,
      familiarity_algorithm_c: familiarity_algorithm_c,
      familiarity_algorithm_remark: familiarity_algorithm_remark,
      familiarity_algorithm_usage_status:
          Value(familiarity_algorithm_usage_status),
      father_memory_model_id: father_memory_model_id,
      next_time_algorithm_a: next_time_algorithm_a,
      next_time_algorithm_b: next_time_algorithm_b,
      next_time_algorithm_c: next_time_algorithm_c,
      next_time_algorithm_remark: next_time_algorithm_remark,
      next_time_algorithm_usage_status: Value(next_time_algorithm_usage_status),
      title: Value(title),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static ShorthandsCompanion shorthandsCompanion({
    required String content,
    required int creator_user_id,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return ShorthandsCompanion(
      content: Value(content),
      creator_user_id: Value(creator_user_id),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static FragmentGroupsCompanion fragmentGroupsCompanion({
    required bool be_private,
    required bool be_publish,
    required bool client_be_selected,
    required int creator_user_id,
    required Value<String?> father_fragment_groups_id,
    required String profile,
    required String title,
    DateTime? created_at,
    String? id,
    DateTime? updated_at,
  }) {
    return FragmentGroupsCompanion(
      be_private: Value(be_private),
      be_publish: Value(be_publish),
      client_be_selected: Value(client_be_selected),
      creator_user_id: Value(creator_user_id),
      father_fragment_groups_id: father_fragment_groups_id,
      profile: Value(profile),
      title: Value(title),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : Value(id),
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static UserCommentsCompanion userCommentsCompanion({
    required String comment_content,
    required int commentator_user_id,
    required Value<String?> fragment_group_id,
    required Value<String?> fragment_id,
    DateTime? created_at,
    Value<int>? id,
    DateTime? updated_at,
  }) {
    return UserCommentsCompanion(
      comment_content: Value(comment_content),
      commentator_user_id: Value(commentator_user_id),
      fragment_group_id: fragment_group_id,
      fragment_id: fragment_id,
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : id,
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static UserLikesCompanion userLikesCompanion({
    required Value<String?> fragment_group_id,
    required Value<String?> fragment_id,
    required int liker_user_id,
    DateTime? created_at,
    Value<int>? id,
    DateTime? updated_at,
  }) {
    return UserLikesCompanion(
      fragment_group_id: fragment_group_id,
      fragment_id: fragment_id,
      liker_user_id: Value(liker_user_id),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : id,
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }

  static UsersCompanion usersCompanion({
    required Value<int?> age,
    required Value<String?> email,
    required Value<String?> password,
    required Value<String?> phone,
    required String username,
    DateTime? created_at,
    Value<int>? id,
    DateTime? updated_at,
  }) {
    return UsersCompanion(
      age: age,
      email: email,
      password: password,
      phone: phone,
      username: Value(username),
      created_at: created_at == null ? const Value.absent() : Value(created_at),
      id: id == null ? const Value.absent() : id,
      updated_at: updated_at == null ? const Value.absent() : Value(updated_at),
    );
  }
}

extension KnowledgeBaseCategorysCompanionExt
    on KnowledgeBaseCategorysCompanion {
  Future<KnowledgeBaseCategory> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.knowledgeBaseCategorys,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension ClientSyncInfosCompanionExt on ClientSyncInfosCompanion {
  Future<ClientSyncInfo> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.clientSyncInfos,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension SyncsCompanionExt on SyncsCompanion {
  Future<Sync> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.syncs,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension FragmentMemoryInfosCompanionExt on FragmentMemoryInfosCompanion {
  Future<FragmentMemoryInfo> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.fragmentMemoryInfos,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension FragmentGroupTagsCompanionExt on FragmentGroupTagsCompanion {
  Future<FragmentGroupTag> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.fragmentGroupTags,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension RFragment2FragmentGroupsCompanionExt
    on RFragment2FragmentGroupsCompanion {
  Future<RFragment2FragmentGroup> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.rFragment2FragmentGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension Test2sCompanionExt on Test2sCompanion {
  Future<Test2> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.test2s,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension TestsCompanionExt on TestsCompanion {
  Future<Test> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.tests,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension FragmentsCompanionExt on FragmentsCompanion {
  Future<Fragment> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.fragments,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension MemoryGroupsCompanionExt on MemoryGroupsCompanion {
  Future<MemoryGroup> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.memoryGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension MemoryModelsCompanionExt on MemoryModelsCompanion {
  Future<MemoryModel> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.memoryModels,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension ShorthandsCompanionExt on ShorthandsCompanion {
  Future<Shorthand> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.shorthands,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension FragmentGroupsCompanionExt on FragmentGroupsCompanion {
  Future<FragmentGroup> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.fragmentGroups,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension UserCommentsCompanionExt on UserCommentsCompanion {
  Future<UserComment> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.userComments,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension UserLikesCompanionExt on UserLikesCompanion {
  Future<UserLike> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.userLikes,
      entity: this,
      syncTag: syncTag,
    );
  }
}

extension UsersCompanionExt on UsersCompanion {
  Future<User> insert({required SyncTag syncTag}) async {
    final ins = DriftDb.instance;
    return await ins.insertReturningWith(
      ins.users,
      entity: this,
      syncTag: syncTag,
    );
  }
}
