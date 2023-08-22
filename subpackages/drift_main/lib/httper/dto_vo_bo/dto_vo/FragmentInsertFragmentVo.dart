
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class FragmentInsertFragmentVo extends BaseObject{

    /// 插入后带有 id 的新碎片
    Fragment fragment;


FragmentInsertFragmentVo({

    required this.fragment,

});
  factory FragmentInsertFragmentVo.fromJson(Map<String, dynamic> json) => _$FragmentInsertFragmentVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$FragmentInsertFragmentVoToJson(this);
  
  
}
