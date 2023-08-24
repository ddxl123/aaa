
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupsMoveDto extends BaseObject{

    /// 要移动的顶层碎片组，前端需要修改 father_id ，后端直接进行更新。
    List<FragmentGroup> fragment_groups_list;

    /// 填充字段1
    bool? dto_padding_1;


FragmentGroupsMoveDto({

    required this.fragment_groups_list,

    required this.dto_padding_1,

});
  factory FragmentGroupsMoveDto.fromJson(Map<String, dynamic> json) => _$FragmentGroupsMoveDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupsMoveDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  FragmentGroupsMoveVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 获取成功！
    // explain: 将多个碎片组，移动到其他单个碎片组中。前端修改 father_id ，后端进行更新。
    required Future<T> Function(String showMessage) code150501,
    
    }) async {
    try {

        if (code == 150501) return await code150501(httperException!.showMessage);

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
