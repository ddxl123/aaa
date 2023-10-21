
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class SingleFieldModifyDto extends BaseObject{

    /// 要修改的字段对应的表
    String table_name;

    /// 要修改的字段的 id，可能是 Long 类型，也可能是 String 类型
    dynamic row_id;

    /// 要修改的字段
    String field_name;

    /// 要修改成什么值，若为 null，则会修改成 null，而非保持不变
    dynamic? modify_value;


SingleFieldModifyDto({

    required this.table_name,

    required this.row_id,

    required this.field_name,

    required this.modify_value,

});
  factory SingleFieldModifyDto.fromJson(Map<String, dynamic> json) => _$SingleFieldModifyDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$SingleFieldModifyDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  String? successMessage;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  SingleFieldModifyVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 修改成功！
    // explain: 任意表的单字段修改，只会修改存在的行，不存在的行不会进行如何操作
    required Future<T> Function(String showMessage) code80101,
    
    }) async {
    try {

        if (code == 80101) return await code80101(successMessage!);

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
