// GENERATED CODE - DO NOT MODIFY BY HAND

part of httper;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterOrLoginDto _$RegisterOrLoginDtoFromJson(Map<String, dynamic> json) =>
    RegisterOrLoginDto(
      register_or_login_type: $enumDecode(
          _$RegisterOrLoginTypeEnumMap, json['register_or_login_type']),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      verify_code: json['verify_code'] as int?,
    );

Map<String, dynamic> _$RegisterOrLoginDtoToJson(RegisterOrLoginDto instance) =>
    <String, dynamic>{
      'register_or_login_type':
          _$RegisterOrLoginTypeEnumMap[instance.register_or_login_type]!,
      'email': instance.email,
      'phone': instance.phone,
      'verify_code': instance.verify_code,
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
      be_logged_in: json['be_logged_in'] as bool?,
      recent_sync_time: json['recent_sync_time'] == null
          ? null
          : DateTime.parse(json['recent_sync_time'] as String),
      id: json['id'] as int?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$RegisterOrLoginVoToJson(RegisterOrLoginVo instance) =>
    <String, dynamic>{
      'register_or_login_type':
          _$RegisterOrLoginTypeEnumMap[instance.register_or_login_type]!,
      'be_new_user': instance.be_new_user,
      'be_logged_in': instance.be_logged_in,
      'recent_sync_time': instance.recent_sync_time?.toIso8601String(),
      'id': instance.id,
      'token': instance.token,
    };
