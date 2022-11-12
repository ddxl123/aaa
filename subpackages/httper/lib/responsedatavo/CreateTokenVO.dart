
part of httper;

class CreateTokenVO extends ResponseDataVOBase {
  late String emailToken;

  @override
  CreateTokenVO from(Map<String, dynamic> dataJson) {
    final MToken forKey = MToken();
    emailToken = dataJson[forKey.token] as String;
    return this;
  }
}
