
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class DataDownloadForFragmentGroupVo extends BaseObject{

    /// 查询到的碎片组以及子组，包含查询的碎片组
    List<FragmentGroup> fragment_group_list;

    /// 
    List<RFragment2FragmentGroup> r_fragment2_fragment_group_list;

    /// 
    List<Fragment> fragment_list;


DataDownloadForFragmentGroupVo({

    required this.fragment_group_list,

    required this.r_fragment2_fragment_group_list,

    required this.fragment_list,

});
  factory DataDownloadForFragmentGroupVo.fromJson(Map<String, dynamic> json) => _$DataDownloadForFragmentGroupVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$DataDownloadForFragmentGroupVoToJson(this);
  
  
}
