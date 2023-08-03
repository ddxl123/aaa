
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class KnowledgeBaseCategoryModifyDto extends BaseObject{

    /// 
    ModifyKnowledgeBaseCategory modify_knowledge_base_category;

    /// 填充字段1
    bool? dto_padding_1;


KnowledgeBaseCategoryModifyDto({

    required this.modify_knowledge_base_category,

    required this.dto_padding_1,

});
  factory KnowledgeBaseCategoryModifyDto.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseCategoryModifyDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$KnowledgeBaseCategoryModifyDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  KnowledgeBaseCategoryModifyVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, HttperException httperException, StackTrace st) otherException,

    // message: 更新成功！
    // explain: 更新知识库的类别
    required Future<T> Function(String showMessage) code30201,
    
    }) async {
    try {

        if (code == 30201) return await code30201(httperException!.showMessage);

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
