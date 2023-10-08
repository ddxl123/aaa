
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryInfoUploadSyncVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


MemoryInfoUploadSyncVo({

    required this.vo_padding_1,

});
  factory MemoryInfoUploadSyncVo.fromJson(Map<String, dynamic> json) => _$MemoryInfoUploadSyncVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryInfoUploadSyncVoToJson(this);
  
  
}
