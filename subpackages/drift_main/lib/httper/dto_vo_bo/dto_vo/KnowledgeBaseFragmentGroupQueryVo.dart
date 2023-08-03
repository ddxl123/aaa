
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class KnowledgeBaseFragmentGroupQueryVo extends BaseObject{

    /// 
    List<KnowledgeBaseFragmentGroupWrapperBo> fragment_group_wrapper_list;


KnowledgeBaseFragmentGroupQueryVo({

    required this.fragment_group_wrapper_list,

});
  factory KnowledgeBaseFragmentGroupQueryVo.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseFragmentGroupQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$KnowledgeBaseFragmentGroupQueryVoToJson(this);
  
  
}
