
// ignore_for_file: non_constant_identifier_names
part of httper;

@JsonSerializable()
class CategoryContent {
    Fragment fragment_info;
    String publisher_username;

CategoryContent({
    required this.fragment_info,
    required this.publisher_username,

});

  factory CategoryContent.fromJson(Map<String, dynamic> json) => _$CategoryContentFromJson(json);
  
  Map<String, dynamic> toJson() => _$CategoryContentToJson(this);
}

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

