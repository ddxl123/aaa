
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentsReuseVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


FragmentsReuseVo({

    required this.vo_padding_1,

});
  factory FragmentsReuseVo.fromJson(Map<String, dynamic> json) => _$FragmentsReuseVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentsReuseVoToJson(this);
  
  
}
