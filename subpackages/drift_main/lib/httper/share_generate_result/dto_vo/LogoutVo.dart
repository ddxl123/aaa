
// ignore_for_file: non_constant_identifier_names
part of httper;
@JsonSerializable()
class LogoutVo extends BaseObject{

    /// 
    bool ok;


LogoutVo({

    required this.ok,

});
  factory LogoutVo.fromJson(Map<String, dynamic> json) => _$LogoutVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$LogoutVoToJson(this);
  
  
}
