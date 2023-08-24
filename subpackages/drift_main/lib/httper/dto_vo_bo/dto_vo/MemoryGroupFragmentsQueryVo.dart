
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupFragmentsQueryVo extends BaseObject{

    /// 
    List<Fragment> fragments_list;


MemoryGroupFragmentsQueryVo({

    required this.fragments_list,

});
  factory MemoryGroupFragmentsQueryVo.fromJson(Map<String, dynamic> json) => _$MemoryGroupFragmentsQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupFragmentsQueryVoToJson(this);
  
  
}
