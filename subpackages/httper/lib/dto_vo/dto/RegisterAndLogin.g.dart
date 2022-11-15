// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegisterAndLogin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterAndLogin _$RegisterAndLoginFromJson(Map<String, dynamic> json) =>
    RegisterAndLogin(
      register_or_login: json['register_or_login'] as int,
      id: json['id'] as int?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$RegisterAndLoginToJson(RegisterAndLogin instance) =>
    <String, dynamic>{
      'register_or_login': instance.register_or_login,
      'id': instance.id,
      'username': instance.username,
    };
