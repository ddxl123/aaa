// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'httper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FragmentGroupQueryWrapper _$FragmentGroupQueryWrapperFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupQueryWrapper(
      first_target_user_id: json['first_target_user_id'] as int?,
      is_contain_current_login_user_create:
          json['is_contain_current_login_user_create'] as bool,
      only_published: json['only_published'] as bool,
      target_fragment_group_id: json['target_fragment_group_id'] as int?,
    );

Map<String, dynamic> _$FragmentGroupQueryWrapperToJson(
        FragmentGroupQueryWrapper instance) =>
    <String, dynamic>{
      'first_target_user_id': instance.first_target_user_id,
      'is_contain_current_login_user_create':
          instance.is_contain_current_login_user_create,
      'only_published': instance.only_published,
      'target_fragment_group_id': instance.target_fragment_group_id,
    };

FragmentGroupWithJumpWrapper _$FragmentGroupWithJumpWrapperFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupWithJumpWrapper(
      fragment_group: FragmentGroup.fromJson(
          json['fragment_group'] as Map<String, dynamic>),
      jump_fragment_group: json['jump_fragment_group'] == null
          ? null
          : FragmentGroup.fromJson(
              json['jump_fragment_group'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FragmentGroupWithJumpWrapperToJson(
        FragmentGroupWithJumpWrapper instance) =>
    <String, dynamic>{
      'fragment_group': instance.fragment_group,
      'jump_fragment_group': instance.jump_fragment_group,
    };

FragmentGroupWithR _$FragmentGroupWithRFromJson(Map<String, dynamic> json) =>
    FragmentGroupWithR(
      fragment_group: json['fragment_group'] == null
          ? null
          : FragmentGroup.fromJson(
              json['fragment_group'] as Map<String, dynamic>),
      r_fragment_2_fragment_groups: RFragment2FragmentGroup.fromJson(
          json['r_fragment_2_fragment_groups'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FragmentGroupWithRToJson(FragmentGroupWithR instance) =>
    <String, dynamic>{
      'fragment_group': instance.fragment_group,
      'r_fragment_2_fragment_groups': instance.r_fragment_2_fragment_groups,
    };

FragmentIdWithRsWrapper _$FragmentIdWithRsWrapperFromJson(
        Map<String, dynamic> json) =>
    FragmentIdWithRsWrapper(
      fragment_id: json['fragment_id'] as int,
      r_fragment_2_fragment_groups:
          (json['r_fragment_2_fragment_groups'] as List<dynamic>)
              .map((e) =>
                  RFragment2FragmentGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$FragmentIdWithRsWrapperToJson(
        FragmentIdWithRsWrapper instance) =>
    <String, dynamic>{
      'fragment_id': instance.fragment_id,
      'r_fragment_2_fragment_groups': instance.r_fragment_2_fragment_groups,
    };

FragmentQueryWrapper _$FragmentQueryWrapperFromJson(
        Map<String, dynamic> json) =>
    FragmentQueryWrapper(
      first_target_user_id: json['first_target_user_id'] as int?,
      is_contain_current_login_user_create:
          json['is_contain_current_login_user_create'] as bool,
      target_fragment_group_id: json['target_fragment_group_id'] as int?,
    );

Map<String, dynamic> _$FragmentQueryWrapperToJson(
        FragmentQueryWrapper instance) =>
    <String, dynamic>{
      'first_target_user_id': instance.first_target_user_id,
      'is_contain_current_login_user_create':
          instance.is_contain_current_login_user_create,
      'target_fragment_group_id': instance.target_fragment_group_id,
    };

FragmentWithRsWrapper _$FragmentWithRsWrapperFromJson(
        Map<String, dynamic> json) =>
    FragmentWithRsWrapper(
      fragment: Fragment.fromJson(json['fragment'] as Map<String, dynamic>),
      r_fragment_2_fragment_groups:
          (json['r_fragment_2_fragment_groups'] as List<dynamic>)
              .map((e) =>
                  RFragment2FragmentGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$FragmentWithRsWrapperToJson(
        FragmentWithRsWrapper instance) =>
    <String, dynamic>{
      'fragment': instance.fragment,
      'r_fragment_2_fragment_groups': instance.r_fragment_2_fragment_groups,
    };

UserIdAndAvatarAndName _$UserIdAndAvatarAndNameFromJson(
        Map<String, dynamic> json) =>
    UserIdAndAvatarAndName(
      avatar_path: json['avatar_path'] as String?,
      user_id: json['user_id'] as int,
      user_name: json['user_name'] as String,
    );

Map<String, dynamic> _$UserIdAndAvatarAndNameToJson(
        UserIdAndAvatarAndName instance) =>
    <String, dynamic>{
      'avatar_path': instance.avatar_path,
      'user_id': instance.user_id,
      'user_name': instance.user_name,
    };

DeviceAndTokenBo _$DeviceAndTokenBoFromJson(Map<String, dynamic> json) =>
    DeviceAndTokenBo(
      device_info: json['device_info'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$DeviceAndTokenBoToJson(DeviceAndTokenBo instance) =>
    <String, dynamic>{
      'device_info': instance.device_info,
      'token': instance.token,
    };

FragmentAndMemoryInfo _$FragmentAndMemoryInfoFromJson(
        Map<String, dynamic> json) =>
    FragmentAndMemoryInfo(
      fragment: Fragment.fromJson(json['fragment'] as Map<String, dynamic>),
      memory_info: FragmentMemoryInfo.fromJson(
          json['memory_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FragmentAndMemoryInfoToJson(
        FragmentAndMemoryInfo instance) =>
    <String, dynamic>{
      'fragment': instance.fragment,
      'memory_info': instance.memory_info,
    };

KnowledgeBaseFragmentGroupWrapperBo
    _$KnowledgeBaseFragmentGroupWrapperBoFromJson(Map<String, dynamic> json) =>
        KnowledgeBaseFragmentGroupWrapperBo(
          fragment_group: FragmentGroup.fromJson(
              json['fragment_group'] as Map<String, dynamic>),
          fragment_group_tags: (json['fragment_group_tags'] as List<dynamic>)
              .map((e) => FragmentGroupTag.fromJson(e as Map<String, dynamic>))
              .toList(),
          liked_count: json['liked_count'] as int,
          liked_id_for_current_logined:
              json['liked_id_for_current_logined'] as int?,
          saved_count: json['saved_count'] as int,
          saved_id_for_current_logined:
              json['saved_id_for_current_logined'] as int?,
        );

Map<String, dynamic> _$KnowledgeBaseFragmentGroupWrapperBoToJson(
        KnowledgeBaseFragmentGroupWrapperBo instance) =>
    <String, dynamic>{
      'fragment_group': instance.fragment_group,
      'fragment_group_tags': instance.fragment_group_tags,
      'liked_count': instance.liked_count,
      'liked_id_for_current_logined': instance.liked_id_for_current_logined,
      'saved_count': instance.saved_count,
      'saved_id_for_current_logined': instance.saved_id_for_current_logined,
    };

ModifyKnowledgeBaseBigCategory _$ModifyKnowledgeBaseBigCategoryFromJson(
        Map<String, dynamic> json) =>
    ModifyKnowledgeBaseBigCategory(
      big_category: json['big_category'] as String,
      sub_categories: (json['sub_categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ModifyKnowledgeBaseBigCategoryToJson(
        ModifyKnowledgeBaseBigCategory instance) =>
    <String, dynamic>{
      'big_category': instance.big_category,
      'sub_categories': instance.sub_categories,
    };

ModifyKnowledgeBaseCategory _$ModifyKnowledgeBaseCategoryFromJson(
        Map<String, dynamic> json) =>
    ModifyKnowledgeBaseCategory(
      modify_knowledge_base_big_categories:
          (json['modify_knowledge_base_big_categories'] as List<dynamic>)
              .map((e) => ModifyKnowledgeBaseBigCategory.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      selected_sub_categorys: (json['selected_sub_categorys'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ModifyKnowledgeBaseCategoryToJson(
        ModifyKnowledgeBaseCategory instance) =>
    <String, dynamic>{
      'modify_knowledge_base_big_categories':
          instance.modify_knowledge_base_big_categories,
      'selected_sub_categorys': instance.selected_sub_categorys,
    };

CheckLoginDto _$CheckLoginDtoFromJson(Map<String, dynamic> json) =>
    CheckLoginDto(
      device_and_token_bo: DeviceAndTokenBo.fromJson(
          json['device_and_token_bo'] as Map<String, dynamic>),
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$CheckLoginDtoToJson(CheckLoginDto instance) =>
    <String, dynamic>{
      'device_and_token_bo': instance.device_and_token_bo,
      'dto_padding_1': instance.dto_padding_1,
    };

CheckLoginVo _$CheckLoginVoFromJson(Map<String, dynamic> json) => CheckLoginVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$CheckLoginVoToJson(CheckLoginVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

LogoutDto _$LogoutDtoFromJson(Map<String, dynamic> json) => LogoutDto(
      be_active: json['be_active'] as bool,
      current_device_and_token_bo: DeviceAndTokenBo.fromJson(
          json['current_device_and_token_bo'] as Map<String, dynamic>),
      device_and_token_bo: json['device_and_token_bo'] == null
          ? null
          : DeviceAndTokenBo.fromJson(
              json['device_and_token_bo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LogoutDtoToJson(LogoutDto instance) => <String, dynamic>{
      'be_active': instance.be_active,
      'current_device_and_token_bo': instance.current_device_and_token_bo,
      'device_and_token_bo': instance.device_and_token_bo,
    };

LogoutVo _$LogoutVoFromJson(Map<String, dynamic> json) => LogoutVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$LogoutVoToJson(LogoutVo instance) => <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

SendOrVerifyDto _$SendOrVerifyDtoFromJson(Map<String, dynamic> json) =>
    SendOrVerifyDto(
      register_or_login_type: $enumDecode(
          _$RegisterOrLoginTypeEnumMap, json['register_or_login_type']),
      bind_email: json['bind_email'] as String?,
      bind_phone: json['bind_phone'] as String?,
      verify_code: json['verify_code'] as int?,
      device_info: json['device_info'] as String?,
    );

Map<String, dynamic> _$SendOrVerifyDtoToJson(SendOrVerifyDto instance) =>
    <String, dynamic>{
      'register_or_login_type':
          _$RegisterOrLoginTypeEnumMap[instance.register_or_login_type]!,
      'bind_email': instance.bind_email,
      'bind_phone': instance.bind_phone,
      'verify_code': instance.verify_code,
      'device_info': instance.device_info,
    };

const _$RegisterOrLoginTypeEnumMap = {
  RegisterOrLoginType.email_send: 'email_send',
  RegisterOrLoginType.email_verify: 'email_verify',
  RegisterOrLoginType.phone_send: 'phone_send',
  RegisterOrLoginType.phone_verify: 'phone_verify',
};

SendOrVerifyVo _$SendOrVerifyVoFromJson(Map<String, dynamic> json) =>
    SendOrVerifyVo(
      register_or_login_type: $enumDecode(
          _$RegisterOrLoginTypeEnumMap, json['register_or_login_type']),
      be_new_user: json['be_new_user'] as bool,
      user_entity: json['user_entity'] == null
          ? null
          : User.fromJson(json['user_entity'] as Map<String, dynamic>),
      current_device_and_token_bo: DeviceAndTokenBo.fromJson(
          json['current_device_and_token_bo'] as Map<String, dynamic>),
      device_and_token_bo_list:
          (json['device_and_token_bo_list'] as List<dynamic>?)
              ?.map((e) => DeviceAndTokenBo.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$SendOrVerifyVoToJson(SendOrVerifyVo instance) =>
    <String, dynamic>{
      'register_or_login_type':
          _$RegisterOrLoginTypeEnumMap[instance.register_or_login_type]!,
      'be_new_user': instance.be_new_user,
      'user_entity': instance.user_entity,
      'current_device_and_token_bo': instance.current_device_and_token_bo,
      'device_and_token_bo_list': instance.device_and_token_bo_list,
    };

DataUploadDto _$DataUploadDtoFromJson(Map<String, dynamic> json) =>
    DataUploadDto(
      sync_entity: Sync.fromJson(json['sync_entity'] as Map<String, dynamic>),
      row_map: json['row_map'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DataUploadDtoToJson(DataUploadDto instance) =>
    <String, dynamic>{
      'sync_entity': instance.sync_entity,
      'row_map': instance.row_map,
    };

DataUploadVo _$DataUploadVoFromJson(Map<String, dynamic> json) => DataUploadVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$DataUploadVoToJson(DataUploadVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

FragmentGroupTagNewFragmentGroupTagDto
    _$FragmentGroupTagNewFragmentGroupTagDtoFromJson(
            Map<String, dynamic> json) =>
        FragmentGroupTagNewFragmentGroupTagDto(
          tag: json['tag'] as String,
          dto_padding_1: json['dto_padding_1'] as bool?,
        );

Map<String, dynamic> _$FragmentGroupTagNewFragmentGroupTagDtoToJson(
        FragmentGroupTagNewFragmentGroupTagDto instance) =>
    <String, dynamic>{
      'tag': instance.tag,
      'dto_padding_1': instance.dto_padding_1,
    };

FragmentGroupTagNewFragmentGroupTagVo
    _$FragmentGroupTagNewFragmentGroupTagVoFromJson(
            Map<String, dynamic> json) =>
        FragmentGroupTagNewFragmentGroupTagVo(
          fragment_group_tag_entity: FragmentGroupTag.fromJson(
              json['fragment_group_tag_entity'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$FragmentGroupTagNewFragmentGroupTagVoToJson(
        FragmentGroupTagNewFragmentGroupTagVo instance) =>
    <String, dynamic>{
      'fragment_group_tag_entity': instance.fragment_group_tag_entity,
    };

BeFollowQueryDto _$BeFollowQueryDtoFromJson(Map<String, dynamic> json) =>
    BeFollowQueryDto(
      follow_user_id: json['follow_user_id'] as int,
      be_followed_user_id: json['be_followed_user_id'] as int,
    );

Map<String, dynamic> _$BeFollowQueryDtoToJson(BeFollowQueryDto instance) =>
    <String, dynamic>{
      'follow_user_id': instance.follow_user_id,
      'be_followed_user_id': instance.be_followed_user_id,
    };

BeFollowQueryVo _$BeFollowQueryVoFromJson(Map<String, dynamic> json) =>
    BeFollowQueryVo(
      user_follow_id: json['user_follow_id'] as int?,
    );

Map<String, dynamic> _$BeFollowQueryVoToJson(BeFollowQueryVo instance) =>
    <String, dynamic>{
      'user_follow_id': instance.user_follow_id,
    };

FollowAndBeFollowedCountQueryDto _$FollowAndBeFollowedCountQueryDtoFromJson(
        Map<String, dynamic> json) =>
    FollowAndBeFollowedCountQueryDto(
      user_id: json['user_id'] as int,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$FollowAndBeFollowedCountQueryDtoToJson(
        FollowAndBeFollowedCountQueryDto instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'dto_padding_1': instance.dto_padding_1,
    };

FollowAndBeFollowedCountQueryVo _$FollowAndBeFollowedCountQueryVoFromJson(
        Map<String, dynamic> json) =>
    FollowAndBeFollowedCountQueryVo(
      follow_count: json['follow_count'] as int,
      be_followed_count: json['be_followed_count'] as int,
    );

Map<String, dynamic> _$FollowAndBeFollowedCountQueryVoToJson(
        FollowAndBeFollowedCountQueryVo instance) =>
    <String, dynamic>{
      'follow_count': instance.follow_count,
      'be_followed_count': instance.be_followed_count,
    };

FollowOrBeFollowedListQueryDto _$FollowOrBeFollowedListQueryDtoFromJson(
        Map<String, dynamic> json) =>
    FollowOrBeFollowedListQueryDto(
      user_id: json['user_id'] as int,
      follow_or_be_followed: json['follow_or_be_followed'] as bool,
    );

Map<String, dynamic> _$FollowOrBeFollowedListQueryDtoToJson(
        FollowOrBeFollowedListQueryDto instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'follow_or_be_followed': instance.follow_or_be_followed,
    };

FollowOrBeFollowedListQueryVo _$FollowOrBeFollowedListQueryVoFromJson(
        Map<String, dynamic> json) =>
    FollowOrBeFollowedListQueryVo(
      list_list: (json['list_list'] as List<dynamic>)
          .map(
              (e) => UserIdAndAvatarAndName.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FollowOrBeFollowedListQueryVoToJson(
        FollowOrBeFollowedListQueryVo instance) =>
    <String, dynamic>{
      'list_list': instance.list_list,
    };

FragmentGroupAllSubFragmentGroupsQueryDto
    _$FragmentGroupAllSubFragmentGroupsQueryDtoFromJson(
            Map<String, dynamic> json) =>
        FragmentGroupAllSubFragmentGroupsQueryDto(
          fragment_group_query_wrapper: FragmentGroupQueryWrapper.fromJson(
              json['fragment_group_query_wrapper'] as Map<String, dynamic>),
          dto_padding_1: json['dto_padding_1'] as bool?,
        );

Map<String, dynamic> _$FragmentGroupAllSubFragmentGroupsQueryDtoToJson(
        FragmentGroupAllSubFragmentGroupsQueryDto instance) =>
    <String, dynamic>{
      'fragment_group_query_wrapper': instance.fragment_group_query_wrapper,
      'dto_padding_1': instance.dto_padding_1,
    };

FragmentGroupAllSubFragmentGroupsQueryVo
    _$FragmentGroupAllSubFragmentGroupsQueryVoFromJson(
            Map<String, dynamic> json) =>
        FragmentGroupAllSubFragmentGroupsQueryVo(
          self_fragment_group: json['self_fragment_group'] == null
              ? null
              : FragmentGroup.fromJson(
                  json['self_fragment_group'] as Map<String, dynamic>),
          fragment_groups_list: (json['fragment_groups_list'] as List<dynamic>)
              .map((e) => FragmentGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$FragmentGroupAllSubFragmentGroupsQueryVoToJson(
        FragmentGroupAllSubFragmentGroupsQueryVo instance) =>
    <String, dynamic>{
      'self_fragment_group': instance.self_fragment_group,
      'fragment_groups_list': instance.fragment_groups_list,
    };

FragmentGroupAllSubFragmentsCountQueryDto
    _$FragmentGroupAllSubFragmentsCountQueryDtoFromJson(
            Map<String, dynamic> json) =>
        FragmentGroupAllSubFragmentsCountQueryDto(
          fragment_group_query_wrapper: FragmentGroupQueryWrapper.fromJson(
              json['fragment_group_query_wrapper'] as Map<String, dynamic>),
          dto_padding_1: json['dto_padding_1'] as bool?,
        );

Map<String, dynamic> _$FragmentGroupAllSubFragmentsCountQueryDtoToJson(
        FragmentGroupAllSubFragmentsCountQueryDto instance) =>
    <String, dynamic>{
      'fragment_group_query_wrapper': instance.fragment_group_query_wrapper,
      'dto_padding_1': instance.dto_padding_1,
    };

FragmentGroupAllSubFragmentsCountQueryVo
    _$FragmentGroupAllSubFragmentsCountQueryVoFromJson(
            Map<String, dynamic> json) =>
        FragmentGroupAllSubFragmentsCountQueryVo(
          no_repeat_count: json['no_repeat_count'] as int,
          repeat_count: json['repeat_count'] as int,
        );

Map<String, dynamic> _$FragmentGroupAllSubFragmentsCountQueryVoToJson(
        FragmentGroupAllSubFragmentsCountQueryVo instance) =>
    <String, dynamic>{
      'no_repeat_count': instance.no_repeat_count,
      'repeat_count': instance.repeat_count,
    };

FragmentGroupInformationDto _$FragmentGroupInformationDtoFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupInformationDto(
      fragment_group_id: json['fragment_group_id'] as int,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentGroupInformationDtoToJson(
        FragmentGroupInformationDto instance) =>
    <String, dynamic>{
      'fragment_group_id': instance.fragment_group_id,
      'dto_padding_1': instance.dto_padding_1,
    };

FragmentGroupInformationVo _$FragmentGroupInformationVoFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupInformationVo(
      knowledge_base_fragment_group_wrapper_bo:
          json['knowledge_base_fragment_group_wrapper_bo'] == null
              ? null
              : KnowledgeBaseFragmentGroupWrapperBo.fromJson(
                  json['knowledge_base_fragment_group_wrapper_bo']
                      as Map<String, dynamic>),
    );

Map<String, dynamic> _$FragmentGroupInformationVoToJson(
        FragmentGroupInformationVo instance) =>
    <String, dynamic>{
      'knowledge_base_fragment_group_wrapper_bo':
          instance.knowledge_base_fragment_group_wrapper_bo,
    };

FragmentGroupLikeChangeForCurrentLoginedDto
    _$FragmentGroupLikeChangeForCurrentLoginedDtoFromJson(
            Map<String, dynamic> json) =>
        FragmentGroupLikeChangeForCurrentLoginedDto(
          fragment_group_id: json['fragment_group_id'] as int,
          dto_padding_1: json['dto_padding_1'] as bool?,
        );

Map<String, dynamic> _$FragmentGroupLikeChangeForCurrentLoginedDtoToJson(
        FragmentGroupLikeChangeForCurrentLoginedDto instance) =>
    <String, dynamic>{
      'fragment_group_id': instance.fragment_group_id,
      'dto_padding_1': instance.dto_padding_1,
    };

FragmentGroupLikeChangeForCurrentLoginedVo
    _$FragmentGroupLikeChangeForCurrentLoginedVoFromJson(
            Map<String, dynamic> json) =>
        FragmentGroupLikeChangeForCurrentLoginedVo(
          liked: json['liked'] as int?,
        );

Map<String, dynamic> _$FragmentGroupLikeChangeForCurrentLoginedVoToJson(
        FragmentGroupLikeChangeForCurrentLoginedVo instance) =>
    <String, dynamic>{
      'liked': instance.liked,
    };

FragmentGroupModifyDto _$FragmentGroupModifyDtoFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupModifyDto(
      fragment_group: FragmentGroup.fromJson(
          json['fragment_group'] as Map<String, dynamic>),
      fragment_group_tags_list:
          (json['fragment_group_tags_list'] as List<dynamic>?)
              ?.map((e) => FragmentGroupTag.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$FragmentGroupModifyDtoToJson(
        FragmentGroupModifyDto instance) =>
    <String, dynamic>{
      'fragment_group': instance.fragment_group,
      'fragment_group_tags_list': instance.fragment_group_tags_list,
    };

FragmentGroupModifyVo _$FragmentGroupModifyVoFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupModifyVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentGroupModifyVoToJson(
        FragmentGroupModifyVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

FragmentGroupOneSubQueryDto _$FragmentGroupOneSubQueryDtoFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupOneSubQueryDto(
      fragment_group_query_wrapper: FragmentGroupQueryWrapper.fromJson(
          json['fragment_group_query_wrapper'] as Map<String, dynamic>),
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentGroupOneSubQueryDtoToJson(
        FragmentGroupOneSubQueryDto instance) =>
    <String, dynamic>{
      'fragment_group_query_wrapper': instance.fragment_group_query_wrapper,
      'dto_padding_1': instance.dto_padding_1,
    };

FragmentGroupOneSubQueryVo _$FragmentGroupOneSubQueryVoFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupOneSubQueryVo(
      self_fragment_group: json['self_fragment_group'] == null
          ? null
          : FragmentGroup.fromJson(
              json['self_fragment_group'] as Map<String, dynamic>),
      fragment_group_with_jump_wrappers_list:
          (json['fragment_group_with_jump_wrappers_list'] as List<dynamic>)
              .map((e) => FragmentGroupWithJumpWrapper.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      fragments_list: (json['fragments_list'] as List<dynamic>)
          .map((e) => FragmentWithRsWrapper.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FragmentGroupOneSubQueryVoToJson(
        FragmentGroupOneSubQueryVo instance) =>
    <String, dynamic>{
      'self_fragment_group': instance.self_fragment_group,
      'fragment_group_with_jump_wrappers_list':
          instance.fragment_group_with_jump_wrappers_list,
      'fragments_list': instance.fragments_list,
    };

FragmentGroupsDeleteDto _$FragmentGroupsDeleteDtoFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupsDeleteDto(
      fragment_group_ids_list:
          (json['fragment_group_ids_list'] as List<dynamic>)
              .map((e) => e as int)
              .toList(),
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentGroupsDeleteDtoToJson(
        FragmentGroupsDeleteDto instance) =>
    <String, dynamic>{
      'fragment_group_ids_list': instance.fragment_group_ids_list,
      'dto_padding_1': instance.dto_padding_1,
    };

FragmentGroupsDeleteVo _$FragmentGroupsDeleteVoFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupsDeleteVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentGroupsDeleteVoToJson(
        FragmentGroupsDeleteVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

FragmentGroupsFragmentIdsWithRQueryDto
    _$FragmentGroupsFragmentIdsWithRQueryDtoFromJson(
            Map<String, dynamic> json) =>
        FragmentGroupsFragmentIdsWithRQueryDto(
          fragment_group_ids_list:
              (json['fragment_group_ids_list'] as List<dynamic>)
                  .map((e) => e as int)
                  .toList(),
          is_contain_current_login_user_create:
              json['is_contain_current_login_user_create'] as bool,
        );

Map<String, dynamic> _$FragmentGroupsFragmentIdsWithRQueryDtoToJson(
        FragmentGroupsFragmentIdsWithRQueryDto instance) =>
    <String, dynamic>{
      'fragment_group_ids_list': instance.fragment_group_ids_list,
      'is_contain_current_login_user_create':
          instance.is_contain_current_login_user_create,
    };

FragmentGroupsFragmentIdsWithRQueryVo
    _$FragmentGroupsFragmentIdsWithRQueryVoFromJson(
            Map<String, dynamic> json) =>
        FragmentGroupsFragmentIdsWithRQueryVo(
          fragment_id_with_rs_list: (json['fragment_id_with_rs_list']
                  as List<dynamic>)
              .map((e) =>
                  FragmentIdWithRsWrapper.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$FragmentGroupsFragmentIdsWithRQueryVoToJson(
        FragmentGroupsFragmentIdsWithRQueryVo instance) =>
    <String, dynamic>{
      'fragment_id_with_rs_list': instance.fragment_id_with_rs_list,
    };

FragmentGroupsFragmentsCountQueryDto
    _$FragmentGroupsFragmentsCountQueryDtoFromJson(Map<String, dynamic> json) =>
        FragmentGroupsFragmentsCountQueryDto(
          fragment_group_ids_list:
              (json['fragment_group_ids_list'] as List<dynamic>)
                  .map((e) => e as int)
                  .toList(),
          is_contain_current_login_user_create:
              json['is_contain_current_login_user_create'] as bool,
        );

Map<String, dynamic> _$FragmentGroupsFragmentsCountQueryDtoToJson(
        FragmentGroupsFragmentsCountQueryDto instance) =>
    <String, dynamic>{
      'fragment_group_ids_list': instance.fragment_group_ids_list,
      'is_contain_current_login_user_create':
          instance.is_contain_current_login_user_create,
    };

FragmentGroupsFragmentsCountQueryVo
    _$FragmentGroupsFragmentsCountQueryVoFromJson(Map<String, dynamic> json) =>
        FragmentGroupsFragmentsCountQueryVo(
          no_repeat_count: json['no_repeat_count'] as int,
        );

Map<String, dynamic> _$FragmentGroupsFragmentsCountQueryVoToJson(
        FragmentGroupsFragmentsCountQueryVo instance) =>
    <String, dynamic>{
      'no_repeat_count': instance.no_repeat_count,
    };

FragmentGroupsMoveDto _$FragmentGroupsMoveDtoFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupsMoveDto(
      fragment_groups_list: (json['fragment_groups_list'] as List<dynamic>)
          .map((e) => FragmentGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentGroupsMoveDtoToJson(
        FragmentGroupsMoveDto instance) =>
    <String, dynamic>{
      'fragment_groups_list': instance.fragment_groups_list,
      'dto_padding_1': instance.dto_padding_1,
    };

FragmentGroupsMoveVo _$FragmentGroupsMoveVoFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupsMoveVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentGroupsMoveVoToJson(
        FragmentGroupsMoveVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

FragmentGroupsReuseDto _$FragmentGroupsReuseDtoFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupsReuseDto(
      fragment_groups_list: (json['fragment_groups_list'] as List<dynamic>)
          .map((e) => FragmentGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentGroupsReuseDtoToJson(
        FragmentGroupsReuseDto instance) =>
    <String, dynamic>{
      'fragment_groups_list': instance.fragment_groups_list,
      'dto_padding_1': instance.dto_padding_1,
    };

FragmentGroupsReuseVo _$FragmentGroupsReuseVoFromJson(
        Map<String, dynamic> json) =>
    FragmentGroupsReuseVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentGroupsReuseVoToJson(
        FragmentGroupsReuseVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

FragmentInsertFragmentDto _$FragmentInsertFragmentDtoFromJson(
        Map<String, dynamic> json) =>
    FragmentInsertFragmentDto(
      fragment: Fragment.fromJson(json['fragment'] as Map<String, dynamic>),
      fragment_group_ids_list:
          (json['fragment_group_ids_list'] as List<dynamic>)
              .map((e) => e as int?)
              .toList(),
    );

Map<String, dynamic> _$FragmentInsertFragmentDtoToJson(
        FragmentInsertFragmentDto instance) =>
    <String, dynamic>{
      'fragment': instance.fragment,
      'fragment_group_ids_list': instance.fragment_group_ids_list,
    };

FragmentInsertFragmentVo _$FragmentInsertFragmentVoFromJson(
        Map<String, dynamic> json) =>
    FragmentInsertFragmentVo(
      fragment: Fragment.fromJson(json['fragment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FragmentInsertFragmentVoToJson(
        FragmentInsertFragmentVo instance) =>
    <String, dynamic>{
      'fragment': instance.fragment,
    };

FragmentModifyFragmentDto _$FragmentModifyFragmentDtoFromJson(
        Map<String, dynamic> json) =>
    FragmentModifyFragmentDto(
      fragment: Fragment.fromJson(json['fragment'] as Map<String, dynamic>),
      fragment_group_ids_list:
          (json['fragment_group_ids_list'] as List<dynamic>)
              .map((e) => e as int?)
              .toList(),
    );

Map<String, dynamic> _$FragmentModifyFragmentDtoToJson(
        FragmentModifyFragmentDto instance) =>
    <String, dynamic>{
      'fragment': instance.fragment,
      'fragment_group_ids_list': instance.fragment_group_ids_list,
    };

FragmentModifyFragmentVo _$FragmentModifyFragmentVoFromJson(
        Map<String, dynamic> json) =>
    FragmentModifyFragmentVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentModifyFragmentVoToJson(
        FragmentModifyFragmentVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

FragmentQueryFragmentGroupWithRDto _$FragmentQueryFragmentGroupWithRDtoFromJson(
        Map<String, dynamic> json) =>
    FragmentQueryFragmentGroupWithRDto(
      user_id: json['user_id'] as int,
      fragment_id: json['fragment_id'] as int,
    );

Map<String, dynamic> _$FragmentQueryFragmentGroupWithRDtoToJson(
        FragmentQueryFragmentGroupWithRDto instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'fragment_id': instance.fragment_id,
    };

FragmentQueryFragmentGroupWithRVo _$FragmentQueryFragmentGroupWithRVoFromJson(
        Map<String, dynamic> json) =>
    FragmentQueryFragmentGroupWithRVo(
      fragment_group_with_r_list: (json['fragment_group_with_r_list']
              as List<dynamic>)
          .map((e) => FragmentGroupWithR.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FragmentQueryFragmentGroupWithRVoToJson(
        FragmentQueryFragmentGroupWithRVo instance) =>
    <String, dynamic>{
      'fragment_group_with_r_list': instance.fragment_group_with_r_list,
    };

FragmentsDeleteDto _$FragmentsDeleteDtoFromJson(Map<String, dynamic> json) =>
    FragmentsDeleteDto(
      r_fragment_2_fragment_group_ids_list:
          (json['r_fragment_2_fragment_group_ids_list'] as List<dynamic>)
              .map((e) => e as int)
              .toList(),
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentsDeleteDtoToJson(FragmentsDeleteDto instance) =>
    <String, dynamic>{
      'r_fragment_2_fragment_group_ids_list':
          instance.r_fragment_2_fragment_group_ids_list,
      'dto_padding_1': instance.dto_padding_1,
    };

FragmentsDeleteVo _$FragmentsDeleteVoFromJson(Map<String, dynamic> json) =>
    FragmentsDeleteVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentsDeleteVoToJson(FragmentsDeleteVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

FragmentsMoveDto _$FragmentsMoveDtoFromJson(Map<String, dynamic> json) =>
    FragmentsMoveDto(
      r_fragment_2_fragment_groups_list:
          (json['r_fragment_2_fragment_groups_list'] as List<dynamic>)
              .map((e) =>
                  RFragment2FragmentGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentsMoveDtoToJson(FragmentsMoveDto instance) =>
    <String, dynamic>{
      'r_fragment_2_fragment_groups_list':
          instance.r_fragment_2_fragment_groups_list,
      'dto_padding_1': instance.dto_padding_1,
    };

FragmentsMoveVo _$FragmentsMoveVoFromJson(Map<String, dynamic> json) =>
    FragmentsMoveVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentsMoveVoToJson(FragmentsMoveVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

FragmentsReuseDto _$FragmentsReuseDtoFromJson(Map<String, dynamic> json) =>
    FragmentsReuseDto(
      r_fragment_2_fragment_groups_list:
          (json['r_fragment_2_fragment_groups_list'] as List<dynamic>)
              .map((e) =>
                  RFragment2FragmentGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentsReuseDtoToJson(FragmentsReuseDto instance) =>
    <String, dynamic>{
      'r_fragment_2_fragment_groups_list':
          instance.r_fragment_2_fragment_groups_list,
      'dto_padding_1': instance.dto_padding_1,
    };

FragmentsReuseVo _$FragmentsReuseVoFromJson(Map<String, dynamic> json) =>
    FragmentsReuseVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$FragmentsReuseVoToJson(FragmentsReuseVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

KnowledgeBaseCategoryModifyDto _$KnowledgeBaseCategoryModifyDtoFromJson(
        Map<String, dynamic> json) =>
    KnowledgeBaseCategoryModifyDto(
      modify_knowledge_base_category: ModifyKnowledgeBaseCategory.fromJson(
          json['modify_knowledge_base_category'] as Map<String, dynamic>),
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$KnowledgeBaseCategoryModifyDtoToJson(
        KnowledgeBaseCategoryModifyDto instance) =>
    <String, dynamic>{
      'modify_knowledge_base_category': instance.modify_knowledge_base_category,
      'dto_padding_1': instance.dto_padding_1,
    };

KnowledgeBaseCategoryModifyVo _$KnowledgeBaseCategoryModifyVoFromJson(
        Map<String, dynamic> json) =>
    KnowledgeBaseCategoryModifyVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$KnowledgeBaseCategoryModifyVoToJson(
        KnowledgeBaseCategoryModifyVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

KnowledgeBaseCategoryQueryDto _$KnowledgeBaseCategoryQueryDtoFromJson(
        Map<String, dynamic> json) =>
    KnowledgeBaseCategoryQueryDto(
      big_category: json['big_category'] as String?,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$KnowledgeBaseCategoryQueryDtoToJson(
        KnowledgeBaseCategoryQueryDto instance) =>
    <String, dynamic>{
      'big_category': instance.big_category,
      'dto_padding_1': instance.dto_padding_1,
    };

KnowledgeBaseCategoryQueryVo _$KnowledgeBaseCategoryQueryVoFromJson(
        Map<String, dynamic> json) =>
    KnowledgeBaseCategoryQueryVo(
      selected_sub_categorys_list:
          (json['selected_sub_categorys_list'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      big_categorys_list: (json['big_categorys_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sub_categorys_list: (json['sub_categorys_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$KnowledgeBaseCategoryQueryVoToJson(
        KnowledgeBaseCategoryQueryVo instance) =>
    <String, dynamic>{
      'selected_sub_categorys_list': instance.selected_sub_categorys_list,
      'big_categorys_list': instance.big_categorys_list,
      'sub_categorys_list': instance.sub_categorys_list,
    };

KnowledgeBaseFragmentGroupQueryDto _$KnowledgeBaseFragmentGroupQueryDtoFromJson(
        Map<String, dynamic> json) =>
    KnowledgeBaseFragmentGroupQueryDto(
      sub_categories_list: (json['sub_categories_list'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      knowledge_base_content_sort_type: $enumDecode(
          _$KnowledgeBaseContentSortTypeEnumMap,
          json['knowledge_base_content_sort_type']),
      page: json['page'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$KnowledgeBaseFragmentGroupQueryDtoToJson(
        KnowledgeBaseFragmentGroupQueryDto instance) =>
    <String, dynamic>{
      'sub_categories_list': instance.sub_categories_list,
      'knowledge_base_content_sort_type': _$KnowledgeBaseContentSortTypeEnumMap[
          instance.knowledge_base_content_sort_type]!,
      'page': instance.page,
      'size': instance.size,
    };

const _$KnowledgeBaseContentSortTypeEnumMap = {
  KnowledgeBaseContentSortType.by_random: 'by_random',
  KnowledgeBaseContentSortType.by_hot: 'by_hot',
  KnowledgeBaseContentSortType.by_create_time: 'by_create_time',
  KnowledgeBaseContentSortType.by_publish_time: 'by_publish_time',
  KnowledgeBaseContentSortType.by_update_time: 'by_update_time',
  KnowledgeBaseContentSortType.by_like_count: 'by_like_count',
  KnowledgeBaseContentSortType.by_save_count: 'by_save_count',
};

KnowledgeBaseFragmentGroupQueryVo _$KnowledgeBaseFragmentGroupQueryVoFromJson(
        Map<String, dynamic> json) =>
    KnowledgeBaseFragmentGroupQueryVo(
      fragment_group_wrapper_list:
          (json['fragment_group_wrapper_list'] as List<dynamic>)
              .map((e) => KnowledgeBaseFragmentGroupWrapperBo.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$KnowledgeBaseFragmentGroupQueryVoToJson(
        KnowledgeBaseFragmentGroupQueryVo instance) =>
    <String, dynamic>{
      'fragment_group_wrapper_list': instance.fragment_group_wrapper_list,
    };

MemoryGroupFragmentIdsQueryDto _$MemoryGroupFragmentIdsQueryDtoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupFragmentIdsQueryDto(
      memory_group_id: json['memory_group_id'] as int,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryGroupFragmentIdsQueryDtoToJson(
        MemoryGroupFragmentIdsQueryDto instance) =>
    <String, dynamic>{
      'memory_group_id': instance.memory_group_id,
      'dto_padding_1': instance.dto_padding_1,
    };

MemoryGroupFragmentIdsQueryVo _$MemoryGroupFragmentIdsQueryVoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupFragmentIdsQueryVo(
      fragment_ids_list: (json['fragment_ids_list'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$MemoryGroupFragmentIdsQueryVoToJson(
        MemoryGroupFragmentIdsQueryVo instance) =>
    <String, dynamic>{
      'fragment_ids_list': instance.fragment_ids_list,
    };

MemoryGroupFragmentsCountQueryDto _$MemoryGroupFragmentsCountQueryDtoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupFragmentsCountQueryDto(
      memory_group_id: json['memory_group_id'] as int,
      memory_group_ids_list: (json['memory_group_ids_list'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$MemoryGroupFragmentsCountQueryDtoToJson(
        MemoryGroupFragmentsCountQueryDto instance) =>
    <String, dynamic>{
      'memory_group_id': instance.memory_group_id,
      'memory_group_ids_list': instance.memory_group_ids_list,
    };

MemoryGroupFragmentsCountQueryVo _$MemoryGroupFragmentsCountQueryVoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupFragmentsCountQueryVo(
      memory_group:
          MemoryGroup.fromJson(json['memory_group'] as Map<String, dynamic>),
      memory_model: json['memory_model'] == null
          ? null
          : MemoryModel.fromJson(json['memory_model'] as Map<String, dynamic>),
      count: json['count'] as int,
    );

Map<String, dynamic> _$MemoryGroupFragmentsCountQueryVoToJson(
        MemoryGroupFragmentsCountQueryVo instance) =>
    <String, dynamic>{
      'memory_group': instance.memory_group,
      'memory_model': instance.memory_model,
      'count': instance.count,
    };

MemoryGroupFragmentsQueryDto _$MemoryGroupFragmentsQueryDtoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupFragmentsQueryDto(
      memory_group_id: json['memory_group_id'] as int,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryGroupFragmentsQueryDtoToJson(
        MemoryGroupFragmentsQueryDto instance) =>
    <String, dynamic>{
      'memory_group_id': instance.memory_group_id,
      'dto_padding_1': instance.dto_padding_1,
    };

MemoryGroupFragmentsQueryVo _$MemoryGroupFragmentsQueryVoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupFragmentsQueryVo(
      fragments_list: (json['fragments_list'] as List<dynamic>)
          .map((e) => Fragment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MemoryGroupFragmentsQueryVoToJson(
        MemoryGroupFragmentsQueryVo instance) =>
    <String, dynamic>{
      'fragments_list': instance.fragments_list,
    };

MemoryGroupManyUpdateDto _$MemoryGroupManyUpdateDtoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupManyUpdateDto(
      memory_groups_list: (json['memory_groups_list'] as List<dynamic>)
          .map((e) => MemoryGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryGroupManyUpdateDtoToJson(
        MemoryGroupManyUpdateDto instance) =>
    <String, dynamic>{
      'memory_groups_list': instance.memory_groups_list,
      'dto_padding_1': instance.dto_padding_1,
    };

MemoryGroupManyUpdateVo _$MemoryGroupManyUpdateVoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupManyUpdateVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryGroupManyUpdateVoToJson(
        MemoryGroupManyUpdateVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

MemoryGroupMemoryInfoDownloadDto _$MemoryGroupMemoryInfoDownloadDtoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupMemoryInfoDownloadDto(
      memory_group_id: json['memory_group_id'] as int,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryGroupMemoryInfoDownloadDtoToJson(
        MemoryGroupMemoryInfoDownloadDto instance) =>
    <String, dynamic>{
      'memory_group_id': instance.memory_group_id,
      'dto_padding_1': instance.dto_padding_1,
    };

MemoryGroupMemoryInfoDownloadVo _$MemoryGroupMemoryInfoDownloadVoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupMemoryInfoDownloadVo(
      fragment_and_memory_infos_list: (json['fragment_and_memory_infos_list']
              as List<dynamic>)
          .map((e) => FragmentAndMemoryInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MemoryGroupMemoryInfoDownloadVoToJson(
        MemoryGroupMemoryInfoDownloadVo instance) =>
    <String, dynamic>{
      'fragment_and_memory_infos_list': instance.fragment_and_memory_infos_list,
    };

MemoryGroupMemoryInfoDownloadByInfoIdsDto
    _$MemoryGroupMemoryInfoDownloadByInfoIdsDtoFromJson(
            Map<String, dynamic> json) =>
        MemoryGroupMemoryInfoDownloadByInfoIdsDto(
          memory_info_ids_list: (json['memory_info_ids_list'] as List<dynamic>)
              .map((e) => e as int)
              .toList(),
          dto_padding_1: json['dto_padding_1'] as bool?,
        );

Map<String, dynamic> _$MemoryGroupMemoryInfoDownloadByInfoIdsDtoToJson(
        MemoryGroupMemoryInfoDownloadByInfoIdsDto instance) =>
    <String, dynamic>{
      'memory_info_ids_list': instance.memory_info_ids_list,
      'dto_padding_1': instance.dto_padding_1,
    };

MemoryGroupMemoryInfoDownloadByInfoIdsVo
    _$MemoryGroupMemoryInfoDownloadByInfoIdsVoFromJson(
            Map<String, dynamic> json) =>
        MemoryGroupMemoryInfoDownloadByInfoIdsVo(
          fragment_and_memory_infos_list:
              (json['fragment_and_memory_infos_list'] as List<dynamic>)
                  .map((e) =>
                      FragmentAndMemoryInfo.fromJson(e as Map<String, dynamic>))
                  .toList(),
        );

Map<String, dynamic> _$MemoryGroupMemoryInfoDownloadByInfoIdsVoToJson(
        MemoryGroupMemoryInfoDownloadByInfoIdsVo instance) =>
    <String, dynamic>{
      'fragment_and_memory_infos_list': instance.fragment_and_memory_infos_list,
    };

MemoryGroupPageFirstQueryDto _$MemoryGroupPageFirstQueryDtoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupPageFirstQueryDto(
      memory_group_id: json['memory_group_id'] as int,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryGroupPageFirstQueryDtoToJson(
        MemoryGroupPageFirstQueryDto instance) =>
    <String, dynamic>{
      'memory_group_id': instance.memory_group_id,
      'dto_padding_1': instance.dto_padding_1,
    };

MemoryGroupPageFirstQueryVo _$MemoryGroupPageFirstQueryVoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupPageFirstQueryVo(
      memory_group:
          MemoryGroup.fromJson(json['memory_group'] as Map<String, dynamic>),
      memory_model: json['memory_model'] == null
          ? null
          : MemoryModel.fromJson(json['memory_model'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemoryGroupPageFirstQueryVoToJson(
        MemoryGroupPageFirstQueryVo instance) =>
    <String, dynamic>{
      'memory_group': instance.memory_group,
      'memory_model': instance.memory_model,
    };

MemoryGroupPageOtherQueryDto _$MemoryGroupPageOtherQueryDtoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupPageOtherQueryDto(
      memory_group_id: json['memory_group_id'] as int,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryGroupPageOtherQueryDtoToJson(
        MemoryGroupPageOtherQueryDto instance) =>
    <String, dynamic>{
      'memory_group_id': instance.memory_group_id,
      'dto_padding_1': instance.dto_padding_1,
    };

MemoryGroupPageOtherQueryVo _$MemoryGroupPageOtherQueryVoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupPageOtherQueryVo(
      fragment_count: json['fragment_count'] as int,
    );

Map<String, dynamic> _$MemoryGroupPageOtherQueryVoToJson(
        MemoryGroupPageOtherQueryVo instance) =>
    <String, dynamic>{
      'fragment_count': instance.fragment_count,
    };

MemoryGroupSelectedFragmentsInsertDto
    _$MemoryGroupSelectedFragmentsInsertDtoFromJson(
            Map<String, dynamic> json) =>
        MemoryGroupSelectedFragmentsInsertDto(
          fragment_memory_infos_list: (json['fragment_memory_infos_list']
                  as List<dynamic>)
              .map(
                  (e) => FragmentMemoryInfo.fromJson(e as Map<String, dynamic>))
              .toList(),
          memory_group_id: json['memory_group_id'] as int,
        );

Map<String, dynamic> _$MemoryGroupSelectedFragmentsInsertDtoToJson(
        MemoryGroupSelectedFragmentsInsertDto instance) =>
    <String, dynamic>{
      'fragment_memory_infos_list': instance.fragment_memory_infos_list,
      'memory_group_id': instance.memory_group_id,
    };

MemoryGroupSelectedFragmentsInsertVo
    _$MemoryGroupSelectedFragmentsInsertVoFromJson(Map<String, dynamic> json) =>
        MemoryGroupSelectedFragmentsInsertVo(
          memory_info_ids_list: (json['memory_info_ids_list'] as List<dynamic>)
              .map((e) => e as int)
              .toList(),
        );

Map<String, dynamic> _$MemoryGroupSelectedFragmentsInsertVoToJson(
        MemoryGroupSelectedFragmentsInsertVo instance) =>
    <String, dynamic>{
      'memory_info_ids_list': instance.memory_info_ids_list,
    };

MemoryGroupsQueryDto _$MemoryGroupsQueryDtoFromJson(
        Map<String, dynamic> json) =>
    MemoryGroupsQueryDto(
      user_id: json['user_id'] as int,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryGroupsQueryDtoToJson(
        MemoryGroupsQueryDto instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'dto_padding_1': instance.dto_padding_1,
    };

MemoryGroupsQueryVo _$MemoryGroupsQueryVoFromJson(Map<String, dynamic> json) =>
    MemoryGroupsQueryVo(
      memory_groups_list: (json['memory_groups_list'] as List<dynamic>)
          .map((e) => MemoryGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MemoryGroupsQueryVoToJson(
        MemoryGroupsQueryVo instance) =>
    <String, dynamic>{
      'memory_groups_list': instance.memory_groups_list,
    };

MemoryInfoDownloadOnlyIdDto _$MemoryInfoDownloadOnlyIdDtoFromJson(
        Map<String, dynamic> json) =>
    MemoryInfoDownloadOnlyIdDto(
      memory_group_id: json['memory_group_id'] as int,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryInfoDownloadOnlyIdDtoToJson(
        MemoryInfoDownloadOnlyIdDto instance) =>
    <String, dynamic>{
      'memory_group_id': instance.memory_group_id,
      'dto_padding_1': instance.dto_padding_1,
    };

MemoryInfoDownloadOnlyIdVo _$MemoryInfoDownloadOnlyIdVoFromJson(
        Map<String, dynamic> json) =>
    MemoryInfoDownloadOnlyIdVo(
      memory_info_id_list: (json['memory_info_id_list'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$MemoryInfoDownloadOnlyIdVoToJson(
        MemoryInfoDownloadOnlyIdVo instance) =>
    <String, dynamic>{
      'memory_info_id_list': instance.memory_info_id_list,
    };

MemoryInfoUploadSyncDto _$MemoryInfoUploadSyncDtoFromJson(
        Map<String, dynamic> json) =>
    MemoryInfoUploadSyncDto(
      memory_infos_list: (json['memory_infos_list'] as List<dynamic>)
          .map((e) => FragmentMemoryInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryInfoUploadSyncDtoToJson(
        MemoryInfoUploadSyncDto instance) =>
    <String, dynamic>{
      'memory_infos_list': instance.memory_infos_list,
      'dto_padding_1': instance.dto_padding_1,
    };

MemoryInfoUploadSyncVo _$MemoryInfoUploadSyncVoFromJson(
        Map<String, dynamic> json) =>
    MemoryInfoUploadSyncVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryInfoUploadSyncVoToJson(
        MemoryInfoUploadSyncVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

MemoryModelManyUpdateDto _$MemoryModelManyUpdateDtoFromJson(
        Map<String, dynamic> json) =>
    MemoryModelManyUpdateDto(
      memory_models_list: (json['memory_models_list'] as List<dynamic>)
          .map((e) => MemoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryModelManyUpdateDtoToJson(
        MemoryModelManyUpdateDto instance) =>
    <String, dynamic>{
      'memory_models_list': instance.memory_models_list,
      'dto_padding_1': instance.dto_padding_1,
    };

MemoryModelManyUpdateVo _$MemoryModelManyUpdateVoFromJson(
        Map<String, dynamic> json) =>
    MemoryModelManyUpdateVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryModelManyUpdateVoToJson(
        MemoryModelManyUpdateVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

MemoryModelsQueryDto _$MemoryModelsQueryDtoFromJson(
        Map<String, dynamic> json) =>
    MemoryModelsQueryDto(
      user_id: json['user_id'] as int,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$MemoryModelsQueryDtoToJson(
        MemoryModelsQueryDto instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'dto_padding_1': instance.dto_padding_1,
    };

MemoryModelsQueryVo _$MemoryModelsQueryVoFromJson(Map<String, dynamic> json) =>
    MemoryModelsQueryVo(
      memory_models_list: (json['memory_models_list'] as List<dynamic>)
          .map((e) => MemoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MemoryModelsQueryVoToJson(
        MemoryModelsQueryVo instance) =>
    <String, dynamic>{
      'memory_models_list': instance.memory_models_list,
    };

PersonalHomePageForPublishPageDto _$PersonalHomePageForPublishPageDtoFromJson(
        Map<String, dynamic> json) =>
    PersonalHomePageForPublishPageDto(
      user_id: json['user_id'] as int,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$PersonalHomePageForPublishPageDtoToJson(
        PersonalHomePageForPublishPageDto instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'dto_padding_1': instance.dto_padding_1,
    };

PersonalHomePageForPublishPageVo _$PersonalHomePageForPublishPageVoFromJson(
        Map<String, dynamic> json) =>
    PersonalHomePageForPublishPageVo(
      fragment_groups_list: (json['fragment_groups_list'] as List<dynamic>)
          .map((e) => FragmentGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PersonalHomePageForPublishPageVoToJson(
        PersonalHomePageForPublishPageVo instance) =>
    <String, dynamic>{
      'fragment_groups_list': instance.fragment_groups_list,
    };

PersonalHomePageForUserInfoDto _$PersonalHomePageForUserInfoDtoFromJson(
        Map<String, dynamic> json) =>
    PersonalHomePageForUserInfoDto(
      user_id: json['user_id'] as int,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$PersonalHomePageForUserInfoDtoToJson(
        PersonalHomePageForUserInfoDto instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'dto_padding_1': instance.dto_padding_1,
    };

PersonalHomePageForUserInfoVo _$PersonalHomePageForUserInfoVoFromJson(
        Map<String, dynamic> json) =>
    PersonalHomePageForUserInfoVo(
      user_info: User.fromJson(json['user_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonalHomePageForUserInfoVoToJson(
        PersonalHomePageForUserInfoVo instance) =>
    <String, dynamic>{
      'user_info': instance.user_info,
    };

QueryFragmentGroupTagByFragmentGroupIdDto
    _$QueryFragmentGroupTagByFragmentGroupIdDtoFromJson(
            Map<String, dynamic> json) =>
        QueryFragmentGroupTagByFragmentGroupIdDto(
          fragment_group_id: json['fragment_group_id'] as int,
          dto_padding_1: json['dto_padding_1'] as bool?,
        );

Map<String, dynamic> _$QueryFragmentGroupTagByFragmentGroupIdDtoToJson(
        QueryFragmentGroupTagByFragmentGroupIdDto instance) =>
    <String, dynamic>{
      'fragment_group_id': instance.fragment_group_id,
      'dto_padding_1': instance.dto_padding_1,
    };

QueryFragmentGroupTagByFragmentGroupIdVo
    _$QueryFragmentGroupTagByFragmentGroupIdVoFromJson(
            Map<String, dynamic> json) =>
        QueryFragmentGroupTagByFragmentGroupIdVo(
          fragment_group_tag_list: (json['fragment_group_tag_list']
                  as List<dynamic>)
              .map((e) => FragmentGroupTag.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$QueryFragmentGroupTagByFragmentGroupIdVoToJson(
        QueryFragmentGroupTagByFragmentGroupIdVo instance) =>
    <String, dynamic>{
      'fragment_group_tag_list': instance.fragment_group_tag_list,
    };

QueryFragmentGroupTagByLikeDto _$QueryFragmentGroupTagByLikeDtoFromJson(
        Map<String, dynamic> json) =>
    QueryFragmentGroupTagByLikeDto(
      like: json['like'] as String,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$QueryFragmentGroupTagByLikeDtoToJson(
        QueryFragmentGroupTagByLikeDto instance) =>
    <String, dynamic>{
      'like': instance.like,
      'dto_padding_1': instance.dto_padding_1,
    };

QueryFragmentGroupTagByLikeVo _$QueryFragmentGroupTagByLikeVoFromJson(
        Map<String, dynamic> json) =>
    QueryFragmentGroupTagByLikeVo(
      fragment_group_tag_list:
          (json['fragment_group_tag_list'] as List<dynamic>)
              .map((e) => FragmentGroupTag.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$QueryFragmentGroupTagByLikeVoToJson(
        QueryFragmentGroupTagByLikeVo instance) =>
    <String, dynamic>{
      'fragment_group_tag_list': instance.fragment_group_tag_list,
    };

ShorthandsQueryDto _$ShorthandsQueryDtoFromJson(Map<String, dynamic> json) =>
    ShorthandsQueryDto(
      user_id: json['user_id'] as int,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$ShorthandsQueryDtoToJson(ShorthandsQueryDto instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'dto_padding_1': instance.dto_padding_1,
    };

ShorthandsQueryVo _$ShorthandsQueryVoFromJson(Map<String, dynamic> json) =>
    ShorthandsQueryVo(
      shorthands_list: (json['shorthands_list'] as List<dynamic>)
          .map((e) => Shorthand.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShorthandsQueryVoToJson(ShorthandsQueryVo instance) =>
    <String, dynamic>{
      'shorthands_list': instance.shorthands_list,
    };

SingleFieldModifyDto _$SingleFieldModifyDtoFromJson(
        Map<String, dynamic> json) =>
    SingleFieldModifyDto(
      table_name: json['table_name'] as String,
      row_id: json['row_id'],
      field_name: json['field_name'] as String,
      modify_value: json['modify_value'],
    );

Map<String, dynamic> _$SingleFieldModifyDtoToJson(
        SingleFieldModifyDto instance) =>
    <String, dynamic>{
      'table_name': instance.table_name,
      'row_id': instance.row_id,
      'field_name': instance.field_name,
      'modify_value': instance.modify_value,
    };

SingleFieldModifyVo _$SingleFieldModifyVoFromJson(Map<String, dynamic> json) =>
    SingleFieldModifyVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$SingleFieldModifyVoToJson(
        SingleFieldModifyVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

SingleRowDeleteDto _$SingleRowDeleteDtoFromJson(Map<String, dynamic> json) =>
    SingleRowDeleteDto(
      table_name: json['table_name'] as String,
      row_id: json['row_id'] as int,
    );

Map<String, dynamic> _$SingleRowDeleteDtoToJson(SingleRowDeleteDto instance) =>
    <String, dynamic>{
      'table_name': instance.table_name,
      'row_id': instance.row_id,
    };

SingleRowDeleteVo _$SingleRowDeleteVoFromJson(Map<String, dynamic> json) =>
    SingleRowDeleteVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
    );

Map<String, dynamic> _$SingleRowDeleteVoToJson(SingleRowDeleteVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
    };

SingleRowInsertDto _$SingleRowInsertDtoFromJson(Map<String, dynamic> json) =>
    SingleRowInsertDto(
      table_name: json['table_name'] as String,
      row: json['row'],
    );

Map<String, dynamic> _$SingleRowInsertDtoToJson(SingleRowInsertDto instance) =>
    <String, dynamic>{
      'table_name': instance.table_name,
      'row': instance.row,
    };

SingleRowInsertVo _$SingleRowInsertVoFromJson(Map<String, dynamic> json) =>
    SingleRowInsertVo(
      row: json['row'],
    );

Map<String, dynamic> _$SingleRowInsertVoToJson(SingleRowInsertVo instance) =>
    <String, dynamic>{
      'row': instance.row,
    };

SingleRowModifyDto _$SingleRowModifyDtoFromJson(Map<String, dynamic> json) =>
    SingleRowModifyDto(
      table_name: json['table_name'] as String,
      row: json['row'],
    );

Map<String, dynamic> _$SingleRowModifyDtoToJson(SingleRowModifyDto instance) =>
    <String, dynamic>{
      'table_name': instance.table_name,
      'row': instance.row,
    };

SingleRowModifyVo _$SingleRowModifyVoFromJson(Map<String, dynamic> json) =>
    SingleRowModifyVo(
      row: json['row'],
    );

Map<String, dynamic> _$SingleRowModifyVoToJson(SingleRowModifyVo instance) =>
    <String, dynamic>{
      'row': instance.row,
    };

SingleRowQueryDto _$SingleRowQueryDtoFromJson(Map<String, dynamic> json) =>
    SingleRowQueryDto(
      table_name: json['table_name'] as String,
      row_id: json['row_id'] as int,
    );

Map<String, dynamic> _$SingleRowQueryDtoToJson(SingleRowQueryDto instance) =>
    <String, dynamic>{
      'table_name': instance.table_name,
      'row_id': instance.row_id,
    };

SingleRowQueryVo _$SingleRowQueryVoFromJson(Map<String, dynamic> json) =>
    SingleRowQueryVo(
      row: json['row'],
    );

Map<String, dynamic> _$SingleRowQueryVoToJson(SingleRowQueryVo instance) =>
    <String, dynamic>{
      'row': instance.row,
    };
