
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupSelectedFragmentsInsertVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


MemoryGroupSelectedFragmentsInsertVo({

    required this.vo_padding_1,

});
  factory MemoryGroupSelectedFragmentsInsertVo.fromJson(Map<String, dynamic> json) => _$MemoryGroupSelectedFragmentsInsertVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupSelectedFragmentsInsertVoToJson(this);
  
  
}
