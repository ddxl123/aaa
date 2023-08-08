
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
class DataDownloadForKnowledgeBaseFragmentWrapperBO {
    Fragment fragments;
    List<RFragment2FragmentGroup> r_fragment_2_fragment_groups;

DataDownloadForKnowledgeBaseFragmentWrapperBO({
    required this.fragments,
    required this.r_fragment_2_fragment_groups,

});

  factory DataDownloadForKnowledgeBaseFragmentWrapperBO.fromJson(Map<String, dynamic> json) => _$DataDownloadForKnowledgeBaseFragmentWrapperBOFromJson(json);
  
  Map<String, dynamic> toJson() => _$DataDownloadForKnowledgeBaseFragmentWrapperBOToJson(this);
}

@JsonSerializable()
class KnowledgeBaseFragmentGroupInnerForFragmentBo {
    Fragment fragment;
    List<RFragment2FragmentGroup> r_fragment_2_fragment_groups;

KnowledgeBaseFragmentGroupInnerForFragmentBo({
    required this.fragment,
    required this.r_fragment_2_fragment_groups,

});

  factory KnowledgeBaseFragmentGroupInnerForFragmentBo.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseFragmentGroupInnerForFragmentBoFromJson(json);
  
  Map<String, dynamic> toJson() => _$KnowledgeBaseFragmentGroupInnerForFragmentBoToJson(this);
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

