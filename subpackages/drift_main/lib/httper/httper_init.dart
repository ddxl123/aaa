part of httper;

/// 全局 [dio]
final Dio dio = Dio(
  BaseOptions(
    baseUrl: HttpPath.BASE_PATH_LOCAL, // 仅本地
    connectTimeout: 10000, // ms
    receiveTimeout: 10000, // ms
  ),
);

Future<RQ> request<RQ extends BaseObject, RP extends BaseObject>({
  required String path,
  required RQ data,
  required RP Function(dynamic responseData) parseResponseData,
}) async {
  dynamic responseData;
  try {
    final result = await dio.post(path, data: data.toJson());
    responseData = result.data;
    final parseCode = result.data["code"];
    final parseMessage = result.data["message"];
    final parseVo = result.data["data"] == null ? null : parseResponseData(result.data["data"]);
    final otherCodeResult = await otherCodeHandle(code: parseCode);
    if (otherCodeResult != null) {
      throw otherCodeResult;
    }
    return (data as dynamic)
      ..code = parseCode
      ..httperMessage = HttperMessage(showMessage: parseMessage, debugMessage: '')
      ..vo = parseVo;
  } catch (e, st) {
    if (e is DioError) {
      if (e.type == DioErrorType.sendTimeout || e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        return (data as dynamic)
          ..code = null
          ..httperMessage = HttperMessage(
            showMessage: '请求超时！',
            debugMessage: '$e\nresponseData: $responseData',
          )
          ..vo = null
          ..st = st;
      }
    }
    return (data as dynamic)
      ..code = null
      ..httperMessage = HttperMessage(
        showMessage: '请求异常！',
        debugMessage: '$e\nresponseData: $responseData',
      )
      ..vo = null
      ..st = st;
  }
}

/// 返回值如果为 null，则未被拦截，否则被拦截。
/// TODO:
Future<String?> otherCodeHandle({required int code}) async {
  return await OtherResponseCode.handleCode<String?>(
    inputCode: code,
    code10000: (String showMessage) async {
      return showMessage;
    },
    code10001: (String showMessage) async {
      return showMessage;
    },
    code10011: (String showMessage) async {
      return showMessage;
    },
    code10012: (String showMessage) async {
      return showMessage;
    },
    code10013: (String showMessage) async {
      return showMessage;
    },
    code10014: (String showMessage) async {
      return showMessage;
    },
    code10015: (String showMessage) async {
      return showMessage;
    },
  );
}
