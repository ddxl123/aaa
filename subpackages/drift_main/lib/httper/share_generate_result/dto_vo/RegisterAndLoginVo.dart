
// ignore_for_file: non_constant_identifier_names
part of httper;
@JsonSerializable()
class RegisterAndLoginVo extends BaseObject{

    /// 
    RegisterAndLoginType register_and_login_type;

    /// 是否为新注册用户
    bool is_registered;

    /// 
    int? id;

    /// 
    String? token;


RegisterAndLoginVo({

    required this.register_and_login_type,

    required this.is_registered,

    required this.id,

    required this.token,

});
  factory RegisterAndLoginVo.fromJson(Map<String, dynamic> json) => _$RegisterAndLoginVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$RegisterAndLoginVoToJson(this);
  
  
}
