
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupsMoveVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


FragmentGroupsMoveVo({

    required this.vo_padding_1,

});
  factory FragmentGroupsMoveVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupsMoveVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupsMoveVoToJson(this);
  
  
}
