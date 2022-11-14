
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'RegisterAndLogin.g.dart';
@JsonSerializable()
class RegisterAndLogin {

    /// 0-注册，1-登录
    int register_or_login;

    /// 
    int? id;

    /// 
    String? username;

RegisterAndLogin({

    required this.register_or_login,

    required this.id,

    required this.username,

});
    factory RegisterAndLogin.fromJson(Map<String, dynamic> json) => _$RegisterAndLoginFromJson(json);
    Map<String, dynamic> toJson() => _$RegisterAndLoginToJson(this);
}
