
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupMemoryInfoDownloadByInfoIdsVo extends BaseObject{

    /// 
    List<FragmentAndMemoryInfo> fragment_and_memory_infos_list;


MemoryGroupMemoryInfoDownloadByInfoIdsVo({

    required this.fragment_and_memory_infos_list,

});
  factory MemoryGroupMemoryInfoDownloadByInfoIdsVo.fromJson(Map<String, dynamic> json) => _$MemoryGroupMemoryInfoDownloadByInfoIdsVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupMemoryInfoDownloadByInfoIdsVoToJson(this);
  
  
}
