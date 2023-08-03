
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class KnowledgeBaseCategoryModifyVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


KnowledgeBaseCategoryModifyVo({

    required this.vo_padding_1,

});
  factory KnowledgeBaseCategoryModifyVo.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseCategoryModifyVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$KnowledgeBaseCategoryModifyVoToJson(this);
  
  
}
