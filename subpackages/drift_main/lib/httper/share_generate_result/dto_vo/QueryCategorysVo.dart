
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class QueryCategorysVo extends BaseObject{

    /// 可能为子类别，也可能为主类别
    String category_names;


QueryCategorysVo({

    required this.category_names,

});
  factory QueryCategorysVo.fromJson(Map<String, dynamic> json) => _$QueryCategorysVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$QueryCategorysVoToJson(this);
  
  
}
