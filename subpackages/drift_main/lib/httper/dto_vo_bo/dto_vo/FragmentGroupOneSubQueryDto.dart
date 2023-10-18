
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupOneSubQueryDto extends BaseObject{

    /// 
    FragmentGroupQueryWrapper fragment_group_query_wrapper;

    /// 填充字段1
    bool? dto_padding_1;


FragmentGroupOneSubQueryDto({

    required this.fragment_group_query_wrapper,

    required this.dto_padding_1,

});
  factory FragmentGroupOneSubQueryDto.fromJson(Map<String, dynamic> json) => _$FragmentGroupOneSubQueryDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupOneSubQueryDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  FragmentGroupOneSubQueryVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 获取成功！
    // explain: 根据单个碎片组id或者userId，查询自身，以及内部的碎片组和碎片成功，不包含子孙。
    required Future<T> Function(String showMessage, FragmentGroupOneSubQueryVo vo) code30401,
    
    }) async {
    try {

        if (code == 30401) return await code30401(httperException!.showMessage, vo!);

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
    if(otherException==null) throw httperException!;
    return await otherException(code, httperException!, st!);
  }
}
