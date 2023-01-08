
// ignore_for_file: non_constant_identifier_names
part of httper;
@JsonSerializable()
class CheckLoginVo extends BaseObject{

    /// 填充字段
    bool? vo_padding;


CheckLoginVo({

    required this.vo_padding,

});
  factory CheckLoginVo.fromJson(Map<String, dynamic> json) => _$CheckLoginVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$CheckLoginVoToJson(this);
  
  
}
