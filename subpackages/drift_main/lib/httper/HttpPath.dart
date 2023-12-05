
part of httper;

/// 该文件由服务端生成。

/// 请求连接里的不存在 GET_ POST_ 前缀，因此发生请求时要去掉。
class HttpPath {
  HttpPath._();

  /// 基础 path
  static const String BASE_PATH_LOCAL = 'http://10.11.250.79:2814';
  
  static const String POST__REGISTER_OR_LOGIN_CHECK_LOGIN = 'POST_/register_or_login/check_login';

  static const String POST__REGISTER_OR_LOGIN_LOGOUT = 'POST_/register_or_login/logout';

  static const String POST__REGISTER_OR_LOGIN_SEND_OR_VERIFY = 'POST_/register_or_login/send_or_verify';

  static const String POST__LOGIN_REQUIRED_DATA_UPLOAD_ONCE_SYNCS = 'POST_/login_required/data_upload/once_syncs';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_ALL_SUB_FRAGMENT_GROUPS_QUERY = 'POST_/no_login_required/fragment_group_handle/all_sub_fragment_groups_query';

  static const String GET__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUP_INFORMATION = 'GET_/no_login_required/fragment_group_handle/fragment_group_information';

  static const String GET__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUP_LIKE_CHANGE = 'GET_/no_login_required/fragment_group_handle/fragment_group_like_change';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUP_ONE_SUB_QUERY = 'POST_/no_login_required/fragment_group_handle/fragment_group_one_sub_query';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUPS_DELETE = 'POST_/no_login_required/fragment_group_handle/fragment_groups_delete';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUPS_FRAGMENT_IDS_WITH_R_QUERY = 'POST_/no_login_required/fragment_group_handle/fragment_groups_fragment_ids_with_r_query';

  static const String GET__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUPS_FRAGMENTS_COUNT_QUERY = 'GET_/no_login_required/fragment_group_handle/fragment_groups_fragments_count_query';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUPS_MOVE = 'POST_/no_login_required/fragment_group_handle/fragment_groups_move';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUPS_REUSE = 'POST_/no_login_required/fragment_group_handle/fragment_groups_reuse';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_MODIFY_FRAGMENT_GROUP = 'POST_/no_login_required/fragment_group_handle/modify_fragment_group';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_TAG_BY_FRAGMENT_GROUP_ID = 'POST_/no_login_required/fragment_group_tag/by_fragment_group_id';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_TAG_BY_LIKE = 'POST_/no_login_required/fragment_group_tag/by_like';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_HANDLE_FRAGMENTS_DELETE = 'POST_/no_login_required/fragment_handle/fragments_delete';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_HANDLE_FRAGMENTS_MOVE = 'POST_/no_login_required/fragment_handle/fragments_move';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_HANDLE_FRAGMENTS_REUSE = 'POST_/no_login_required/fragment_handle/fragments_reuse';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_HANDLE_INSERT_FRAGMENT = 'POST_/no_login_required/fragment_handle/insert_fragment';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_HANDLE_MODIFY_FRAGMENT = 'POST_/no_login_required/fragment_handle/modify_fragment';

  static const String POST__NO_LOGIN_REQUIRED_FRAGMENT_HANDLE_FRAGMENT_GROUP_ALL_SUB_FRAGMENTS_COUNT_QUERY = 'POST_/no_login_required/fragment_handle/fragment_group_all_sub_fragments_count_query';

  static const String GET__NO_LOGIN_REQUIRED_FRAGMENT_HANDLE_QUERY_FRAGMENT_GROUP_WITH_R = 'GET_/no_login_required/fragment_handle/query_fragment_group_with_r';

  static const String POST__NO_LOGIN_REQUIRED_KNOWLEDGE_BASE_MODIFY_KNOWLEDGE_BASE_CATEGORYS = 'POST_/no_login_required/knowledge_base/modify_knowledge_base_categorys';

  static const String POST__NO_LOGIN_REQUIRED_KNOWLEDGE_BASE_QUERY_KNOWLEDGE_BASE_CATEGORYS = 'POST_/no_login_required/knowledge_base/query_knowledge_base_categorys';

  static const String POST__NO_LOGIN_REQUIRED_KNOWLEDGE_BASE_QUERY_KNOWLEDGE_BASE_FRAGMENT_GROUPS = 'POST_/no_login_required/knowledge_base/query_knowledge_base_fragment_groups';

  static const String GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_FRAGMENT_IDS_QUERY = 'GET_/login_required/memory_group_handle/fragment_ids_query';

  static const String GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_FRAGMENTS_COUNT_QUERY = 'GET_/login_required/memory_group_handle/fragments_count_query';

  static const String GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_FRAGMENTS_QUERY = 'GET_/login_required/memory_group_handle/fragments_query';

