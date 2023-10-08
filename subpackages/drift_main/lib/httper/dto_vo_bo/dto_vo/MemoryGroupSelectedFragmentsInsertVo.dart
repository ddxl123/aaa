
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupSelectedFragmentsInsertVo extends BaseObject{

    /// 
    List<int> memory_info_ids_list;


MemoryGroupSelectedFragmentsInsertVo({

    required this.memory_info_ids_list,

});
  factory MemoryGroupSelectedFragmentsInsertVo.fromJson(Map<String, dynamic> json) => _$MemoryGroupSelectedFragmentsInsertVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupSelectedFragmentsInsertVoToJson(this);
  
  
}
