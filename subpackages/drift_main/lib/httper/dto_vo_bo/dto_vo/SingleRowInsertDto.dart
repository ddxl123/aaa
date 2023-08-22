
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class SingleRowInsertDto extends BaseObject{

    /// 要插入的行的表
    String table_name;

    /// 要插入的行，不带id
    dynamic row;


SingleRowInsertDto({

    required this.table_name,

    required this.row,

});
  factory SingleRowInsertDto.fromJson(Map<String, dynamic> json) => _$SingleRowInsertDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$SingleRowInsertDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  SingleRowInsertVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 插入成功！
    // explain: 插入的成功响应
    required Future<T> Function(String showMessage, SingleRowInsertVo vo) code100101,
    
    }) async {
    try {

        if (code == 100101) return await code100101(httperException!.showMessage, vo!);

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
