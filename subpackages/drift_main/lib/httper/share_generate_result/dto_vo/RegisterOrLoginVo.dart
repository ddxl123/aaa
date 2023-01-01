
// ignore_for_file: non_constant_identifier_names
part of httper;
@JsonSerializable()
class RegisterOrLoginVo extends BaseObject{

    /// 
    RegisterOrLoginType register_or_login_type;

    /// 是否为新注册用户
    bool be_registered;

    /// 
    int? id;

    /// 
    String? token;


RegisterOrLoginVo({

    required this.register_or_login_type,

    required this.be_registered,

    required this.id,

    required this.token,

});
  factory RegisterOrLoginVo.fromJson(Map<String, dynamic> json) => _$RegisterOrLoginVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$RegisterOrLoginVoToJson(this);
  
  
}
