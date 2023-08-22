
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupModifyVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


FragmentGroupModifyVo({

    required this.vo_padding_1,

});
  factory FragmentGroupModifyVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupModifyVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupModifyVoToJson(this);
  
  
}
