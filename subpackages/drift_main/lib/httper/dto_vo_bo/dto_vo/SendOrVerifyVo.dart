
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class SendOrVerifyVo extends BaseObject{

    /// 
    RegisterOrLoginType register_or_login_type;

    /// 当前用户是否为新用户
    bool be_new_user;

    /// 
    User? user_entity;

    /// 当前登录/注册状态时的数据
    DeviceAndTokenBo current_device_and_token_bo;

    /// 注册状态时，当前会话产生的 token 放到 ClientSyncInfos.token 中, 登录状态时，全部的 token 放到这里（不包含当前会话产生的 token）
    List<DeviceAndTokenBo>? device_and_token_bo_list;


SendOrVerifyVo({

    required this.register_or_login_type,

    required this.be_new_user,

    required this.user_entity,

    required this.current_device_and_token_bo,

    required this.device_and_token_bo_list,

});
  factory SendOrVerifyVo.fromJson(Map<String, dynamic> json) => _$SendOrVerifyVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$SendOrVerifyVoToJson(this);
  
  
}
