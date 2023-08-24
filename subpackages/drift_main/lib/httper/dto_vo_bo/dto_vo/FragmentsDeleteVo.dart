
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentsDeleteVo extends BaseObject{

    /// 填充字段1
    bool? vo_padding_1;


FragmentsDeleteVo({

    required this.vo_padding_1,

});
  factory FragmentsDeleteVo.fromJson(Map<String, dynamic> json) => _$FragmentsDeleteVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentsDeleteVoToJson(this);
  
  
}
