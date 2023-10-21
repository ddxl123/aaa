
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class SendOrVerifyDto extends BaseObject{

    /// 
    RegisterOrLoginType register_or_login_type;

    /// 
    String? bind_email;

    /// 
    String? bind_phone;

    /// 
    int? verify_code;

    /// 验证验证码成功后，必须带上设备数据进行登录/注册，以便鉴别多设备登录！
    String? device_info;


SendOrVerifyDto({

    required this.register_or_login_type,

    required this.bind_email,

    required this.bind_phone,

    required this.verify_code,

    required this.device_info,

});
  factory SendOrVerifyDto.fromJson(Map<String, dynamic> json) => _$SendOrVerifyDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$SendOrVerifyDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  String? successMessage;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  SendOrVerifyVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 验证码发送成功！
    // explain: 
    required Future<T> Function(String showMessage) code10101,
    
    // message: 验证码不正确！
    // explain: 
    required Future<T> Function(String showMessage) code10102,
    
    // message: 验证成功！
    // explain: 
    required Future<T> Function(String showMessage, SendOrVerifyVo vo) code10103,
    
    }) async {
    try {

        if (code == 10101) return await code10101(successMessage!);

        if (code == 10102) return await code10102(successMessage!);

        if (code == 10103) return await code10103(successMessage!, vo!);

    } catch (handleE, handleSt) {
      if (otherException == null) {
        if (httperException != null) {
          throw httperException!;
        }
        rethrow;
      }
      if (httperException != null) {
        return await otherException(code, httperException!, st ?? handleSt);
      }
      if (handleE is HttperException) {
        return await otherException(code, handleE, handleSt);
      }
      return await otherException(code, HttperException(showMessage: '请求异常！', debugMessage: handleE.toString()), handleSt);
    }
    // 当以流的形式响应时，下面代码被忽略。
    if (code != null) {
      if(otherException==null) throw HttperException(showMessage: '请求异常！', debugMessage: '响应码 $code 未处理！');
      return await otherException(code, HttperException(showMessage: '请求异常！', debugMessage: '响应码 $code 未处理！'), st!);
    }
    if(otherException==null) {
      throw HttperException(showMessage: "请求异常", debugMessage: '子 handleCode 异常：\n子 code：$code\n子 StackTrace：\n$st\n${httperException!.showMessage}\n${httperException!.debugMessage}');
    }
    return await otherException(code, httperException!, st!);
  }
}
