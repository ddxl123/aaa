
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'RegisterAndLoginDto.g.dart';
@JsonSerializable()
class RegisterAndLoginDto {

    /// 
    String? username;

    /// 
    String? password;

RegisterAndLoginDto({

    required this.username,

    required this.password,

});
    factory RegisterAndLoginDto.fromJson(Map<String, dynamic> json) => _$RegisterAndLoginDtoFromJson(json);
    Map<String, dynamic> toJson() => _$RegisterAndLoginDtoToJson(this);
}
