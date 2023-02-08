
// ignore_for_file: non_constant_identifier_names
part of httper;

@JsonSerializable()
class DeviceAndTokenBo {
    String device_info;
    String token;

DeviceAndTokenBo({
    required this.device_info,
    required this.token,

});

  factory DeviceAndTokenBo.fromJson(Map<String, dynamic> json) => _$DeviceAndTokenBoFromJson(json);
  
  Map<String, dynamic> toJson() => _$DeviceAndTokenBoToJson(this);
}

@JsonSerializable()
class KnowledgeBaseContent {
    FragmentGroup? fragment_group;
    String publisher_username;

KnowledgeBaseContent({
    required this.fragment_group,
    required this.publisher_username,

});

  factory KnowledgeBaseContent.fromJson(Map<String, dynamic> json) => _$KnowledgeBaseContentFromJson(json);
  
  Map<String, dynamic> toJson() => _$KnowledgeBaseContentToJson(this);
}

