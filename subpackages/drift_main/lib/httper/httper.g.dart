// GENERATED CODE - DO NOT MODIFY BY HAND

part of httper;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterAndLoginWithUsernameDto _$RegisterAndLoginWithUsernameDtoFromJson(
        Map<String, dynamic> json) =>
    RegisterAndLoginWithUsernameDto(
      username: json['username'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$RegisterAndLoginWithUsernameDtoToJson(
        RegisterAndLoginWithUsernameDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

RegisterAndLoginWithUsernameVo _$RegisterAndLoginWithUsernameVoFromJson(
        Map<String, dynamic> json) =>
    RegisterAndLoginWithUsernameVo(
      register_or_login: json['register_or_login'] as int,
      id: json['id'] as int,
      new_display_order:
          $enumDecode(_$NewDisplayOrderEnumMap, json['new_display_order']),
    );

Map<String, dynamic> _$RegisterAndLoginWithUsernameVoToJson(
        RegisterAndLoginWithUsernameVo instance) =>
    <String, dynamic>{
      'register_or_login': instance.register_or_login,
      'id': instance.id,
      'new_display_order':
          _$NewDisplayOrderEnumMap[instance.new_display_order]!,
    };

const _$NewDisplayOrderEnumMap = {
  NewDisplayOrder.random: 'random',
  NewDisplayOrder.titleA2Z: 'titleA2Z',
  NewDisplayOrder.createEarly2Late: 'createEarly2Late',
};
