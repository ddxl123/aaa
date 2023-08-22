
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class SingleRowInsertVo extends BaseObject{

    /// 响应的行插入后带有 id 的行。
    dynamic row;


SingleRowInsertVo({

    required this.row,

});
  factory SingleRowInsertVo.fromJson(Map<String, dynamic> json) => _$SingleRowInsertVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$SingleRowInsertVoToJson(this);
  
  
}
