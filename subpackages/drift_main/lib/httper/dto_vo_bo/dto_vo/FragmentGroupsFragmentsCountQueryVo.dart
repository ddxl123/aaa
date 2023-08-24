
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupsFragmentsCountQueryVo extends BaseObject{

    /// 
    int no_repeat_count;


FragmentGroupsFragmentsCountQueryVo({

    required this.no_repeat_count,

});
  factory FragmentGroupsFragmentsCountQueryVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupsFragmentsCountQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupsFragmentsCountQueryVoToJson(this);
  
  
}
