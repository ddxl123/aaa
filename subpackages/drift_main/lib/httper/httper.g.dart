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
      be_registered: json['be_registered'] as bool,
      id: json['id'] as int?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$RegisterOrLoginVoToJson(RegisterOrLoginVo instance) =>
    <String, dynamic>{
      'register_or_login_type':
          _$RegisterOrLoginTypeEnumMap[instance.register_or_login_type]!,
      'be_registered': instance.be_registered,
      'id': instance.id,
      'token': instance.token,
    };
