
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupOneSubQueryVo extends BaseObject{

    /// 查询到的自身的 dynamicFragmentGroup，因为要查询的目标碎片组是 dynamicFragmentGroup 类型
    FragmentGroup? self_fragment_group;

    /// 查询到的子碎片组，不包含子孙碎片组。
    List<FragmentGroupWithJumpWrapper> fragment_group_with_jump_wrappers_list;

    /// 获取了碎片组内的碎片。不包括子孙。
    List<FragmentWithRsWrapper> fragments_list;


FragmentGroupOneSubQueryVo({

    required this.self_fragment_group,

    required this.fragment_group_with_jump_wrappers_list,

    required this.fragments_list,

});
  factory FragmentGroupOneSubQueryVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupOneSubQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupOneSubQueryVoToJson(this);
  
  
}
