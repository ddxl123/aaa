
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupOneSubQueryVo extends BaseObject{

    /// 
    FragmentGroup? self_fragment_group;

    /// 获取要查询的碎片组自身的标签。不包含子孙组的标签
    List<FragmentGroupTag> self_fragment_group_tags_list;

    /// 查询到的子碎片组，不包含子孙碎片组。
    List<FragmentGroup> fragment_groups_list;

    /// 获取了碎片组内的碎片。不包括子孙。
    List<FragmentWithRsWrapper> fragments_list;


FragmentGroupOneSubQueryVo({

    required this.self_fragment_group,

    required this.self_fragment_group_tags_list,

    required this.fragment_groups_list,

    required this.fragments_list,

});
  factory FragmentGroupOneSubQueryVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupOneSubQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupOneSubQueryVoToJson(this);
  
  
}
