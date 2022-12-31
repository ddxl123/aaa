// GENERATED CODE - DO NOT MODIFY BY HAND

part of httper;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterAndLoginDto _$RegisterAndLoginDtoFromJson(Map<String, dynamic> json) =>
    RegisterAndLoginDto(
      register_and_login_type: $enumDecode(
          _$RegisterAndLoginTypeEnumMap, json['register_and_login_type']),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      verify_code: json['verify_code'] as int?,
    );

Map<String, dynamic> _$RegisterAndLoginDtoToJson(
        RegisterAndLoginDto instance) =>
    <String, dynamic>{
      'register_and_login_type':
          _$RegisterAndLoginTypeEnumMap[instance.register_and_login_type]!,
      'email': instance.email,
      'phone': instance.phone,
      'verify_code': instance.verify_code,
    };

const _$RegisterAndLoginTypeEnumMap = {
  RegisterAndLoginType.email_send: 'email_send',
  RegisterAndLoginType.email_verify: 'email_verify',
  RegisterAndLoginType.phone_send: 'phone_send',
  RegisterAndLoginType.phone_verify: 'phone_verify',
};

RegisterAndLoginVo _$RegisterAndLoginVoFromJson(Map<String, dynamic> json) =>
    RegisterAndLoginVo(
      register_and_login_type: $enumDecode(
          _$RegisterAndLoginTypeEnumMap, json['register_and_login_type']),
      is_registered: json['is_registered'] as bool,
      id: json['id'] as int?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$RegisterAndLoginVoToJson(RegisterAndLoginVo instance) =>
    <String, dynamic>{
      'register_and_login_type':
          _$RegisterAndLoginTypeEnumMap[instance.register_and_login_type]!,
      'is_registered': instance.is_registered,
      'id': instance.id,
      'token': instance.token,
    };
