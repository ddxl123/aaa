
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class QueryFragmentGroupTagByLikeDto extends BaseObject{

    /// 
    String like;

    /// 填充字段1
    bool? dto_padding_1;


QueryFragmentGroupTagByLikeDto({

    required this.like,

    required this.dto_padding_1,

});
  factory QueryFragmentGroupTagByLikeDto.fromJson(Map<String, dynamic> json) => _$QueryFragmentGroupTagByLikeDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$QueryFragmentGroupTagByLikeDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  QueryFragmentGroupTagByLikeVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, HttperException httperException, StackTrace st) otherException,

    // message: 获取模糊标签成功！
    // explain: 每次获取模糊标签成功的响应。
    required Future<T> Function(String showMessage, QueryFragmentGroupTagByLikeVo vo) code50201,
    
    }) async {
    try {

        if (code == 50201) return await code50201(httperException!.showMessage, vo!);

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