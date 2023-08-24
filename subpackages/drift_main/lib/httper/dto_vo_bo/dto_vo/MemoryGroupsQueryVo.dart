
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupsQueryVo extends BaseObject{

    /// 
    List<MemoryGroup> memory_groups_list;


MemoryGroupsQueryVo({

    required this.memory_groups_list,

});
  factory MemoryGroupsQueryVo.fromJson(Map<String, dynamic> json) => _$MemoryGroupsQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupsQueryVoToJson(this);
  
  
}
