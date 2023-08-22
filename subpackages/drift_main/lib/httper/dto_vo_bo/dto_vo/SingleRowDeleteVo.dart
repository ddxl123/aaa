
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class SingleRowDeleteVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


SingleRowDeleteVo({

    required this.vo_padding_1,

});
  factory SingleRowDeleteVo.fromJson(Map<String, dynamic> json) => _$SingleRowDeleteVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$SingleRowDeleteVoToJson(this);
  
  
}
