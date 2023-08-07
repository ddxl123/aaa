
// ignore_for_file: non_constant_identifier_names
part of httper;

/// 
@JsonSerializable()
class DataDownloadForKnowledgeBaseVo extends BaseObject{

    /// vo1-获取到的单个碎片组以及其全部子孙组。若为空，则说明下载的不是碎片组。
    List<FragmentGroup>? fragment_group_self_and_subs_list;

    /// vo2-获取到的全部碎片。若为空，则说明下载的不是碎片。
    List<DataDownloadForKnowledgeBaseFragmentWrapperBO>? fragment_wrappers_list;

    /// vo3-获取到的全部碎片组标签。若为空，则说明下载的不是碎片组标签。
    List<FragmentGroupTag>? fragment_group_tags_list;


DataDownloadForKnowledgeBaseVo({

    required this.fragment_group_self_and_subs_list,

    required this.fragment_wrappers_list,

    required this.fragment_group_tags_list,

});
  factory DataDownloadForKnowledgeBaseVo.fromJson(Map<String, dynamic> json) => _$DataDownloadForKnowledgeBaseVoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$DataDownloadForKnowledgeBaseVoToJson(this);
  
  
}
