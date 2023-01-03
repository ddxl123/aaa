
// ignore_for_file: non_constant_identifier_names
part of httper;
@JsonSerializable()
class RegisterOrLoginVo extends BaseObject{

    /// 
    RegisterOrLoginType register_or_login_type;

    /// 当前用户是否为新用户
    bool be_new_user;

    /// 是否用户状态是否已登录
    bool? be_logged_in;

    /// 
    DateTime? recent_sync_time;

    /// 
    int? id;

    /// 已在其他地方登录则为空，否则进行登录并带上token
    String? token;


RegisterOrLoginVo({

    required this.register_or_login_type,

    required this.be_new_user,

    required this.be_logged_in,

    required this.recent_sync_time,

    required this.id,

    required this.token,

});
  factory RegisterOrLoginVo.fromJson(Map<String, dynamic> json) => _$RegisterOrLoginVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$RegisterOrLoginVoToJson(this);
  
  
}
