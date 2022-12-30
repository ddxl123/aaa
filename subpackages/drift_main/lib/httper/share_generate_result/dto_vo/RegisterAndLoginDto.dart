
// ignore_for_file: non_constant_identifier_names
part of httper;
@JsonSerializable()
class RegisterAndLoginDto extends BaseObject{

    /// 
    RegisterAndLoginType register_and_login_type;

    /// 
    String? email;

    /// 
    String? phone;

    /// 
    int? verify_code;


RegisterAndLoginDto({

    required this.register_and_login_type,

    required this.email,

    required this.phone,

    required this.verify_code,

});
  factory RegisterAndLoginDto.fromJson(Map<String, dynamic> json) => _$RegisterAndLoginDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$RegisterAndLoginDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  String message = "未分配 message！";

  @JsonKey(ignore: true)
  RegisterAndLoginVo? vo;

  T handleCode<T>({
    // 前端 request 内部异常，统一只需消息。
    required T Function(String message) localExceptionMessage,
    

    // 验证码发送成功！
    required T Function(String message) code100,
    
    // 验证码不正确！
    required T Function(String message) code101,
    
    // 登录/注册成功！
    required T Function(String message, RegisterAndLoginVo vo) code102,
    
                
    }) {
    

    if (code == 100) {
        return code100(message);
    }

    if (code == 101) {
        return code101(message);
    }

    if (code == 102) {
        return code102(message, vo!);
    }

                
    throw "未处理 code:$code";
  }
      
}
