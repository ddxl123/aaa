
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentGroupLikeChangeForCurrentLoginedVo extends BaseObject{

    /// 最终喜欢的结果，若为 null 则最终是不喜欢，否则则是喜欢。
    int? liked;


FragmentGroupLikeChangeForCurrentLoginedVo({

    required this.liked,

});
  factory FragmentGroupLikeChangeForCurrentLoginedVo.fromJson(Map<String, dynamic> json) => _$FragmentGroupLikeChangeForCurrentLoginedVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentGroupLikeChangeForCurrentLoginedVoToJson(this);
  
  
}
