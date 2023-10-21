
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class KnowledgeBaseCategoryQueryDto extends BaseObject{

    /// 查询大类别对应的全部子类别。若为空，则查询首页面的类别。
    String? big_category;

    /// 填充字段1
    bool? dto_padding_1;


KnowledgeBaseCategoryQueryDto({

    required this.big_category,

    required this.dto_padding_1,

});
  factory KnowledgeBaseCategoryQueryDto.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseCategoryQueryDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$KnowledgeBaseCategoryQueryDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  String? successMessage;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  KnowledgeBaseCategoryQueryVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 获取成功！
    // explain: 获取首页面类别（精选类别、大类别）成功
    required Future<T> Function(String showMessage, KnowledgeBaseCategoryQueryVo vo) code30101,
    
    // message: 获取成功！
    // explain: 获取大类别对应的子类别成功
    required Future<T> Function(String showMessage, KnowledgeBaseCategoryQueryVo vo) code30102,
    
    }) async {
    try {

        if (code == 30101) return await code30101(successMessage!, vo!);

        if (code == 30102) return await code30102(successMessage!, vo!);

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
