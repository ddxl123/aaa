
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupMemoryInfoDownloadByIdsDto extends BaseObject{

    /// 
    List<int> memory_info_ids_list;

    /// 填充字段1
    bool? dto_padding_1;


MemoryGroupMemoryInfoDownloadByIdsDto({

    required this.memory_info_ids_list,

    required this.dto_padding_1,

});
  factory MemoryGroupMemoryInfoDownloadByIdsDto.fromJson(Map<String, dynamic> json) => _$MemoryGroupMemoryInfoDownloadByIdsDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupMemoryInfoDownloadByIdsDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  MemoryGroupMemoryInfoDownloadByIdsVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 下载成功！
    // explain: 下载某个记忆组内全部碎片和记忆信息。
    required Future<T> Function(String showMessage, MemoryGroupMemoryInfoDownloadByIdsVo vo) code161701,
    
    }) async {
    try {

        if (code == 161701) return await code161701(httperException!.showMessage, vo!);

    } catch (handleE, handleSt) {
      if (otherException == null) {
        if (httperException != null) {
          throw httperException!;
        }
        rethrow;
      }
      if (httperException != null) {
        return await otherException(code, httperException!, st!);
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
    if(otherException==null) throw httperException!;
    return await otherException(code, httperException!, st!);
  }
}
