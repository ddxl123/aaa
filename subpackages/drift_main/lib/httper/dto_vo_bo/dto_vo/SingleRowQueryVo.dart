
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class SingleRowQueryVo extends BaseObject{

    /// 查询到的行
    dynamic? row;


SingleRowQueryVo({

    required this.row,

});
  factory SingleRowQueryVo.fromJson(Map<String, dynamic> json) => _$SingleRowQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$SingleRowQueryVoToJson(this);
  
  
}
