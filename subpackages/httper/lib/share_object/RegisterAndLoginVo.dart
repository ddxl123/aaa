
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'RegisterAndLoginVo.g.dart';
@JsonSerializable()
class RegisterAndLoginVo {

    /// 0-注册，1-登录
    int register_or_login;

    /// 
    int? id;

RegisterAndLoginVo({

    required this.register_or_login,

    required this.id,

});
    factory RegisterAndLoginVo.fromJson(Map<String, dynamic> json) => _$RegisterAndLoginVoFromJson(json);
    Map<String, dynamic> toJson() => _$RegisterAndLoginVoToJson(this);
}
