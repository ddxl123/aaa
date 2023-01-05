
// ignore_for_file: non_constant_identifier_names
part of httper;
@JsonSerializable()
class RegisterOrLoginVo extends BaseObject{

    /// 
    RegisterOrLoginType register_or_login_type;

    /// 当前用户是否为新用户
    bool be_new_user;

    /// 当前用户是否以存在登录(可能在其他多个地方登录)
    bool? be_exist_logged_in;

    /// 
    User? user_entity;

    /// 注册状态时，当前会话产生的 token 放到 User 实体中, 登录状态时，全部的 token 放到这里（包含当前会话产生的 token）
    List<DeviceAndTokenBo>? device_and_token_bo_list;


RegisterOrLoginVo({

    required this.register_or_login_type,

    required this.be_new_user,

    required this.be_exist_logged_in,

    required this.user_entity,

    required this.device_and_token_bo_list,

});
  factory RegisterOrLoginVo.fromJson(Map<String, dynamic> json) => _$RegisterOrLoginVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$RegisterOrLoginVoToJson(this);
  
  
}
