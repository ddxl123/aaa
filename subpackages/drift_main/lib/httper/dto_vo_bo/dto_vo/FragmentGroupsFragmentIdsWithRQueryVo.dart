
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupsFragmentIdsWithRQueryVo extends BaseObject{

    /// 只获取到碎片的id，以及对应的 r
    List<FragmentIdWithRsWrapper> fragment_id_with_rs_list;


FragmentGroupsFragmentIdsWithRQueryVo({

    required this.fragment_id_with_rs_list,

});
  factory FragmentGroupsFragmentIdsWithRQueryVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupsFragmentIdsWithRQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupsFragmentIdsWithRQueryVoToJson(this);
  
  
}
