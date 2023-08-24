
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class MemoryGroupFragmentIdsQueryVo extends BaseObject{

    /// 
    List<int> fragment_ids_list;


MemoryGroupFragmentIdsQueryVo({

    required this.fragment_ids_list,

});
  factory MemoryGroupFragmentIdsQueryVo.fromJson(Map<String, dynamic> json) => _$MemoryGroupFragmentIdsQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$MemoryGroupFragmentIdsQueryVoToJson(this);
  
  
}
