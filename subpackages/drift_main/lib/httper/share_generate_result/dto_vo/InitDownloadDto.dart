
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class InitDownloadDto extends BaseObject{

    /// 
    Sync sync_entity;

    /// 
    Map<String, dynamic> row_map;

    /// 填充字段
    bool? dto_padding;


InitDownloadDto({

    required this.sync_entity,

    required this.row_map,

    required this.dto_padding,

});
  factory InitDownloadDto.fromJson(Map<String, dynamic> json) => _$InitDownloadDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$InitDownloadDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  InitDownloadVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, HttperException httperException, StackTrace st) otherException,

    // message: 已登录！
    // explain: 用户已登录
    required Future<T> Function(String showMessage) code20101,
    
    }) async {
    try {

        if (code == 20101) return await code20101(httperException!.showMessage);

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
