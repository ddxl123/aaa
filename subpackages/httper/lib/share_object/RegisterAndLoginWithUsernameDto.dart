
// ignore_for_file: non_constant_identifier_names
import 'package:httper/BaseObject.dart';
import 'package:json_annotation/json_annotation.dart';
import 'RegisterAndLoginWithUsernameVo.dart';
part 'RegisterAndLoginWithUsernameDto.g.dart';
@JsonSerializable()
class RegisterAndLoginWithUsernameDto extends BaseObject{

    /// 
    String? username;

    /// 
    String? password;


RegisterAndLoginWithUsernameDto({

    required this.username,

    required this.password,

});
  factory RegisterAndLoginWithUsernameDto.fromJson(Map<String, dynamic> json) => _$RegisterAndLoginWithUsernameDtoFromJson(json);
    
  @override
  Map<String, dynamic> toJson() => _$RegisterAndLoginWithUsernameDtoToJson(this);
  
  
          
  @JsonKey(ignore: true)
  int? code;

  @JsonKey(ignore: true)
  String message = "未分配 message！";

  @JsonKey(ignore: true)
  RegisterAndLoginWithUsernameVo? vo;

  T handleCode<T>({
    // 前端 request 内部异常，统一只需消息。
    required T Function(String message) localExceptionMessage,
    

    // ccccccc
    required T Function(String message, RegisterAndLoginWithUsernameVo vo) code1,
    
    // ccccccc
    required T Function(String message) code2,
    
                
    }) {
    

    if (code == 1) {
        return code1(message, vo!);
    }

    if (code == 2) {
        return code2(message);
    }

                
    throw "未处理 code:$code";
  }
      
}
