
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class QueryFragmentGroupTagByFragmentGroupIdVo extends BaseObject{

    /// 
    List<FragmentGroupTag> fragment_group_tag_list;


QueryFragmentGroupTagByFragmentGroupIdVo({

    required this.fragment_group_tag_list,

});
  factory QueryFragmentGroupTagByFragmentGroupIdVo.fromJson(Map<String, dynamic> json) => _$QueryFragmentGroupTagByFragmentGroupIdVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$QueryFragmentGroupTagByFragmentGroupIdVoToJson(this);
  
  
}
