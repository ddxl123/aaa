
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class BeFollowQueryVo extends BaseObject{

    /// 如果为 null，则未关注
    int? user_follow_id;


BeFollowQueryVo({

    required this.user_follow_id,

});
  factory BeFollowQueryVo.fromJson(Map<String, dynamic> json) => _$BeFollowQueryVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$BeFollowQueryVoToJson(this);
  
  
}
