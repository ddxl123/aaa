
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class SingleRowModifyVo extends BaseObject{

    /// 响应修改的行。
    dynamic row;


SingleRowModifyVo({

    required this.row,

});
  factory SingleRowModifyVo.fromJson(Map<String, dynamic> json) => _$SingleRowModifyVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$SingleRowModifyVoToJson(this);
  
  
}
