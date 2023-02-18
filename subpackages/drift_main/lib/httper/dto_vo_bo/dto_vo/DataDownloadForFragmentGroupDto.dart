
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class DataDownloadForFragmentGroupDto extends BaseObject{

    /// 需要查询的碎片组id
    String fragment_group_id;

    /// 填充字段1
    bool? dto_padding_1;


DataDownloadForFragmentGroupDto({

    required this.fragment_group_id,

    required this.dto_padding_1,

});
  factory DataDownloadForFragmentGroupDto.fromJson(Map<String, dynamic> json) => _$DataDownloadForFragmentGroupDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$DataDownloadForFragmentGroupDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  DataDownloadForFragmentGroupVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, HttperException httperException, StackTrace st) otherException,

    // message: 已获取，正在下载...
    // explain: 
    required Future<T> Function(String showMessage, DataDownloadForFragmentGroupVo vo) code40101,
    
    }) async {
    try {

        if (code == 40101) return await code40101(httperException!.showMessage, vo!);

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
