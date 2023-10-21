
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class KnowledgeBaseFragmentGroupQueryDto extends BaseObject{

    /// 要查询哪些子类别的碎片组。当为空数组时，查询全部。
    List<String> sub_categories_list;

    /// 如何排序
    KnowledgeBaseContentSortType knowledge_base_content_sort_type;

    /// 当前页码
    int page;

    /// 每页大小
    int size;


KnowledgeBaseFragmentGroupQueryDto({

    required this.sub_categories_list,

    required this.knowledge_base_content_sort_type,

    required this.page,

    required this.size,

});
  factory KnowledgeBaseFragmentGroupQueryDto.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseFragmentGroupQueryDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$KnowledgeBaseFragmentGroupQueryDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  String? successMessage;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  KnowledgeBaseFragmentGroupQueryVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 获取成功！
    // explain: 获取知识库碎片
    required Future<T> Function(String showMessage, KnowledgeBaseFragmentGroupQueryVo vo) code30301,
    
    }) async {
    try {

        if (code == 30301) return await code30301(successMessage!, vo!);

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
    if(otherException==null) {
      throw HttperException(showMessage: "请求异常", debugMessage: '子 handleCode 异常：\n子 code：$code\n子 StackTrace：\n$st\n${httperException!.showMessage}\n${httperException!.debugMessage}');
    }
    return await otherException(code, httperException!, st!);
  }
}
