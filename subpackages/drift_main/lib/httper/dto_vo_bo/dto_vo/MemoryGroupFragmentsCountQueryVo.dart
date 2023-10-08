
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupFragmentsCountQueryVo extends BaseObject{

    /// 
    MemoryGroup memory_group;

    /// 
    MemoryModel? memory_model;

    /// 
    int count;


MemoryGroupFragmentsCountQueryVo({

    required this.memory_group,

    required this.memory_model,

    required this.count,

});
  factory MemoryGroupFragmentsCountQueryVo.fromJson(Map<String, dynamic> json) => _$MemoryGroupFragmentsCountQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupFragmentsCountQueryVoToJson(this);
  
  
}
