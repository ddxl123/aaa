
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupSyncFAndMiDto extends BaseObject{

    /// 
    int memory_group_id;

    /// 
    SyncFAndMi sync_f_and_mi;


MemoryGroupSyncFAndMiDto({

    required this.memory_group_id,

    required this.sync_f_and_mi,

});
  factory MemoryGroupSyncFAndMiDto.fromJson(Map<String, dynamic> json) => _$MemoryGroupSyncFAndMiDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupSyncFAndMiDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  MemoryGroupSyncFAndMiVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 同步成功！
    // explain: 对记忆组中的碎片进行同步。
    required Future<T> Function(String showMessage, MemoryGroupSyncFAndMiVo vo) code160801,
    
    }) async {
    try {

        if (code == 160801) return await code160801(httperException!.showMessage, vo!);

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
