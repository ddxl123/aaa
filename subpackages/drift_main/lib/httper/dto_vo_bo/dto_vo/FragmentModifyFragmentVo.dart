
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentModifyFragmentVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


FragmentModifyFragmentVo({

    required this.vo_padding_1,

});
  factory FragmentModifyFragmentVo.fromJson(Map<String, dynamic> json) => _$FragmentModifyFragmentVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentModifyFragmentVoToJson(this);
  
  
}
