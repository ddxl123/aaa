
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class DataDownloadForKnowledgeBaseDto extends BaseObject{

    /// 需要下载的碎片组id。若为空，则说明下载的不是碎片组。
    String? fragment_group_id;

    /// 填充字段1
    bool? dto_padding_1;


DataDownloadForKnowledgeBaseDto({

    required this.fragment_group_id,

    required this.dto_padding_1,

});
  factory DataDownloadForKnowledgeBaseDto.fromJson(Map<String, dynamic> json) => _$DataDownloadForKnowledgeBaseDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$DataDownloadForKnowledgeBaseDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  HttperException? httperException;
  
  @JsonKey(ignore: true)
  StackTrace? st;

  @JsonKey(ignore: true)
  DataDownloadForKnowledgeBaseVo? vo;

  /// 内部抛出的异常将在 [otherException] 中捕获。
  Future<T> handleCode<T>({
    // code 为 null 时的异常（request 函数内部捕获到的异常）
    required Future<T> Function(int? code, HttperException httperException, StackTrace st) otherException,

    // message: 下载成功！
    // explain: 下载数据库中单个碎片组以及对应的全部子孙组。
    required Future<T> Function(String showMessage, DataDownloadForKnowledgeBaseVo vo) code40201,
    
    }) async {
    try {

        if (code == 40201) return await code40201(httperException!.showMessage, vo!);

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
