
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class DataUploadVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


DataUploadVo({

    required this.vo_padding_1,

});
  factory DataUploadVo.fromJson(Map<String, dynamic> json) => _$DataUploadVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$DataUploadVoToJson(this);
  
  
}
