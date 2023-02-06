// GENERATED CODE - DO NOT MODIFY BY HAND

part of httper;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryContent _$CategoryContentFromJson(Map<String, dynamic> json) =>
    CategoryContent(
      fragment_info:
          Fragment.fromJson(json['fragment_info'] as Map<String, dynamic>),
      publisher_username: json['publisher_username'] as String,
    );

Map<String, dynamic> _$CategoryContentToJson(CategoryContent instance) =>
    <String, dynamic>{
      'fragment_info': instance.fragment_info,
      'publisher_username': instance.publisher_username,
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

CheckLoginDto _$CheckLoginDtoFromJson(Map<String, dynamic> json) =>
    CheckLoginDto(
      device_and_token_bo: DeviceAndTokenBo.fromJson(
          json['device_and_token_bo'] as Map<String, dynamic>),
      dto_padding_1: json['dto_padding_1'] as bool?,
      dto_padding_2: json['dto_padding_2'] as bool?,
    );

Map<String, dynamic> _$CheckLoginDtoToJson(CheckLoginDto instance) =>
    <String, dynamic>{
      'device_and_token_bo': instance.device_and_token_bo,
      'dto_padding_1': instance.dto_padding_1,
      'dto_padding_2': instance.dto_padding_2,
    };

CheckLoginVo _$CheckLoginVoFromJson(Map<String, dynamic> json) => CheckLoginVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
      vo_padding_2: json['vo_padding_2'] as bool?,
    );

Map<String, dynamic> _$CheckLoginVoToJson(CheckLoginVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
      'vo_padding_2': instance.vo_padding_2,
    };

DataUploadDto _$DataUploadDtoFromJson(Map<String, dynamic> json) =>
    DataUploadDto(
      sync_entity: Sync.fromJson(json['sync_entity'] as Map<String, dynamic>),
      row_map: json['row_map'] as Map<String, dynamic>,
      dto_padding_1: json['dto_padding_1'] as bool?,
      dto_padding_2: json['dto_padding_2'] as bool?,
    );

Map<String, dynamic> _$DataUploadDtoToJson(DataUploadDto instance) =>
    <String, dynamic>{
      'sync_entity': instance.sync_entity,
      'row_map': instance.row_map,
      'dto_padding_1': instance.dto_padding_1,
      'dto_padding_2': instance.dto_padding_2,
    };

DataUploadVo _$DataUploadVoFromJson(Map<String, dynamic> json) => DataUploadVo(
      vo_padding_1: json['vo_padding_1'] as bool?,
      vo_padding_2: json['vo_padding_2'] as bool?,
    );

Map<String, dynamic> _$DataUploadVoToJson(DataUploadVo instance) =>
    <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
      'vo_padding_2': instance.vo_padding_2,
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
      vo_padding_2: json['vo_padding_2'] as bool?,
    );

Map<String, dynamic> _$LogoutVoToJson(LogoutVo instance) => <String, dynamic>{
      'vo_padding_1': instance.vo_padding_1,
      'vo_padding_2': instance.vo_padding_2,
    };

QueryCategorysDto _$QueryCategorysDtoFromJson(Map<String, dynamic> json) =>
    QueryCategorysDto(
      main_category: json['main_category'] as String?,
      sub_category: json['sub_category'] as String?,
      query_category_type:
          $enumDecode(_$QueryCategoryTypeEnumMap, json['query_category_type']),
    );

Map<String, dynamic> _$QueryCategorysDtoToJson(QueryCategorysDto instance) =>
    <String, dynamic>{
      'main_category': instance.main_category,
      'sub_category': instance.sub_category,
      'query_category_type':
          _$QueryCategoryTypeEnumMap[instance.query_category_type]!,
    };

const _$QueryCategoryTypeEnumMap = {
  QueryCategoryType.only_main: 'only_main',
  QueryCategoryType.only_sub: 'only_sub',
  QueryCategoryType.content: 'content',
};

QueryCategorysVo _$QueryCategorysVoFromJson(Map<String, dynamic> json) =>
    QueryCategorysVo(
      category_names: json['category_names'] as String?,
      category_content_list: (json['category_content_list'] as List<dynamic>?)
          ?.map((e) => CategoryContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QueryCategorysVoToJson(QueryCategorysVo instance) =>
    <String, dynamic>{
      'category_names': instance.category_names,
      'category_content_list': instance.category_content_list,
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
