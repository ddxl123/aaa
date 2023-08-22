
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupCountQueryVo extends BaseObject{

    /// 
    int count;


FragmentGroupCountQueryVo({

    required this.count,

});
  factory FragmentGroupCountQueryVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupCountQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupCountQueryVoToJson(this);
  
  
}
