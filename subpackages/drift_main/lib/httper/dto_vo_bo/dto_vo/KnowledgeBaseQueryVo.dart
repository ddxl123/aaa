
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class KnowledgeBaseQueryVo extends BaseObject{

    /// 可能为子类别集合，也可能为主类别集合
    String? category_names;

    /// 
    List<KnowledgeBaseContent>? knowledge_base_content_list;


KnowledgeBaseQueryVo({

    required this.category_names,

    required this.knowledge_base_content_list,

});
  factory KnowledgeBaseQueryVo.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$KnowledgeBaseQueryVoToJson(this);
  
  
}
