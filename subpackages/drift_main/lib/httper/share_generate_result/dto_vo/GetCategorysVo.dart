
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class GetCategorysVo extends BaseObject{

    /// 
    String one_level_category_names;


GetCategorysVo({

    required this.one_level_category_names,

});
  factory GetCategorysVo.fromJson(Map<String, dynamic> json) => _$GetCategorysVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$GetCategorysVoToJson(this);
  
  
}
