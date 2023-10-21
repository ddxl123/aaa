
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupsDeleteDto extends BaseObject{

    /// 要删除的顶层组的 id。
    List<int> fragment_group_ids_list;

    /// 填充字段1
    bool? dto_padding_1;


FragmentGroupsDeleteDto({

    required this.fragment_group_ids_list,

    required this.dto_padding_1,

});
  factory FragmentGroupsDeleteDto.fromJson(Map<String, dynamic> json) => _$FragmentGroupsDeleteDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupsDeleteDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  String? successMessage;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  FragmentGroupsDeleteVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 删除成功！
    // explain: 将多个碎片组进行删除。直接删除已选碎片组，其子碎片组的 father 将不为空，但找不到。
    required Future<T> Function(String showMessage) code150901,
    
    }) async {
    try {

        if (code == 150901) return await code150901(successMessage!);

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
