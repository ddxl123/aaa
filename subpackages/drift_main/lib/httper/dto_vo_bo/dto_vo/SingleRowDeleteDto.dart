
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class SingleRowDeleteDto extends BaseObject{

    /// 要删除的行的表
    String table_name;

    /// 要删除的行 id
    int row_id;


SingleRowDeleteDto({

    required this.table_name,

    required this.row_id,

});
  factory SingleRowDeleteDto.fromJson(Map<String, dynamic> json) => _$SingleRowDeleteDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$SingleRowDeleteDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  SingleRowDeleteVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 删除成功！
    // explain: 删除的成功响应。若不存在，则无操作。
    required Future<T> Function(String showMessage) code120101,
    
    }) async {
    try {

        if (code == 120101) return await code120101(httperException!.showMessage);

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
