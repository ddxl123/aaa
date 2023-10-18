
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupFragmentsCountQueryDto extends BaseObject{

    /// 要查询的单个记忆组 id。
    int memory_group_id;

    /// 要查询的多个记忆组 id。
    List<int>? memory_group_ids_list;


MemoryGroupFragmentsCountQueryDto({

    required this.memory_group_id,

    required this.memory_group_ids_list,

});
  factory MemoryGroupFragmentsCountQueryDto.fromJson(Map<String, dynamic> json) => _$MemoryGroupFragmentsCountQueryDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupFragmentsCountQueryDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  MemoryGroupFragmentsCountQueryVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 获取成功！
    // explain: 获取某个记忆组中的全部碎片的数量。
    required Future<T> Function(String showMessage, MemoryGroupFragmentsCountQueryVo vo) code160201,
    
    }) async {
    try {

        if (code == 160201) return await code160201(httperException!.showMessage, vo!);

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
    if(otherException==null) throw httperException!;
    return await otherException(code, httperException!, st!);
  }
}
