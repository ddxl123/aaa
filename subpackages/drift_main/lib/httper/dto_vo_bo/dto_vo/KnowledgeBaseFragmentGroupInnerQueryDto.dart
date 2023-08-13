
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class KnowledgeBaseFragmentGroupInnerQueryDto extends BaseObject{

    /// 要查询的碎片组 id。若为 null，则 user_id 不能为 null，因为需利用 user_id 查询 root
    String? fragment_group_id;

    /// 要查询的 root 的 user_id。若为 null，则 fragment_group_id 不能为 null
    int? user_id;


KnowledgeBaseFragmentGroupInnerQueryDto({

    required this.fragment_group_id,

    required this.user_id,

});
  factory KnowledgeBaseFragmentGroupInnerQueryDto.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseFragmentGroupInnerQueryDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$KnowledgeBaseFragmentGroupInnerQueryDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  KnowledgeBaseFragmentGroupInnerQueryVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, HttperException httperException, StackTrace st) otherException,

    // message: 获取成功！
    // explain: 根据单个碎片组id或者userId，查询内部的碎片组和碎片成功。
    required Future<T> Function(String showMessage, KnowledgeBaseFragmentGroupInnerQueryVo vo) code30401,
    
    }) async {
    try {

        if (code == 30401) return await code30401(httperException!.showMessage, vo!);

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
