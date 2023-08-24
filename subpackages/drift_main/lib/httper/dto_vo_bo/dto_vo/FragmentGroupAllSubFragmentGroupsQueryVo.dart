
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupAllSubFragmentGroupsQueryVo extends BaseObject{

    /// 
    FragmentGroup? self_fragment_group;

    /// 查询到的子碎片组，不包含子孙碎片组。
    List<FragmentGroup> fragment_groups_list;


FragmentGroupAllSubFragmentGroupsQueryVo({

    required this.self_fragment_group,

    required this.fragment_groups_list,

});
  factory FragmentGroupAllSubFragmentGroupsQueryVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupAllSubFragmentGroupsQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupAllSubFragmentGroupsQueryVoToJson(this);
  
  
}
