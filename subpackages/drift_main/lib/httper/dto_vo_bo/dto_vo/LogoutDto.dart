
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class LogoutDto extends BaseObject{

    /// 该下线操作是否为已登录用户的在当前 deviceInfo 下的主动下线行为。当前设备在其他地方被下线时为 false。【取消本次登录】时为 false。
    bool be_active;

    /// 当前登录的会话
    DeviceAndTokenBo current_device_and_token_bo;

    /// 将下线的 token。若为 null，则下线全部（除了当前会话）
    DeviceAndTokenBo? device_and_token_bo;


LogoutDto({

    required this.be_active,

    required this.current_device_and_token_bo,

    required this.device_and_token_bo,

});
  factory LogoutDto.fromJson(Map<String, dynamic> json) => _$LogoutDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$LogoutDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  String? successMessage;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  LogoutVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 已下线其他全部登录！
    // explain: 当前登录 token 不进行下线。
    required Future<T> Function(String showMessage) code10201,
    
    // message: 下线成功！
    // explain: 只会下线指定 token，如果下线的是当前登录的 token，不使用该 code。
    required Future<T> Function(String showMessage) code10202,
    
    // message: 已取消本次登录！
    // explain: 只下线当前登录的 token。
    required Future<T> Function(String showMessage) code10203,
    
    // message: 退出账号成功！
    // explain: 客户端主动下线。
    required Future<T> Function(String showMessage) code10204,
    
    // message: 当前登录会话在服务端并未登录，因此您无权限对其进行下线！
    // explain: 请求的 current_token 在服务端已被下线过！
    required Future<T> Function(String showMessage) code10205,
    
    }) async {
    try {

        if (code == 10201) return await code10201(successMessage!);

        if (code == 10202) return await code10202(successMessage!);

        if (code == 10203) return await code10203(successMessage!);

        if (code == 10204) return await code10204(successMessage!);

        if (code == 10205) return await code10205(successMessage!);

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
