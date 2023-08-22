
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentInsertFragmentDto extends BaseObject{

    /// 
    Fragment fragment;

    /// 若元素为 null，则表示插入到了 root
    List<int?> fragment_group_ids_list;


FragmentInsertFragmentDto({

    required this.fragment,

    required this.fragment_group_ids_list,

});
  factory FragmentInsertFragmentDto.fromJson(Map<String, dynamic> json) => _$FragmentInsertFragmentDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentInsertFragmentDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  FragmentInsertFragmentVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 添加成功！
    // explain: 将碎片插入至多个碎片组中成功
    required Future<T> Function(String showMessage, FragmentInsertFragmentVo vo) code140201,
    
    }) async {
    try {

        if (code == 140201) return await code140201(httperException!.showMessage, vo!);

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
