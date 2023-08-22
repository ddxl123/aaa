
// ignore_for_file: non_constant_identifier_names
part of httper;

@JsonSerializable()
class FragmentGroupQueryWrapper  {
    /// 要查询的目标用户，刚开始进入了哪个碎片组，就是哪个碎片组的 userId（每次递归始终是这一个）
    int? first_target_user_id;
    /// 获取结果是否包含当前登录用户创建的。如果为 false，则只会获取父碎片组创建者创建的子碎片组；如果为 true，则也同时获取已登录用户自己创建的。
    bool is_contain_current_login_user_create;
    /// 是否只获取正在发布的。
    bool only_published;
    /// 要查询的目标碎片组（每次递归都是不一样的）
    int? target_fragment_group_id;

FragmentGroupQueryWrapper({
    required this.first_target_user_id,
    required this.is_contain_current_login_user_create,
    required this.only_published,
    required this.target_fragment_group_id,

  });

  factory FragmentGroupQueryWrapper.fromJson(Map<String, dynamic> json) => _$FragmentGroupQueryWrapperFromJson(json);
  
  Map<String, dynamic> toJson() => _$FragmentGroupQueryWrapperToJson(this);
}

@JsonSerializable()
class FragmentQueryWrapper  {
    /// 要查询的目标用户，刚开始进入了哪个碎片组，就是哪个碎片组的 userId（每次递归始终是这一个）
    int? first_target_user_id;
    /// 获取结果是否包含当前登录用户创建的。如果为 false，则只会获取父碎片组创建者创建的子碎片组；如果为 true，则也同时获取已登录用户自己创建的。
    bool is_contain_current_login_user_create;
    /// 要查询的目标碎片组（每次递归都是不一样的）
    int? target_fragment_group_id;

FragmentQueryWrapper({
    required this.first_target_user_id,
    required this.is_contain_current_login_user_create,
    required this.target_fragment_group_id,

  });

  factory FragmentQueryWrapper.fromJson(Map<String, dynamic> json) => _$FragmentQueryWrapperFromJson(json);
  
  Map<String, dynamic> toJson() => _$FragmentQueryWrapperToJson(this);
}

@JsonSerializable()
class FragmentWithRsWrapper  {
    /// 
    Fragment fragment;
    /// 
    List<RFragment2FragmentGroup> r_fragment_2_fragment_groups;

FragmentWithRsWrapper({
    required this.fragment,
    required this.r_fragment_2_fragment_groups,

  });

  factory FragmentWithRsWrapper.fromJson(Map<String, dynamic> json) => _$FragmentWithRsWrapperFromJson(json);
  
  Map<String, dynamic> toJson() => _$FragmentWithRsWrapperToJson(this);
}

@JsonSerializable()
class DeviceAndTokenBo  {
    /// 
    String device_info;
    /// 
    String token;

DeviceAndTokenBo({
    required this.device_info,
    required this.token,

  });

  factory DeviceAndTokenBo.fromJson(Map<String, dynamic> json) => _$DeviceAndTokenBoFromJson(json);
  
  Map<String, dynamic> toJson() => _$DeviceAndTokenBoToJson(this);
}

@JsonSerializable()
class FragmentGroupWithR  {
    /// 
    FragmentGroup? fragment_group;
    /// 
    RFragment2FragmentGroup r_fragment_2_fragment_groups;

FragmentGroupWithR({
    required this.fragment_group,
    required this.r_fragment_2_fragment_groups,

  });

  factory FragmentGroupWithR.fromJson(Map<String, dynamic> json) => _$FragmentGroupWithRFromJson(json);
  
  Map<String, dynamic> toJson() => _$FragmentGroupWithRToJson(this);
}

@JsonSerializable()
class KnowledgeBaseFragmentGroupWrapperBo  {
    /// 
    FragmentGroup fragment_group;
    /// 
    List<FragmentGroupTag> fragment_group_tags;

KnowledgeBaseFragmentGroupWrapperBo({
    required this.fragment_group,
    required this.fragment_group_tags,

  });

  factory KnowledgeBaseFragmentGroupWrapperBo.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseFragmentGroupWrapperBoFromJson(json);
  
  Map<String, dynamic> toJson() => _$KnowledgeBaseFragmentGroupWrapperBoToJson(this);
}

@JsonSerializable()
class ModifyKnowledgeBaseBigCategory  {
    /// 
    String big_category;
    /// 
    List<String> sub_categories;

ModifyKnowledgeBaseBigCategory({
    required this.big_category,
    required this.sub_categories,

  });

  factory ModifyKnowledgeBaseBigCategory.fromJson(Map<String, dynamic> json) => _$ModifyKnowledgeBaseBigCategoryFromJson(json);
  
  Map<String, dynamic> toJson() => _$ModifyKnowledgeBaseBigCategoryToJson(this);
}

@JsonSerializable()
class ModifyKnowledgeBaseCategory  {
    /// 
    List<ModifyKnowledgeBaseBigCategory> modify_knowledge_base_big_categories;
    /// 
    List<String> selected_sub_categorys;

ModifyKnowledgeBaseCategory({
    required this.modify_knowledge_base_big_categories,
    required this.selected_sub_categorys,

  });

  factory ModifyKnowledgeBaseCategory.fromJson(Map<String, dynamic> json) => _$ModifyKnowledgeBaseCategoryFromJson(json);
  
  Map<String, dynamic> toJson() => _$ModifyKnowledgeBaseCategoryToJson(this);
}

