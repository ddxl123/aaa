
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class KnowledgeBaseCategoryQueryVo extends BaseObject{

    /// 响应精选子类别。若为空，则查询响应的是大类别对应的子类别。
    List<String>? selected_sub_categorys_list;

    /// 响应大类别。若为空，则查询响应的是大类别对应的子类别。
    List<String>? big_categorys_list;

    /// 响应大类别对应的子类别。若为空，则查询响应的是首页面的类别。
    List<String>? sub_categorys_list;


KnowledgeBaseCategoryQueryVo({

    required this.selected_sub_categorys_list,

    required this.big_categorys_list,

    required this.sub_categorys_list,

});
  factory KnowledgeBaseCategoryQueryVo.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseCategoryQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$KnowledgeBaseCategoryQueryVoToJson(this);
  
  
}
