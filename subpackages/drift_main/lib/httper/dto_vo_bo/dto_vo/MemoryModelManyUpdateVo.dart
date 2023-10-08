
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryModelManyUpdateVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


MemoryModelManyUpdateVo({

    required this.vo_padding_1,

});
  factory MemoryModelManyUpdateVo.fromJson(Map<String, dynamic> json) => _$MemoryModelManyUpdateVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryModelManyUpdateVoToJson(this);
  
  
}
