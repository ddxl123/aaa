
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupsReuseVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


FragmentGroupsReuseVo({

    required this.vo_padding_1,

});
  factory FragmentGroupsReuseVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupsReuseVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupsReuseVoToJson(this);
  
  
}
