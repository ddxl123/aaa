// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names


part of httper;

class HttpStore_login_and_register_by_email_verify_email extends HttpStore_POST<RequestDataVO_LARBEVE, ResponseCodeCollect_LARBEVE, ResponseDataVO_LARBEVE> {
  HttpStore_login_and_register_by_email_verify_email({
    required RequestDataVO_LARBEVE requestDataVO_LARBEVE,
  }) : super(
          HttpPath.NO_JWT + '/login_and_register_by_email/verify_email',
          requestDataVO_LARBEVE,
          ResponseCodeCollect_LARBEVE(),
          ResponseDataVO_LARBEVE(),
        );
}

class RequestDataVO_LARBEVE extends RequestDataVO {
  RequestDataVO_LARBEVE({required this.email, required this.code});

  final KeyValue<String> email;

  final KeyValue<int> code;

  @override
  List<KeyValue<Object?>> get keyValues => <KeyValue<Object?>>[email, code];
}

class ResponseCodeCollect_LARBEVE extends ResponseCodeCollect {
  /// 注册成功。
  final int C1_02_02 = 1010202;

  /// 登陆成功。
  final int C1_02_05 = 1010205;
}

class ResponseDataVO_LARBEVE extends ResponseDataVO {
  late String token;

  @override
  ResponseDataVO from(Map<String, dynamic> dataJson) {
    token = dataJson['token'] as String;
    return this;
  }
}
