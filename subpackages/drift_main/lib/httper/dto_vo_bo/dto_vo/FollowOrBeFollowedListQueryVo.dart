
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FollowOrBeFollowedListQueryVo extends BaseObject{

    /// 
    List<UserIdAndAvatarAndName> list_list;


FollowOrBeFollowedListQueryVo({

    required this.list_list,

});
  factory FollowOrBeFollowedListQueryVo.fromJson(Map<String, dynamic> json) => _$FollowOrBeFollowedListQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FollowOrBeFollowedListQueryVoToJson(this);
  
  
}
