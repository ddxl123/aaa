
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FollowOrBeFollowedListQueryDto extends BaseObject{

    /// 要查询的用户
    int user_id;

    /// true - 关注列表；false - 被关注列表
    bool follow_or_be_followed;


FollowOrBeFollowedListQueryDto({

    required this.user_id,

    required this.follow_or_be_followed,

});
  factory FollowOrBeFollowedListQueryDto.fromJson(Map<String, dynamic> json) => _$FollowOrBeFollowedListQueryDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FollowOrBeFollowedListQueryDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  FollowOrBeFollowedListQueryVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 获取成功！
    // explain: 查询某个用户的关注用户列表或被关注用户列表，只获取对应的头像path以及用户名
    required Future<T> Function(String showMessage, FollowOrBeFollowedListQueryVo vo) code70601,
    
    }) async {
    try {

        if (code == 70601) return await code70601(httperException!.showMessage, vo!);

    } catch (handleE, handleSt) {
      if (otherException == null) {
        if (httperException != null) {
          throw httperException!;
        }
        rethrow;
      }
      if (httperException != null) {
        return await otherException(code, httperException!, st!);
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
    if(otherException==null) throw httperException!;
    return await otherException(code, httperException!, st!);
  }
}
