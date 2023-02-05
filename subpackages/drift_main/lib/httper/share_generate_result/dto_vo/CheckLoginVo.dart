
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class CheckLoginVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;

    /// 填充字段2
    bool? vo_padding_2;


CheckLoginVo({

    required this.vo_padding_1,

    required this.vo_padding_2,

});
  factory CheckLoginVo.fromJson(Map<String, dynamic> json) => _$CheckLoginVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$CheckLoginVoToJson(this);
  
  
}
