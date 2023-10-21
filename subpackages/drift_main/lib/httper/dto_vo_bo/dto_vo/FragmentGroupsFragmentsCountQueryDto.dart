
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupsFragmentsCountQueryDto extends BaseObject{

    /// 
    List<int> fragment_group_ids_list;

    /// 
    bool is_contain_current_login_user_create;


FragmentGroupsFragmentsCountQueryDto({

    required this.fragment_group_ids_list,

    required this.is_contain_current_login_user_create,

});
  factory FragmentGroupsFragmentsCountQueryDto.fromJson(Map<String, dynamic> json) => _$FragmentGroupsFragmentsCountQueryDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupsFragmentsCountQueryDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  String? successMessage;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  FragmentGroupsFragmentsCountQueryVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 获取成功！
    // explain: 获取多个碎片组内的碎片数量，不包含子孙组碎片
    required Future<T> Function(String showMessage, FragmentGroupsFragmentsCountQueryVo vo) code150201,
    
    }) async {
    try {

        if (code == 150201) return await code150201(successMessage!, vo!);

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
