// GENERATED CODE - DO NOT MODIFY BY HAND

part of httper;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceAndTokenBo _$DeviceAndTokenBoFromJson(Map<String, dynamic> json) =>
    DeviceAndTokenBo(
      deviceInfo: json['deviceInfo'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$DeviceAndTokenBoToJson(DeviceAndTokenBo instance) =>
    <String, dynamic>{
      'deviceInfo': instance.deviceInfo,
      'token': instance.token,
    };

RegisterOrLoginDto _$RegisterOrLoginDtoFromJson(Map<String, dynamic> json) =>
    RegisterOrLoginDto(
      register_or_login_type: $enumDecode(
          _$RegisterOrLoginTypeEnumMap, json['register_or_login_type']),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      verify_code: json['verify_code'] as int?,
      device_info: json['device_info'] as String?,
    );

Map<String, dynamic> _$RegisterOrLoginDtoToJson(RegisterOrLoginDto instance) =>
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

RegisterOrLoginVo _$RegisterOrLoginVoFromJson(Map<String, dynamic> json) =>
    RegisterOrLoginVo(
      register_or_login_type: $enumDecode(
          _$RegisterOrLoginTypeEnumMap, json['register_or_login_type']),
      be_new_user: json['be_new_user'] as bool,
      user_entity: json['user_entity'] == null
          ? null
          : User.fromJson(json['user_entity'] as Map<String, dynamic>),
      device_and_token_bo: DeviceAndTokenBo.fromJson(
          json['device_and_token_bo'] as Map<String, dynamic>),
      device_and_token_bo_list:
          (json['device_and_token_bo_list'] as List<dynamic>?)
              ?.map((e) => DeviceAndTokenBo.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$RegisterOrLoginVoToJson(RegisterOrLoginVo instance) =>
    <String, dynamic>{
      'register_or_login_type':
          _$RegisterOrLoginTypeEnumMap[instance.register_or_login_type]!,
      'be_new_user': instance.be_new_user,
      'user_entity': instance.user_entity,
      'device_and_token_bo': instance.device_and_token_bo,
      'device_and_token_bo_list': instance.device_and_token_bo_list,
    };
