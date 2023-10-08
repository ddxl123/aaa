
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryInfoDownloadOnlyIdVo extends BaseObject{

    /// 
    List<int> memory_info_id_list;


MemoryInfoDownloadOnlyIdVo({

    required this.memory_info_id_list,

});
  factory MemoryInfoDownloadOnlyIdVo.fromJson(Map<String, dynamic> json) => _$MemoryInfoDownloadOnlyIdVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryInfoDownloadOnlyIdVoToJson(this);
  
  
}
