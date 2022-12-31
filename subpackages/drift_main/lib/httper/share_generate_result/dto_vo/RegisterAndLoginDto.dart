
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
  StackTrace? st;

  @JsonKey(ignore: true)
  RegisterAndLoginVo? vo;

  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, String message, StackTrace st) otherException,

    // 验证码发送成功！
    required Future<T> Function(String message) code100,
    
    // 验证码不正确！
    required Future<T> Function(String message) code101,
    
    // 登录/注册成功！
    required Future<T> Function(String message, RegisterAndLoginVo vo) code102,
    
    }) async {

    if (code == 100) return await code100(message);

    if (code == 101) return await code101(message);

    if (code == 102) return await code102(message, vo!);

    return await otherException(code, message, st!);
  }
}
