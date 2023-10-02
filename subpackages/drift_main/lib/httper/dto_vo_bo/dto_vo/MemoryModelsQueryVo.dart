
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryModelsQueryVo extends BaseObject{

    /// 
    List<MemoryModel> memory_models_list;


MemoryModelsQueryVo({

    required this.memory_models_list,

});
  factory MemoryModelsQueryVo.fromJson(Map<String, dynamic> json) => _$MemoryModelsQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryModelsQueryVoToJson(this);
  
  
}
