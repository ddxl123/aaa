
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupPageFirstQueryVo extends BaseObject{

    /// 
    MemoryGroup memory_group;

    /// 
    MemoryModel? memory_model;


MemoryGroupPageFirstQueryVo({

    required this.memory_group,

    required this.memory_model,

});
  factory MemoryGroupPageFirstQueryVo.fromJson(Map<String, dynamic> json) => _$MemoryGroupPageFirstQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupPageFirstQueryVoToJson(this);
  
  
}
