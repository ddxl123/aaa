
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class QueryFragmentGroupTagByLikeVo extends BaseObject{

    /// 
    List<FragmentGroupTag> fragment_group_tag_list;


QueryFragmentGroupTagByLikeVo({

    required this.fragment_group_tag_list,

});
  factory QueryFragmentGroupTagByLikeVo.fromJson(Map<String, dynamic> json) => _$QueryFragmentGroupTagByLikeVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$QueryFragmentGroupTagByLikeVoToJson(this);
  
  
}
