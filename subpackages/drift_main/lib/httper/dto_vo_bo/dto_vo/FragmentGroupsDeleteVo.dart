
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupsDeleteVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


FragmentGroupsDeleteVo({

    required this.vo_padding_1,

});
  factory FragmentGroupsDeleteVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupsDeleteVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupsDeleteVoToJson(this);
  
  
}
