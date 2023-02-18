
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class DataDownloadForFragmentGroupVo extends BaseObject{

    /// 查询到的碎片组以及子组，包含查询的碎片组
    List<FragmentGroups> fragment_groups_list;


DataDownloadForFragmentGroupVo({

    required this.fragment_groups_list,

});
  factory DataDownloadForFragmentGroupVo.fromJson(Map<String, dynamic> json) => _$DataDownloadForFragmentGroupVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$DataDownloadForFragmentGroupVoToJson(this);
  
  
}
