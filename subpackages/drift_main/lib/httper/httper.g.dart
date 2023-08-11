// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'httper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

DataDownloadForKnowledgeBaseFragmentWrapperBO
    _$DataDownloadForKnowledgeBaseFragmentWrapperBOFromJson(
            Map<String, dynamic> json) =>
        DataDownloadForKnowledgeBaseFragmentWrapperBO(
          fragments:
              Fragment.fromJson(json['fragments'] as Map<String, dynamic>),
          r_fragment_2_fragment_groups: (json['r_fragment_2_fragment_groups']
                  as List<dynamic>)
              .map((e) =>
                  RFragment2FragmentGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$DataDownloadForKnowledgeBaseFragmentWrapperBOToJson(
        DataDownloadForKnowledgeBaseFragmentWrapperBO instance) =>
    <String, dynamic>{
      'fragments': instance.fragments,
      'r_fragment_2_fragment_groups': instance.r_fragment_2_fragment_groups,
    };

KnowledgeBaseFragmentGroupInnerForFragmentBo
    _$KnowledgeBaseFragmentGroupInnerForFragmentBoFromJson(
            Map<String, dynamic> json) =>
        KnowledgeBaseFragmentGroupInnerForFragmentBo(
          fragment: Fragment.fromJson(json['fragment'] as Map<String, dynamic>),
          r_fragment_2_fragment_groups: (json['r_fragment_2_fragment_groups']
                  as List<dynamic>)
              .map((e) =>
                  RFragment2FragmentGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$KnowledgeBaseFragmentGroupInnerForFragmentBoToJson(
        KnowledgeBaseFragmentGroupInnerForFragmentBo instance) =>
    <String, dynamic>{
      'fragment': instance.fragment,
      'r_fragment_2_fragment_groups': instance.r_fragment_2_fragment_groups,
    };

KnowledgeBaseFragmentGroupWrapperBo
    _$KnowledgeBaseFragmentGroupWrapperBoFromJson(Map<String, dynamic> json) =>
        KnowledgeBaseFragmentGroupWrapperBo(
          fragment_group: FragmentGroup.fromJson(
              json['fragment_group'] as Map<String, dynamic>),
          fragment_group_tags: (json['fragment_group_tags'] as List<dynamic>)
              .map((e) => FragmentGroupTag.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$KnowledgeBaseFragmentGroupWrapperBoToJson(
        KnowledgeBaseFragmentGroupWrapperBo instance) =>
    <String, dynamic>{
      'fragment_group': instance.fragment_group,
      'fragment_group_tags': instance.fragment_group_tags,
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
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      verify_code: json['verify_code'] as int?,
      device_info: json['device_info'] as String?,
    );

Map<String, dynamic> _$SendOrVerifyDtoToJson(SendOrVerifyDto instance) =>
    <String, dynamic>{
      'register_or_login_type':
          _$RegisterOrLoginTypeEnumMap[instance.register_or_login_type]!,
      'email': instance.email,
      'phone': instance.phone,
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

DataDownloadForFragmentGroupDto _$DataDownloadForFragmentGroupDtoFromJson(
        Map<String, dynamic> json) =>
    DataDownloadForFragmentGroupDto(
      fragment_group_id: json['fragment_group_id'] as String,
      dto_padding_1: json['dto_padding_1'] as bool?,
    );

Map<String, dynamic> _$DataDownloadForFragmentGroupDtoToJson(
        DataDownloadForFragmentGroupDto instance) =>
    <String, dynamic>{
      'fragment_group_id': instance.fragment_group_id,
      'dto_padding_1': instance.dto_padding_1,
    };

DataDownloadForFragmentGroupVo _$DataDownloadForFragmentGroupVoFromJson(
        Map<String, dynamic> json) =>
    DataDownloadForFragmentGroupVo(
      fragment_group_list: (json['fragment_group_list'] as List<dynamic>)
          .map((e) => FragmentGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      r_fragment2_fragment_group_list:
          (json['r_fragment2_fragment_group_list'] as List<dynamic>)
              .map((e) =>
                  RFragment2FragmentGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
      fragment_list: (json['fragment_list'] as List<dynamic>)
          .map((e) => Fragment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataDownloadForFragmentGroupVoToJson(
        DataDownloadForFragmentGroupVo instance) =>
    <String, dynamic>{
      'fragment_group_list': instance.fragment_group_list,
      'r_fragment2_fragment_group_list':
          instance.r_fragment2_fragment_group_list,
      'fragment_list': instance.fragment_list,
    };

DataDownloadForKnowledgeBaseDto _$DataDownloadForKnowledgeBaseDtoFromJson(
        Map<String, dynamic> json) =>
    DataDownloadForKnowledgeBaseDto(
      fragment_group_id: json['fragment_group_id'] as String?,
      fragment_group_ids_for_fragments_list:
          (json['fragment_group_ids_for_fragments_list'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      fragment_group_ids_for_tags_list:
          (json['fragment_group_ids_for_tags_list'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$DataDownloadForKnowledgeBaseDtoToJson(
        DataDownloadForKnowledgeBaseDto instance) =>
    <String, dynamic>{
      'fragment_group_id': instance.fragment_group_id,
      'fragment_group_ids_for_fragments_list':
          instance.fragment_group_ids_for_fragments_list,
      'fragment_group_ids_for_tags_list':
          instance.fragment_group_ids_for_tags_list,
    };

DataDownloadForKnowledgeBaseVo _$DataDownloadForKnowledgeBaseVoFromJson(
        Map<String, dynamic> json) =>
    DataDownloadForKnowledgeBaseVo(
      fragment_group_self_and_subs_list:
          (json['fragment_group_self_and_subs_list'] as List<dynamic>?)
              ?.map((e) => FragmentGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
      fragment_wrappers_list: (json['fragment_wrappers_list'] as List<dynamic>?)
          ?.map((e) => DataDownloadForKnowledgeBaseFragmentWrapperBO.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      fragment_group_tags_list:
          (json['fragment_group_tags_list'] as List<dynamic>?)
              ?.map((e) => FragmentGroupTag.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$DataDownloadForKnowledgeBaseVoToJson(
        DataDownloadForKnowledgeBaseVo instance) =>
    <String, dynamic>{
      'fragment_group_self_and_subs_list':
          instance.fragment_group_self_and_subs_list,
      'fragment_wrappers_list': instance.fragment_wrappers_list,
      'fragment_group_tags_list': instance.fragment_group_tags_list,
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

KnowledgeBaseFragmentGroupInnerQueryDto
    _$KnowledgeBaseFragmentGroupInnerQueryDtoFromJson(
            Map<String, dynamic> json) =>
        KnowledgeBaseFragmentGroupInnerQueryDto(
          fragment_group_id: json['fragment_group_id'] as String,
          dto_padding_1: json['dto_padding_1'] as bool?,
        );

Map<String, dynamic> _$KnowledgeBaseFragmentGroupInnerQueryDtoToJson(
        KnowledgeBaseFragmentGroupInnerQueryDto instance) =>
    <String, dynamic>{
      'fragment_group_id': instance.fragment_group_id,
      'dto_padding_1': instance.dto_padding_1,
    };

KnowledgeBaseFragmentGroupInnerQueryVo
    _$KnowledgeBaseFragmentGroupInnerQueryVoFromJson(
            Map<String, dynamic> json) =>
        KnowledgeBaseFragmentGroupInnerQueryVo(
          fragment_groups_list: (json['fragment_groups_list'] as List<dynamic>)
              .map((e) => FragmentGroup.fromJson(e as Map<String, dynamic>))
              .toList(),
          fragment_group_self_tags_list: (json['fragment_group_self_tags_list']
                  as List<dynamic>)
              .map((e) => FragmentGroupTag.fromJson(e as Map<String, dynamic>))
              .toList(),
          fragments_list: (json['fragments_list'] as List<dynamic>)
              .map((e) => KnowledgeBaseFragmentGroupInnerForFragmentBo.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$KnowledgeBaseFragmentGroupInnerQueryVoToJson(
        KnowledgeBaseFragmentGroupInnerQueryVo instance) =>
    <String, dynamic>{
      'fragment_groups_list': instance.fragment_groups_list,
      'fragment_group_self_tags_list': instance.fragment_group_self_tags_list,
      'fragments_list': instance.fragments_list,
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

QueryFragmentGroupTagByFragmentGroupIdDto
    _$QueryFragmentGroupTagByFragmentGroupIdDtoFromJson(
            Map<String, dynamic> json) =>
        QueryFragmentGroupTagByFragmentGroupIdDto(
          fragment_group_id: json['fragment_group_id'] as String,
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
