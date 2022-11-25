
// ignore_for_file: non_constant_identifier_names
part of httper;
@JsonSerializable()
class RegisterAndLoginWithUsernameDto extends BaseObject{

    /// 
    String username;

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
    

    // 登录/注册成功！
    required T Function(String message, RegisterAndLoginWithUsernameVo vo) code1,
    
                
    }) {
    

    if (code == 1) {
        return code1(message, vo!);
    }

                
    throw "未处理 code:$code";
  }
      
}
