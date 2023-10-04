
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupManyUpdateVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


MemoryGroupManyUpdateVo({

    required this.vo_padding_1,

});
  factory MemoryGroupManyUpdateVo.fromJson(Map<String, dynamic> json) => _$MemoryGroupManyUpdateVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupManyUpdateVoToJson(this);
  
  
}
