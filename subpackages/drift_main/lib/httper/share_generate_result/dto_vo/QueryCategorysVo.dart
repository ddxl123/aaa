
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class QueryCategorysVo extends BaseObject{

    /// 可能为子类别集合，也可能为主类别集合
    String? category_names;

    /// 
    List<CategoryContent>? category_content_list;


QueryCategorysVo({

    required this.category_names,

    required this.category_content_list,

});
  factory QueryCategorysVo.fromJson(Map<String, dynamic> json) => _$QueryCategorysVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$QueryCategorysVoToJson(this);
  
  
}
