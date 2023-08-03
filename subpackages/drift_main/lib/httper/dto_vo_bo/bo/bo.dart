
// ignore_for_file: non_constant_identifier_names
part of httper;

@JsonSerializable()
class DeviceAndTokenBo {
    String device_info;
    String token;

DeviceAndTokenBo({
    required this.device_info,
    required this.token,

});

  factory DeviceAndTokenBo.fromJson(Map<String, dynamic> json) => _$DeviceAndTokenBoFromJson(json);
  
  Map<String, dynamic> toJson() => _$DeviceAndTokenBoToJson(this);
}

@JsonSerializable()
class KnowledgeBaseFragmentGroupWrapperBo {
    FragmentGroup fragment_group;
    List<FragmentGroupTag> fragment_group_tags;

KnowledgeBaseFragmentGroupWrapperBo({
    required this.fragment_group,
    required this.fragment_group_tags,

});

  factory KnowledgeBaseFragmentGroupWrapperBo.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseFragmentGroupWrapperBoFromJson(json);
  
  Map<String, dynamic> toJson() => _$KnowledgeBaseFragmentGroupWrapperBoToJson(this);
}

@JsonSerializable()
class ModifyKnowledgeBaseBigCategory {
    String big_category;
    List<String> sub_categories;

ModifyKnowledgeBaseBigCategory({
    required this.big_category,
    required this.sub_categories,

});

  factory ModifyKnowledgeBaseBigCategory.fromJson(Map<String, dynamic> json) => _$ModifyKnowledgeBaseBigCategoryFromJson(json);
  
  Map<String, dynamic> toJson() => _$ModifyKnowledgeBaseBigCategoryToJson(this);
}

@JsonSerializable()
class ModifyKnowledgeBaseCategory {
    List<ModifyKnowledgeBaseBigCategory> modify_knowledge_base_big_categories;
    List<String> selected_sub_categorys;

ModifyKnowledgeBaseCategory({
    required this.modify_knowledge_base_big_categories,
    required this.selected_sub_categorys,

});

  factory ModifyKnowledgeBaseCategory.fromJson(Map<String, dynamic> json) => _$ModifyKnowledgeBaseCategoryFromJson(json);
  
  Map<String, dynamic> toJson() => _$ModifyKnowledgeBaseCategoryToJson(this);
}

