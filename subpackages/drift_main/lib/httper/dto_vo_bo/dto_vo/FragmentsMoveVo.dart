
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentsMoveVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


FragmentsMoveVo({

    required this.vo_padding_1,

});
  factory FragmentsMoveVo.fromJson(Map<String, dynamic> json) => _$FragmentsMoveVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentsMoveVoToJson(this);
  
  
}
