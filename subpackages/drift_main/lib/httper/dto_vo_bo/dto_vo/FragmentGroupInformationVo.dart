
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupInformationVo extends BaseObject{

    /// 
    KnowledgeBaseFragmentGroupWrapperBo? knowledge_base_fragment_group_wrapper_bo;


FragmentGroupInformationVo({

    required this.knowledge_base_fragment_group_wrapper_bo,

});
  factory FragmentGroupInformationVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupInformationVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupInformationVoToJson(this);
  
  
}
