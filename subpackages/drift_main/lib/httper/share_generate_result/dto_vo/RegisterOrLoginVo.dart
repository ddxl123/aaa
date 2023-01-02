
// ignore_for_file: non_constant_identifier_names
part of httper;
@JsonSerializable()
class RegisterOrLoginVo extends BaseObject{

    /// 
    RegisterOrLoginType register_or_login_type;

    /// 该用户是否已注册过
    bool be_registered;

    /// 是否用户状态是否已登录
    bool? be_logged_in;

    /// 
    DateTime? recent_sync_time;

    /// 
    int? id;

    /// 
    String? token;


RegisterOrLoginVo({

    required this.register_or_login_type,

    required this.be_registered,

    required this.be_logged_in,

    required this.recent_sync_time,

    required this.id,

    required this.token,

});
  factory RegisterOrLoginVo.fromJson(Map<String, dynamic> json) => _$RegisterOrLoginVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$RegisterOrLoginVoToJson(this);
  
  
}
