
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class InitDownloadVo extends BaseObject{

    /// 填充字段
    bool? vo_padding;


InitDownloadVo({

    required this.vo_padding,

});
  factory InitDownloadVo.fromJson(Map<String, dynamic> json) => _$InitDownloadVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$InitDownloadVoToJson(this);
  
  
}
