
// ignore_for_file: non_constant_identifier_names
part of httper;
@JsonSerializable()
class LogoutVo extends BaseObject{

    /// 填充字段
    bool? vo_padding;


LogoutVo({

    required this.vo_padding,

});
  factory LogoutVo.fromJson(Map<String, dynamic> json) => _$LogoutVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$LogoutVoToJson(this);
  
  
}
