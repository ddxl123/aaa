
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentQueryFragmentGroupWithRDto extends BaseObject{

    /// 
    int user_id;

    /// 
    int fragment_id;


FragmentQueryFragmentGroupWithRDto({

    required this.user_id,

    required this.fragment_id,

});
  factory FragmentQueryFragmentGroupWithRDto.fromJson(Map<String, dynamic> json) => _$FragmentQueryFragmentGroupWithRDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentQueryFragmentGroupWithRDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  FragmentQueryFragmentGroupWithRVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 获取成功
    // explain: 获取在某个用户中的碎片对应的碎片组和r集合成功。
    required Future<T> Function(String showMessage, FragmentQueryFragmentGroupWithRVo vo) code140101,
    
    }) async {
    try {

        if (code == 140101) return await code140101(httperException!.showMessage, vo!);

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
