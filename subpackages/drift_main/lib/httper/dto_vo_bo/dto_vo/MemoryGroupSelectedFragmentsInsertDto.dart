
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupSelectedFragmentsInsertDto extends BaseObject{

    /// 要插入的碎片记忆信息(前端需把要插入的碎片转换成碎片记忆信息，给后端批量插入)
    List<FragmentMemoryInfo> fragment_memory_infos_list;

    /// 要插入到哪个记忆组中
    int memory_group_id;


MemoryGroupSelectedFragmentsInsertDto({

    required this.fragment_memory_infos_list,

    required this.memory_group_id,

});
  factory MemoryGroupSelectedFragmentsInsertDto.fromJson(Map<String, dynamic> json) => _$MemoryGroupSelectedFragmentsInsertDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupSelectedFragmentsInsertDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  MemoryGroupSelectedFragmentsInsertVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    Future<T> Function(int? code, HttperException httperException, StackTrace st)? otherException,

    // message: 获取成功！
    // explain: 将已选的碎片插入到记忆组中。
    required Future<T> Function(String showMessage) code160301,
    
    }) async {
    try {

        if (code == 160301) return await code160301(httperException!.showMessage);

    } catch (e, st) {
      if (otherException == null) rethrow;
      if (e is HttperException) {
        return await otherException(code, e, st);
      }
      return await otherException(code, HttperException(showMessage: '请求异常！', debugMessage: e.toString()), st);
    }
    if (code != null) {
      if(otherException==null) throw HttperException(showMessage: '请求异常！', debugMessage: '响应码 $code 未处理！');
      return await otherException(code, HttperException(showMessage: '请求异常！', debugMessage: '响应码 $code 未处理！'), st!);
    }
    if(otherException==null) throw httperException!;
    return await otherException(code, httperException!, st!);
  }
}
