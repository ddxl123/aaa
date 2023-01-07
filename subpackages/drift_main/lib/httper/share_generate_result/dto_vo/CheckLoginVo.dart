
// ignore_for_file: non_constant_identifier_names
part of httper;
@JsonSerializable()
class CheckLoginVo extends BaseObject{

    /// 
    bool ok;


CheckLoginVo({

    required this.ok,

});
  factory CheckLoginVo.fromJson(Map<String, dynamic> json) => _$CheckLoginVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$CheckLoginVoToJson(this);
  
  
}
