
// ignore_for_file: non_constant_identifier_names
import 'package:drift_main/share_common/share_enum.dart';

import '../../BaseObject.dart';
import 'package:json_annotation/json_annotation.dart';

part 'RegisterAndLoginWithUsernameVo.g.dart';
@JsonSerializable()
class RegisterAndLoginWithUsernameVo extends BaseObject{

    /// 0-注册，1-登录
    int register_or_login;

    ///
    int? id;

    /// 
    NewDisplayOrder? new_display_order;


RegisterAndLoginWithUsernameVo({

    required this.register_or_login,

    required this.id,

    required this.new_display_order,

});
  factory RegisterAndLoginWithUsernameVo.fromJson(Map<String, dynamic> json) => _$RegisterAndLoginWithUsernameVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$RegisterAndLoginWithUsernameVoToJson(this);
  
  
}
