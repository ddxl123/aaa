
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class GetCategorysDto extends BaseObject{

    /// 
    String a;


GetCategorysDto({

    required this.a,

});
  factory GetCategorysDto.fromJson(Map<String, dynamic> json) => _$GetCategorysDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$GetCategorysDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  GetCategorysVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, HttperException httperException, StackTrace st) otherException,

    // message: 获取成功！
    // explain: 成功获取全部知识库类别。
    required Future<T> Function(String showMessage, GetCategorysVo vo) code30101,
    
    }) async {
    try {

        if (code == 30101) return await code30101(httperException!.showMessage, vo!);

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
