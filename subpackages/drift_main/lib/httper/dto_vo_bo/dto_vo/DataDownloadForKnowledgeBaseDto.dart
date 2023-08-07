
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class DataDownloadForKnowledgeBaseDto extends BaseObject{

    /// dto1-需要下载的碎片组id。若为空，则说明下载的不是碎片组。
    String? fragment_group_id;

    /// dto2-全部碎片组id集合。若为空，则说明下载的不是碎片。
    List<String>? fragment_group_ids_for_fragments_list;

    /// dto3-全部碎片组id集合。若为空，则说明下载的不是碎片组标签。
    List<String>? fragment_group_ids_for_tags_list;


DataDownloadForKnowledgeBaseDto({

    required this.fragment_group_id,

    required this.fragment_group_ids_for_fragments_list,

    required this.fragment_group_ids_for_tags_list,

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
    // explain: code1-下载数据库中单个碎片组以及对应的全部子孙组。
    required Future<T> Function(String showMessage, DataDownloadForKnowledgeBaseVo vo) code40201,
    
    // message: 下载成功！
    // explain: code1-根据碎片组id数组，获取对应的全部碎片。
    required Future<T> Function(String showMessage, DataDownloadForKnowledgeBaseVo vo) code40202,
    
    // message: 下载成功！
    // explain: code3-根据碎片组id数组，获取对应的全部碎片组标签。
    required Future<T> Function(String showMessage, DataDownloadForKnowledgeBaseVo vo) code40203,
    
    }) async {
    try {

        if (code == 40201) return await code40201(httperException!.showMessage, vo!);

        if (code == 40202) return await code40202(httperException!.showMessage, vo!);

        if (code == 40203) return await code40203(httperException!.showMessage, vo!);

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
