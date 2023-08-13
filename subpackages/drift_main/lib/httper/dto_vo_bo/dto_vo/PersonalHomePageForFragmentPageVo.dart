
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class PersonalHomePageForFragmentPageVo extends BaseObject{

    /// 用户第一页碎片组
    List<FragmentGroup> fragment_groups_list;

    /// 用户第一页碎片
    List<Fragment> fragments_list;


PersonalHomePageForFragmentPageVo({

    required this.fragment_groups_list,

    required this.fragments_list,

});
  factory PersonalHomePageForFragmentPageVo.fromJson(Map<String, dynamic> json) => _$PersonalHomePageForFragmentPageVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$PersonalHomePageForFragmentPageVoToJson(this);
  
  
}
