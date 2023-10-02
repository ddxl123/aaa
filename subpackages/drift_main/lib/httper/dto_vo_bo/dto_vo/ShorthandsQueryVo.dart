
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class ShorthandsQueryVo extends BaseObject{

    /// 修改时间在前的速记列表
    List<Shorthand> shorthands_list;


ShorthandsQueryVo({

    required this.shorthands_list,

});
  factory ShorthandsQueryVo.fromJson(Map<String, dynamic> json) => _$ShorthandsQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$ShorthandsQueryVoToJson(this);
  
  
}
