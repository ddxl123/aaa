
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupMemoryInfoDownloadVo extends BaseObject{

    /// 
    List<FragmentAndMemoryInfo> fragment_and_memory_infos_list;


MemoryGroupMemoryInfoDownloadVo({

    required this.fragment_and_memory_infos_list,

});
  factory MemoryGroupMemoryInfoDownloadVo.fromJson(Map<String, dynamic> json) => _$MemoryGroupMemoryInfoDownloadVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupMemoryInfoDownloadVoToJson(this);
  
  
}
