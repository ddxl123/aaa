
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentModifyFragmentDto extends BaseObject{

    /// 
    Fragment fragment;

    /// 该碎片要保存到的碎片组的位置集合。需要把原来的位置删除后在新增。若元素为 null，则表示插入到了 root
    List<int?> fragment_group_ids_list;


FragmentModifyFragmentDto({

    required this.fragment,

    required this.fragment_group_ids_list,

});
  factory FragmentModifyFragmentDto.fromJson(Map<String, dynamic> json) => _$FragmentModifyFragmentDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentModifyFragmentDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  String? successMessage;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  FragmentModifyFragmentVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 修改成功！
    // explain: 修改某个碎片，会连带修改的碎片组位置
    required Future<T> Function(String showMessage) code140301,
    
    }) async {
    try {

        if (code == 140301) return await code140301(successMessage!);

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