  static const String POST__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUP_MANY_UPDATE = 'POST_/login_required/memory_group_handle/memory_group_many_update';

  static const String GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUP_MEMORY_INFO_DOWNLOAD = 'GET_/login_required/memory_group_handle/memory_group_memory_info_download';

  static const String POST__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUP_MEMORY_INFO_DOWNLOAD_BY_INFO_IDS = 'POST_/login_required/memory_group_handle/memory_group_memory_info_download_by_info_ids';

  static const String POST__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUPS_QUERY = 'POST_/login_required/memory_group_handle/memory_groups_query';

  static const String GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_INFO_DOWNLOAD_ONLY_ID = 'GET_/login_required/memory_group_handle/memory_info_download_only_id';

  static const String POST__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_INFO_UPLOAD_SYNC = 'POST_/login_required/memory_group_handle/memory_info_upload_sync';

  static const String GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUP_PAGE_FIRST_QUERY = 'GET_/login_required/memory_group_handle/memory_group_page_first_query';

  static const String GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUP_PAGE_OTHER_QUERY = 'GET_/login_required/memory_group_handle/memory_group_page_other_query';

  static const String POST__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_SELECTED_FRAGMENTS_INSERT = 'POST_/login_required/memory_group_handle/selected_fragments_insert';

  static const String POST__NO_LOGIN_REQUIRED_MEMORY_MODEL_HANDLE_MEMORY_MODEL_MANY_UPDATE = 'POST_/no_login_required/memory_model_handle/memory_model_many_update';

  static const String POST__NO_LOGIN_REQUIRED_MEMORY_MODEL_HANDLE_MEMORY_MODELS_QUERY = 'POST_/no_login_required/memory_model_handle/memory_models_query';

  static const String GET__NO_LOGIN_REQUIRED_PERSONAL_HOME_HANDLE_BE_FOLLOW_QUERY = 'GET_/no_login_required/personal_home_handle/be_follow_query';

  static const String GET__NO_LOGIN_REQUIRED_PERSONAL_HOME_HANDLE_FOLLOW_AND_BE_FOLLOWED_COUNT_QUERY = 'GET_/no_login_required/personal_home_handle/follow_and_be_followed_count_query';

  static const String GET__NO_LOGIN_REQUIRED_PERSONAL_HOME_HANDLE_FOLLOW_AND_BE_FOLLOWED_LIST_QUERY = 'GET_/no_login_required/personal_home_handle/follow_and_be_followed_list_query';

  static const String POST__NO_LOGIN_REQUIRED_PERSONAL_HOME_HANDLE_PUBLISH_PAGE = 'POST_/no_login_required/personal_home_handle/publish_page';

  static const String POST__NO_LOGIN_REQUIRED_PERSONAL_HOME_HANDLE_USER_INFO = 'POST_/no_login_required/personal_home_handle/user_info';

  static const String POST__NO_LOGIN_REQUIRED_SHORTHAND_HANDLE_SHORTHANDS_QUERY = 'POST_/no_login_required/shorthand_handle/shorthands_query';

  static const String POST__LOGIN_REQUIRED_SINGLE_FIELD_MODIFY = 'POST_/login_required/single_field_modify';

  static const String POST__NO_LOGIN_REQUIRED_SINGLE_FIELD_MODIFY = 'POST_/no_login_required/single_field_modify';

  static const String POST__LOGIN_REQUIRED_SINGLE_ROW_DELETE = 'POST_/login_required/single_row_delete';

  static const String POST__NO_LOGIN_REQUIRED_SINGLE_ROW_DELETE = 'POST_/no_login_required/single_row_delete';

  static const String POST__LOGIN_REQUIRED_SINGLE_ROW_INSERT = 'POST_/login_required/single_row_insert';

  static const String POST__NO_LOGIN_REQUIRED_SINGLE_ROW_INSERT = 'POST_/no_login_required/single_row_insert';

  static const String POST__LOGIN_REQUIRED_SINGLE_ROW_MODIFY = 'POST_/login_required/single_row_modify';

  static const String POST__NO_LOGIN_REQUIRED_SINGLE_ROW_MODIFY = 'POST_/no_login_required/single_row_modify';

  static const String POST__LOGIN_REQUIRED_SINGLE_ROW_QUERY = 'POST_/login_required/single_row_query';

  static const String POST__NO_LOGIN_REQUIRED_SINGLE_ROW_QUERY = 'POST_/no_login_required/single_row_query';

  static const String GET__NO_LOGIN_REQUIRED_TEST_GET = 'GET_/no_login_required/test/get';

  static const String POST__NO_LOGIN_REQUIRED_TEST_POST = 'POST_/no_login_required/test/post';

}

