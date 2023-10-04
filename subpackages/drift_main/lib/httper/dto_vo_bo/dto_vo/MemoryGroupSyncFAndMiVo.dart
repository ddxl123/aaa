
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupSyncFAndMiVo extends BaseObject{

    /// 
    List<FragmentAndMemoryInfo> fragment_and_memory_infos_list;


MemoryGroupSyncFAndMiVo({

    required this.fragment_and_memory_infos_list,

});
  factory MemoryGroupSyncFAndMiVo.fromJson(Map<String, dynamic> json) => _$MemoryGroupSyncFAndMiVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupSyncFAndMiVoToJson(this);
  
  
}
