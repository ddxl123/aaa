
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class SingleRowQueryDto extends BaseObject{

    /// 要查询的字段对应的表
    String table_name;

    /// 要查询的行的 id
    int row_id;


SingleRowQueryDto({

    required this.table_name,

    required this.row_id,

});
  factory SingleRowQueryDto.fromJson(Map<String, dynamic> json) => _$SingleRowQueryDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$SingleRowQueryDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  SingleRowQueryVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 查询成功！
    // explain: 任意表单行查询，敏感信息将被置空或加密
    required Future<T> Function(String showMessage, SingleRowQueryVo vo) code90101,
    
    }) async {
    try {

        if (code == 90101) return await code90101(httperException!.showMessage, vo!);

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
