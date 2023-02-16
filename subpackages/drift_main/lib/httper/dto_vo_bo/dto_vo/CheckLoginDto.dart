
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class CheckLoginDto extends BaseObject{

    /// 检查 user 的同时，必须同时检查这个
    DeviceAndTokenBo device_and_token_bo;

    /// 填充字段1
    bool? dto_padding_1;

    /// 填充字段2
    bool? dto_padding_2;


CheckLoginDto({

    required this.device_and_token_bo,

    required this.dto_padding_1,

    required this.dto_padding_2,

});
  factory CheckLoginDto.fromJson(Map<String, dynamic> json) => _$CheckLoginDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$CheckLoginDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  CheckLoginVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, HttperException httperException, StackTrace st) otherException,

    // message: 已登录！
    // explain: 用户已登录
    required Future<T> Function(String showMessage) code10301,
    
    // message: 未登录！
    // explain: 用户未登录
    required Future<T> Function(String showMessage) code10302,
    
    }) async {
    try {

        if (code == 10301) return await code10301(httperException!.showMessage);

        if (code == 10302) return await code10302(httperException!.showMessage);

    } catch (e, st) {
      if (e is HttperException) {
        return await otherException(code, e, st);
      }
      return await otherException(code, HttperException(showMessage: '请求异常！', debugMessage: e.toString()), st);
    }
    if (code != null) {
      return await otherException(code, HttperException(showMessage: '请求异常！', debugMessage: '响应码 $code 未处理！'), st!);
    }
    return await otherException(code, httperException!, st!);
  }
}