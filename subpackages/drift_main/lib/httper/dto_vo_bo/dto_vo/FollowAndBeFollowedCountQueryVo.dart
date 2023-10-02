
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FollowAndBeFollowedCountQueryVo extends BaseObject{

    /// 
    int follow_count;

    /// 
    int be_followed_count;


FollowAndBeFollowedCountQueryVo({

    required this.follow_count,

    required this.be_followed_count,

});
  factory FollowAndBeFollowedCountQueryVo.fromJson(Map<String, dynamic> json) => _$FollowAndBeFollowedCountQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FollowAndBeFollowedCountQueryVoToJson(this);
  
  
}
