
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class PersonalHomePageForUserInfoVo extends BaseObject{

    /// 响应用户信息，不包含敏感信息。
    User user_info;


PersonalHomePageForUserInfoVo({

    required this.user_info,

});
  factory PersonalHomePageForUserInfoVo.fromJson(Map<String, dynamic> json) => _$PersonalHomePageForUserInfoVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$PersonalHomePageForUserInfoVoToJson(this);
  
  
}
