// ignore_for_file: non_constant_identifier_names

part of httper;

/// token 验证失败需重新登陆的 code。
class ReLoginCodeCollect {
  final int C1_05_01 = 3010501;

  final int C1_05_02 = 3010502;

  final int C1_05_03 = 3010503;

  final int C1_05_04 = 3010504;
}

class HttpResponseIntercept<RESPCCOL extends ResponseCodeCollect, RESPDVO extends ResponseDataVO> {
  HttpResponseIntercept(this.httpResponse);

  final HttpResponse<RESPCCOL, RESPDVO> httpResponse;
  final ReLoginCodeCollect reLoginCodeCollect = ReLoginCodeCollect();

  Future<void> handle() async {
    await _tokenVerifyFailIntercept();
  }

  Future<void> _tokenVerifyFailIntercept() async {
    // token 验证失败（可能是 token 过期），需重新登陆。
    if (httpResponse.code == reLoginCodeCollect.C1_05_01 ||
        httpResponse.code == reLoginCodeCollect.C1_05_02 ||
        httpResponse.code == reLoginCodeCollect.C1_05_03 ||
        httpResponse.code == reLoginCodeCollect.C1_05_04) {
      // TODO: 这里弹出重新登陆框。s
    }
  }
}
