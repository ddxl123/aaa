
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentQueryFragmentGroupWithRVo extends BaseObject{

    /// 
    List<FragmentGroupWithR> fragment_group_with_r_list;


FragmentQueryFragmentGroupWithRVo({

    required this.fragment_group_with_r_list,

});
  factory FragmentQueryFragmentGroupWithRVo.fromJson(Map<String, dynamic> json) => _$FragmentQueryFragmentGroupWithRVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentQueryFragmentGroupWithRVoToJson(this);
  
  
}
