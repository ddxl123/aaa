
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupAllSubFragmentsCountQueryVo extends BaseObject{

    /// 
    int no_repeat_count;

    /// 
    int repeat_count;


FragmentGroupAllSubFragmentsCountQueryVo({

    required this.no_repeat_count,

    required this.repeat_count,

});
  factory FragmentGroupAllSubFragmentsCountQueryVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupAllSubFragmentsCountQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupAllSubFragmentsCountQueryVoToJson(this);
  
  
}
