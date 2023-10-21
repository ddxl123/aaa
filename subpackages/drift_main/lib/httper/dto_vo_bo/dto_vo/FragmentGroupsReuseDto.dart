
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupsReuseDto extends BaseObject{

    /// 要复用的顶层组，前端创建实体，后端直接进行插入。
    List<FragmentGroup> fragment_groups_list;

    /// 填充字段1
    bool? dto_padding_1;


FragmentGroupsReuseDto({

    required this.fragment_groups_list,

    required this.dto_padding_1,

});
  factory FragmentGroupsReuseDto.fromJson(Map<String, dynamic> json) => _$FragmentGroupsReuseDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupsReuseDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  String? successMessage;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  FragmentGroupsReuseVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 复用成功！
    // explain: 将多个碎片组，复用到其他单个碎片组中。前端创建实体，后端直接进行插入。
    required Future<T> Function(String showMessage) code150701,
    
    }) async {
    try {

        if (code == 150701) return await code150701(successMessage!);

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
