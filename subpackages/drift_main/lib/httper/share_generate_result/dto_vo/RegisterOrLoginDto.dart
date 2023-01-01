
// ignore_for_file: non_constant_identifier_names
part of httper;
@JsonSerializable()
class RegisterOrLoginDto extends BaseObject{

    /// 
    RegisterOrLoginType register_or_login_type;

    /// 
    String? email;

    /// 
    String? phone;

    /// 
    int? verify_code;


RegisterOrLoginDto({

    required this.register_or_login_type,

    required this.email,

    required this.phone,

    required this.verify_code,

});
  factory RegisterOrLoginDto.fromJson(Map<String, dynamic> json) => _$RegisterOrLoginDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$RegisterOrLoginDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperMessage? httperMessage;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  RegisterOrLoginVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, HttperMessage httperException, StackTrace st) otherException,

    // 验证码发送成功！
    required Future<T> Function(String showMessage) code100,
    
    // 验证码不正确！
    required Future<T> Function(String showMessage) code101,
    
    // 登录/注册成功！
    required Future<T> Function(String showMessage, RegisterOrLoginVo vo) code102,
    
    }) async {
    try {

        if (code == 100) return await code100(httperMessage!.showMessage);

        if (code == 101) return await code101(httperMessage!.showMessage);

        if (code == 102) return await code102(httperMessage!.showMessage, vo!);

    } catch (e, st) {
      if (e is HttperMessage) {
        return await otherException(code, e, st);
      }
      return await otherException(code, HttperMessage(showMessage: '请求异常！', debugMessage: e.toString()), st);
    }
    if (code != null) {
      return await otherException(code, HttperMessage(showMessage: '请求异常！', debugMessage: '响应码 $code 未处理！'), st!);
    }
    return await otherException(code, httperMessage!, st!);
  }
}
