
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentsReuseDto extends BaseObject{

    /// 
    List<RFragment2FragmentGroup> r_fragment_2_fragment_groups_list;

    /// 填充字段1
    bool? dto_padding_1;


FragmentsReuseDto({

    required this.r_fragment_2_fragment_groups_list,

    required this.dto_padding_1,

});
  factory FragmentsReuseDto.fromJson(Map<String, dynamic> json) => _$FragmentsReuseDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentsReuseDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  FragmentsReuseVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 复用成功！
    // explain: 复用碎片。主要对 r 进行增加。需在前端创建实体，在后端直接save
    required Future<T> Function(String showMessage) code150801,
    
    }) async {
    try {

        if (code == 150801) return await code150801(httperException!.showMessage);

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
