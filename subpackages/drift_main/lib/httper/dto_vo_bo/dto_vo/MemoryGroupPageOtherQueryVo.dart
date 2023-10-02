
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupPageOtherQueryVo extends BaseObject{

    /// 
    int fragment_count;


MemoryGroupPageOtherQueryVo({

    required this.fragment_count,

});
  factory MemoryGroupPageOtherQueryVo.fromJson(Map<String, dynamic> json) => _$MemoryGroupPageOtherQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupPageOtherQueryVoToJson(this);
  
  
}
