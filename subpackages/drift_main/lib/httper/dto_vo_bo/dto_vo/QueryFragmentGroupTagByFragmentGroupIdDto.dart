
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class QueryFragmentGroupTagByFragmentGroupIdDto extends BaseObject{

    /// 
    int fragment_group_id;

    /// 填充字段1
    bool? dto_padding_1;


QueryFragmentGroupTagByFragmentGroupIdDto({

    required this.fragment_group_id,

    required this.dto_padding_1,

});
  factory QueryFragmentGroupTagByFragmentGroupIdDto.fromJson(Map<String, dynamic> json) => _$QueryFragmentGroupTagByFragmentGroupIdDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$QueryFragmentGroupTagByFragmentGroupIdDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  QueryFragmentGroupTagByFragmentGroupIdVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 获取成功！
    // explain: 每次获取某个碎片组标签成功的响应。
    required Future<T> Function(String showMessage, QueryFragmentGroupTagByFragmentGroupIdVo vo) code50101,
    
    }) async {
    try {

        if (code == 50101) return await code50101(httperException!.showMessage, vo!);

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
