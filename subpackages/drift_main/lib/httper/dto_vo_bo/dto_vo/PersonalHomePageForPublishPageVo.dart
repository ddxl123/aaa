
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class PersonalHomePageForPublishPageVo extends BaseObject{

    /// 用户已发布的碎片组
    List<FragmentGroup> fragment_groups_list;


PersonalHomePageForPublishPageVo({

    required this.fragment_groups_list,

});
  factory PersonalHomePageForPublishPageVo.fromJson(Map<String, dynamic> json) => _$PersonalHomePageForPublishPageVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$PersonalHomePageForPublishPageVoToJson(this);
  
  
}
