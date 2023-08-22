// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// CrtGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names
part of drift_db;

class Crt {
  Crt._();
  static ClientSyncInfo clientSyncInfoEntity({
    required String device_info,
    required String? token,
  }) {
    return ClientSyncInfo(
      device_info: device_info,
      token: token,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static Sync syncEntity({
    required int row_id,
    required SyncCurdType sync_curd_type,
    required String sync_table_name,
    required int tag,
  }) {
    return Sync(
      row_id: row_id,
      sync_curd_type: sync_curd_type,
      sync_table_name: sync_table_name,
      tag: tag,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static FragmentMemoryInfo fragmentMemoryInfoEntity({
    required String actual_show_time,
    required String button_values,
    required String click_familiarity,
    required String click_time,
    required String click_value,
    required String content_value,
    required int creator_user_id,
    required int fragment_id,
    required int memory_group_id,
    required String next_plan_show_time,
    required String show_familiarity,
    required StudyStatus study_status,
  }) {
    return FragmentMemoryInfo(
      actual_show_time: actual_show_time,
      button_values: button_values,
      click_familiarity: click_familiarity,
      click_time: click_time,
      click_value: click_value,
      content_value: content_value,
      creator_user_id: creator_user_id,
      fragment_id: fragment_id,
      memory_group_id: memory_group_id,
      next_plan_show_time: next_plan_show_time,
      show_familiarity: show_familiarity,
      study_status: study_status,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static FragmentGroupTag fragmentGroupTagEntity({
    required int fragment_group_id,
    required String tag,
  }) {
    return FragmentGroupTag(
      fragment_group_id: fragment_group_id,
      tag: tag,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static RFragment2FragmentGroup rFragment2FragmentGroupEntity({
    required bool client_be_selected,
    required int creator_user_id,
    required int? fragment_group_id,
    required int fragment_id,
  }) {
    return RFragment2FragmentGroup(
      client_be_selected: client_be_selected,
      creator_user_id: creator_user_id,
      fragment_group_id: fragment_group_id,
      fragment_id: fragment_id,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static Test2 test2Entity({
    required String client_content,
  }) {
    return Test2(
      client_content: client_content,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static Test testEntity({
    required String client_a,
    required String client_content,
  }) {
    return Test(
      client_a: client_a,
      client_content: client_content,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static Fragment fragmentEntity({
    required bool be_sep_publish,
    required String content,
    required int creator_user_id,
    required int? father_fragment_id,
    required String title,
  }) {
    return Fragment(
      be_sep_publish: be_sep_publish,
      content: content,
      creator_user_id: creator_user_id,
      father_fragment_id: father_fragment_id,
      title: title,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static MemoryGroup memoryGroupEntity({
    required int creator_user_id,
    required int? memory_model_id,
    required NewDisplayOrder new_display_order,
    required NewReviewDisplayOrder new_review_display_order,
    required ReviewDisplayOrder review_display_order,
    required DateTime review_interval,
    required DateTime? start_time,
    required String title,
    required int will_new_learn_count,
  }) {
    return MemoryGroup(
      creator_user_id: creator_user_id,
      memory_model_id: memory_model_id,
      new_display_order: new_display_order,
      new_review_display_order: new_review_display_order,
      review_display_order: review_display_order,
      review_interval: review_interval,
      start_time: start_time,
      title: title,
      will_new_learn_count: will_new_learn_count,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static MemoryModel memoryModelEntity({
    required String? button_algorithm_a,
    required String? button_algorithm_b,
    required String? button_algorithm_c,
    required String? button_algorithm_remark,
    required AlgorithmUsageStatus button_algorithm_usage_status,
    required int creator_user_id,
    required String? familiarity_algorithm_a,
    required String? familiarity_algorithm_b,
    required String? familiarity_algorithm_c,
    required String? familiarity_algorithm_remark,
    required AlgorithmUsageStatus familiarity_algorithm_usage_status,
    required int? father_memory_model_id,
    required String? next_time_algorithm_a,
    required String? next_time_algorithm_b,
    required String? next_time_algorithm_c,
    required String? next_time_algorithm_remark,
    required AlgorithmUsageStatus next_time_algorithm_usage_status,
    required String title,
  }) {
    return MemoryModel(
      button_algorithm_a: button_algorithm_a,
      button_algorithm_b: button_algorithm_b,
      button_algorithm_c: button_algorithm_c,
      button_algorithm_remark: button_algorithm_remark,
      button_algorithm_usage_status: button_algorithm_usage_status,
      creator_user_id: creator_user_id,
      familiarity_algorithm_a: familiarity_algorithm_a,
      familiarity_algorithm_b: familiarity_algorithm_b,
      familiarity_algorithm_c: familiarity_algorithm_c,
      familiarity_algorithm_remark: familiarity_algorithm_remark,
      familiarity_algorithm_usage_status: familiarity_algorithm_usage_status,
      father_memory_model_id: father_memory_model_id,
      next_time_algorithm_a: next_time_algorithm_a,
      next_time_algorithm_b: next_time_algorithm_b,
      next_time_algorithm_c: next_time_algorithm_c,
      next_time_algorithm_remark: next_time_algorithm_remark,
      next_time_algorithm_usage_status: next_time_algorithm_usage_status,
      title: title,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static Shorthand shorthandEntity({
    required String content,
    required int creator_user_id,
  }) {
    return Shorthand(
      content: content,
      creator_user_id: creator_user_id,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static FragmentGroup fragmentGroupEntity({
    required bool be_publish,
    required bool client_be_cloud_path_upload,
    required bool client_be_selected,
    required String? client_cover_local_path,
    required String? cover_cloud_path,
    required int creator_user_id,
    required int? father_fragment_groups_id,
    required int? jump_to_fragment_groups_id,
    required String profile,
    required String title,
  }) {
    return FragmentGroup(
      be_publish: be_publish,
      client_be_cloud_path_upload: client_be_cloud_path_upload,
      client_be_selected: client_be_selected,
      client_cover_local_path: client_cover_local_path,
      cover_cloud_path: cover_cloud_path,
      creator_user_id: creator_user_id,
      father_fragment_groups_id: father_fragment_groups_id,
      jump_to_fragment_groups_id: jump_to_fragment_groups_id,
      profile: profile,
      title: title,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static UserComment userCommentEntity({
    required String comment_content,
    required int commentator_user_id,
    required int? fragment_group_id,
    required int? fragment_id,
  }) {
    return UserComment(
      comment_content: comment_content,
      commentator_user_id: commentator_user_id,
      fragment_group_id: fragment_group_id,
      fragment_id: fragment_id,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static UserLike userLikeEntity({
    required int? fragment_group_id,
    required int? fragment_id,
    required int liker_user_id,
  }) {
    return UserLike(
      fragment_group_id: fragment_group_id,
      fragment_id: fragment_id,
      liker_user_id: liker_user_id,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }

  static User userEntity({
    required int? age,
    required String? avatar_cloud_path,
    required String? client_avatar_local_path,
    required String? email,
    required String? password,
    required String? phone,
    required String username,
  }) {
    return User(
      age: age,
      avatar_cloud_path: avatar_cloud_path,
      client_avatar_local_path: client_avatar_local_path,
      email: email,
      password: password,
      phone: phone,
      username: username,
      created_at: DateTime(0),
      id: -1,
      updated_at: DateTime(0),
    );
  }
}
