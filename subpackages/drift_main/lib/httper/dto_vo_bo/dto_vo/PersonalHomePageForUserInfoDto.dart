
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class PersonalHomePageForUserInfoDto extends BaseObject{

    /// 要查询的用户
    int user_id;

    /// 填充字段1
    bool? dto_padding_1;


PersonalHomePageForUserInfoDto({

    required this.user_id,

    required this.dto_padding_1,

});
  factory PersonalHomePageForUserInfoDto.fromJson(Map<String, dynamic> json) => _$PersonalHomePageForUserInfoDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$PersonalHomePageForUserInfoDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  PersonalHomePageForUserInfoVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, HttperException httperException, StackTrace st) otherException,

    // message: 获取成功！
    // explain: 获取用户信息，不包含敏感信息，敏感信息在云端就将其设为不可识别的
    required Future<T> Function(String showMessage, PersonalHomePageForUserInfoVo vo) code70301,
    
    }) async {
    try {

        if (code == 70301) return await code70301(httperException!.showMessage, vo!);

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
