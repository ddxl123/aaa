
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupTagNewFragmentGroupTagVo extends BaseObject{

    /// 返回带 id 的 FragmentGroupTag 对象
    FragmentGroupTag fragment_group_tag_entity;


FragmentGroupTagNewFragmentGroupTagVo({

    required this.fragment_group_tag_entity,

});
  factory FragmentGroupTagNewFragmentGroupTagVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupTagNewFragmentGroupTagVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupTagNewFragmentGroupTagVoToJson(this);
  
  
}
