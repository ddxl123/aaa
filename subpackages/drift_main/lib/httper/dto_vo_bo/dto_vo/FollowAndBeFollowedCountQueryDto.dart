
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FollowAndBeFollowedCountQueryDto extends BaseObject{

    /// 要查询的用户
    int user_id;

    /// 填充字段1
    bool? dto_padding_1;


FollowAndBeFollowedCountQueryDto({

    required this.user_id,

    required this.dto_padding_1,

});
  factory FollowAndBeFollowedCountQueryDto.fromJson(Map<String, dynamic> json) => _$FollowAndBeFollowedCountQueryDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FollowAndBeFollowedCountQueryDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  FollowAndBeFollowedCountQueryVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 获取成功！
    // explain: 获取指定用户的关注数量和被关注数量
    required Future<T> Function(String showMessage, FollowAndBeFollowedCountQueryVo vo) code70401,
    
    }) async {
    try {

        if (code == 70401) return await code70401(httperException!.showMessage, vo!);

    } catch (e, st) {
      if (otherException == null) rethrow;
      if (e is HttperException) {
        return await otherException(code, e, st);
      }
      return await otherException(code, HttperException(showMessage: '请求异常！', debugMessage: e.toString()), st);
    }
    if (code != null) {
      if(otherException==null) throw HttperException(showMessage: '请求异常！', debugMessage: '响应码 $code 未处理！');
      return await otherException(code, HttperException(showMessage: '请求异常！', debugMessage: '响应码 $code 未处理！'), st!);
    }
    if(otherException==null) throw httperException!;
    return await otherException(code, httperException!, st!);
  }
}
