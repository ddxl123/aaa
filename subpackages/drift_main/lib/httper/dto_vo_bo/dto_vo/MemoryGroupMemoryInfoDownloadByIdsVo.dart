
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupMemoryInfoDownloadByIdsVo extends BaseObject{

    /// 
    List<FragmentAndMemoryInfo> fragment_and_memory_infos_list;


MemoryGroupMemoryInfoDownloadByIdsVo({

    required this.fragment_and_memory_infos_list,

});
  factory MemoryGroupMemoryInfoDownloadByIdsVo.fromJson(Map<String, dynamic> json) => _$MemoryGroupMemoryInfoDownloadByIdsVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupMemoryInfoDownloadByIdsVoToJson(this);
  
  
}
