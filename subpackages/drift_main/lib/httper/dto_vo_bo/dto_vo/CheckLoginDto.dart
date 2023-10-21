
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class CheckLoginDto extends BaseObject{

    /// 检查 user 的同时，必须同时检查这个
    DeviceAndTokenBo device_and_token_bo;

    /// 填充字段1
    bool? dto_padding_1;


CheckLoginDto({

    required this.device_and_token_bo,

    required this.dto_padding_1,

});
  factory CheckLoginDto.fromJson(Map<String, dynamic> json) => _$CheckLoginDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$CheckLoginDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  String? successMessage;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  CheckLoginVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 已登录！
    // explain: 用户已登录
    required Future<T> Function(String showMessage) code10301,
    
    // message: 未登录！
    // explain: 用户未登录，包含token失效。
    required Future<T> Function(String showMessage) code10302,
    
    }) async {
    try {

        if (code == 10301) return await code10301(successMessage!);

        if (code == 10302) return await code10302(successMessage!);

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
