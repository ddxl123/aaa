
// ignore_for_file: non_constant_identifier_names
part of httper;

@JsonSerializable()
class DeviceAndTokenBo {
    String device;
    String token;

DeviceAndTokenBo({
    required this.device,
    required this.token,

});

  factory DeviceAndTokenBo.fromJson(Map<String, dynamic> json) => _$DeviceAndTokenBoFromJson(json);
  
  Map<String, dynamic> toJson() => _$DeviceAndTokenBoToJson(this);
}

