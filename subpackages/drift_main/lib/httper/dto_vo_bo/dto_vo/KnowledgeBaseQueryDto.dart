
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class KnowledgeBaseQueryDto extends BaseObject{

    /// 查询主类别
    String? main_category;

    /// 查询子类别
    String? sub_category;

    /// 排序类型
    KnowledgeBaseContentSortType? knowledge_base_content_sort_type;

    /// 分页每页数量，用 Long 类型
    int? size;

    /// 要查询第几页，用 Long 类型，从 0 开始
    int? page;


KnowledgeBaseQueryDto({

    required this.main_category,

    required this.sub_category,

    required this.knowledge_base_content_sort_type,

    required this.size,

    required this.page,

});
  factory KnowledgeBaseQueryDto.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseQueryDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$KnowledgeBaseQueryDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  KnowledgeBaseQueryVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, HttperException httperException, StackTrace st) otherException,

    // message: 获取主类别成功！
    // explain: 
    required Future<T> Function(String showMessage, KnowledgeBaseQueryVo vo) code30101,
    
    // message: 获取子类别成功！
    // explain: 
    required Future<T> Function(String showMessage, KnowledgeBaseQueryVo vo) code30102,
    
    // message: 获取数据成功！
    // explain: 
    required Future<T> Function(String showMessage, KnowledgeBaseQueryVo vo) code30103,
    
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
