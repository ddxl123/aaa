
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class KnowledgeBaseFragmentGroupInnerQueryVo extends BaseObject{

    /// 获取包括了要查询的碎片组自身。不包含子孙组。
    List<FragmentGroup> fragment_groups_list;

    /// 获取要查询的碎片组自身的标签。不包含子孙组的标签
    List<FragmentGroupTag> fragment_group_self_tags_list;

    /// 获取了碎片组内的碎片。不包括子孙。
    List<KnowledgeBaseFragmentGroupInnerForFragmentBo> fragments_list;


KnowledgeBaseFragmentGroupInnerQueryVo({

    required this.fragment_groups_list,

    required this.fragment_group_self_tags_list,

    required this.fragments_list,

});
  factory KnowledgeBaseFragmentGroupInnerQueryVo.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseFragmentGroupInnerQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$KnowledgeBaseFragmentGroupInnerQueryVoToJson(this);
  
  
}
