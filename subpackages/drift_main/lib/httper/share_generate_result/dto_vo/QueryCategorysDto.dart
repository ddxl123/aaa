
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class QueryCategorysDto extends BaseObject{

    /// 查询主类别
    String? main_category;

    /// 查询子类别
    String? sub_category;

    /// 排序类型
    CurrentSortType current_sort_type;


QueryCategorysDto({

    required this.main_category,

    required this.sub_category,

    required this.current_sort_type,

});
  factory QueryCategorysDto.fromJson(Map<String, dynamic> json) => _$QueryCategorysDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$QueryCategorysDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  QueryCategorysVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, HttperException httperException, StackTrace st) otherException,

    // message: 获取主类别成功！
    // explain: 
    required Future<T> Function(String showMessage, QueryCategorysVo vo) code30101,
    
    // message: 获取子类别成功！
    // explain: 
    required Future<T> Function(String showMessage, QueryCategorysVo vo) code30102,
    
    // message: 获取数据成功！
    // explain: 
    required Future<T> Function(String showMessage, QueryCategorysVo vo) code30103,
    
    }) async {
    try {

        if (code == 30101) return await code30101(httperException!.showMessage, vo!);

        if (code == 30102) return await code30102(httperException!.showMessage, vo!);

        if (code == 30103) return await code30103(httperException!.showMessage, vo!);

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
