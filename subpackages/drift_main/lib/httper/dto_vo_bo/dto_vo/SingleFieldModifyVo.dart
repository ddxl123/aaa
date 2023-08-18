
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class SingleFieldModifyVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


SingleFieldModifyVo({

    required this.vo_padding_1,

});
  factory SingleFieldModifyVo.fromJson(Map<String, dynamic> json) => _$SingleFieldModifyVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$SingleFieldModifyVoToJson(this);
  
  
}
