// ignore_for_file: camel_case_types

part of httper;

abstract class HttpStore<REQVO extends RequestDataVO, REQPVO extends RequestParamsVO, RESPCCOL extends ResponseCodeCollect, RESPDVO extends ResponseDataVO> {
  late final HttpRequest<REQVO, REQPVO> httpRequest;
  late final HttpResponse<RESPCCOL, RESPDVO> httpResponse;

  /// 直接取消。
  HttpStore<REQVO, REQPVO, RESPCCOL, RESPDVO> setCancel({required String description, required Object? exception, required StackTrace? stackTrace}) {
    httpResponse.setCancel(description, exception, stackTrace);
    return this;
  }

  /// 直接通过。
  HttpStore<REQVO, REQPVO, RESPCCOL, RESPDVO> setPass(Response<Map<String, dynamic>> response) {
    httpResponse.setPass(response);
    return this;
  }

  Future<void> requestCheck() async {
    final String must = httpRequest.path.split('/')[1];
    if (must == HttpPath.JWT) {
      final List<MToken> tokens = await ModelManager.queryRowsAsModels(connectTransaction: null, tableName: MToken().tableName);
      httpRequest.requestHeaders = <String, dynamic>{'Authorization': 'Bearer ' + (tokens.isEmpty ? '' : (tokens.first.get_token ?? ''))};
    } else if (must == HttpPath.NO_JWT) {
    } else {
      throw 'Path is irregular! "${httpRequest.path}"';
    }
  }
}

abstract class HttpStore_GET<REQPVO extends RequestParamsVO, RESPCCOL extends ResponseCodeCollect, RESPDVO extends ResponseDataVO>
    extends HttpStore<RequestDataVO, REQPVO, RESPCCOL, RESPDVO> {
  HttpStore_GET(
    String path,
    REQPVO requestParamsVO,
    RESPCCOL responseCodeCollect,
    RESPDVO responseDataVO,
  ) {
    httpRequest = HttpRequest<RequestDataVO, REQPVO>(
      method: 'GET',
      path: path,
      requestHeaders: null,
      requestParamsVO: requestParamsVO,
      requestDataVO: null,
    );
    httpResponse = HttpResponse<RESPCCOL, RESPDVO>(
      responseCodeCollect: responseCodeCollect,
      responseDataVO: responseDataVO,
    );
  }
}

abstract class HttpStore_POST<REQVO extends RequestDataVO, RESPCCOL extends ResponseCodeCollect, RESPDVO extends ResponseDataVO>
    extends HttpStore<REQVO, RequestParamsVO, RESPCCOL, RESPDVO> {
  HttpStore_POST(
    String path,
    REQVO requestDataVO,
    RESPCCOL responseCodeCollect,
    RESPDVO responseDataVO,
  ) {
    httpRequest = HttpRequest<REQVO, RequestParamsVO>(
      method: 'POST',
      path: path,
      requestHeaders: null,
      requestParamsVO: null,
      requestDataVO: requestDataVO,
    );
    httpResponse = HttpResponse<RESPCCOL, RESPDVO>(
      responseCodeCollect: responseCodeCollect,
      responseDataVO: responseDataVO,
    );
  }
}

class HttpStore_Catch extends HttpStore<RequestDataVO, RequestParamsVO, ResponseCodeCollect, ResponseDataVO> {
  HttpStore_Catch() {
    httpRequest = HttpRequest<RequestDataVO, RequestParamsVO>(
      method: '-',
      path: '-',
      requestHeaders: null,
      requestParamsVO: null,
      requestDataVO: null,
    );
    httpResponse = HttpResponse<ResponseCodeCollect, ResponseDataVO>(
      responseCodeCollect: ResponseNullCodeCollect(),
      responseDataVO: ResponseNullDataVO(),
    );
  }
}

// ========================================================================================

// abstract class HttpStoreBase_create_token extends HttpStoreBase {
//   HttpStoreBase_create_token(RequestDataVOBase getRequestDataVO) : super(getRequestDataVO);
//
//   /// 邮箱验证 --- 注册成功！
//   final int C1_02_02 = 1010202;
//
//   /// 邮箱验证 --- 登陆成功！
//   final int C1_02_05 = 1010205;
// }
