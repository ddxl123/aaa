
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class SingleFieldModifyDto extends BaseObject{

    /// 要修改的字段对应的表
    String table_name;

    /// 要修改的字段
    String field_name;

    /// 要修改的字段的 id，可能是 Long 类型，也可能是 String 类型
    dynamic field_id;

    /// 要修改成什么值，若为 null，则会修改成 null，而非保持不变
    dynamic? modify_value;


SingleFieldModifyDto({

    required this.table_name,

    required this.field_name,

    required this.field_id,

    required this.modify_value,

});
  factory SingleFieldModifyDto.fromJson(Map<String, dynamic> json) => _$SingleFieldModifyDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$SingleFieldModifyDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  SingleFieldModifyVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, HttperException httperException, StackTrace st) otherException,

    // message: 修改成功！
    // explain: 任意表的单字段修改，只会修改存在的行，不存在的行不会进行如何操作
    required Future<T> Function(String showMessage) code20201,
    
    }) async {
    try {

        if (code == 20201) return await code20201(httperException!.showMessage);

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
