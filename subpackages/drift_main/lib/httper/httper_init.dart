part of httper;

/// 全局 [dio]
final Dio dio = Dio(
  BaseOptions(
    baseUrl: HttpPath.BASE_PATH_LOCAL, // 仅本地
    contentType: Headers.jsonContentType,
    connectTimeout: Duration(seconds: 20),
    receiveTimeout: Duration(seconds: 20),
  ),
);

/// 当 [dtoDataList] 为 null 时，[dtoData] 的作用为请求数据体。
/// 当 [dtoDataList] 不为 null 时，[dtoData] 的作用将不是请求数据体，而是需给予一个任意数据的 [RQ] 类型对象，以便存储响应数据，
Future<RQ> request<RQ extends BaseObject, RP extends BaseObject>({
  required String path,
  required RQ dtoData,
  List<RQ>? dtoDataList,
  required RP Function(Map<String, dynamic> responseData) parseResponseVoData,
  ProgressCallback? onSendProgress,
  ProgressCallback? onReceiveProgress,
}) async {
  dynamic responseData;
  try {
    final result = await dio.post(
      path,
      data: dtoDataList != null ? dtoDataList.map((e) => e.toJson()).toList() : dtoData.toJson(),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    responseData = result.data;
    final parseCode = result.data["code"];
    final parseMessage = result.data["message"];
    final parseVo = result.data["data"] == null ? null : parseResponseVoData(result.data["data"]);
    final otherCodeResult = await otherCodeHandle(code: parseCode);
    if (otherCodeResult != null) {
      throw otherCodeResult;
    }
    print(result.headers);
    return (dtoData as dynamic)
      ..code = parseCode
      ..httperException = HttperException(showMessage: parseMessage, debugMessage: '')
      ..vo = parseVo;
  } catch (e, st) {
    if (e is DioError) {
      //TODO: 其他 DioErrorType 的处理。
      if (e.type == DioErrorType.sendTimeout || e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.receiveTimeout) {
        return (dtoData as dynamic)
          ..code = null
          ..httperException = HttperException(
            showMessage: '请求超时！',
            debugMessage: '$e\nrequestDtoData:${dtoData.toJson()}\nrequestDtoDataList:${dtoDataList?.map((e) => e.toJson())}\nresponseData: $responseData',
          )
          ..vo = null
          ..st = st;
      }
    }
    return (dtoData as dynamic)
      ..code = null
      ..httperException = HttperException(
        showMessage: '请求异常！',
        debugMessage: '$e\nrequestDtoData:${dtoData.toJson()}\nrequestDtoDataList:${dtoDataList?.map((e) => e.toJson())}\nresponseData: $responseData',
      )
      ..vo = null
      ..st = st;
  }
}

/// 返回值如果为 null，则未被拦截，否则被拦截。
Future<String?> otherCodeHandle({required int code}) async {
  return await OtherResponseCode.handleCode<String?>(
    inputCode: code,
    code1000000: (String showMessage) async {
      return showMessage;
    },
    code1000001: (String showMessage) async {
      return showMessage;
    },
    code1000101: (String showMessage) async {
      return showMessage;
    },
    code1000102: (String showMessage) async {
      return showMessage;
    },
    code1000103: (String showMessage) async {
      return showMessage;
    },
    code1000104: (String showMessage) async {
      return showMessage;
    },
    code1000105: (String showMessage) async {
      return showMessage;
    },
  );
}

Future<void> requestDownload() async {
  await dio.post(
    "",
    data: {},
    onReceiveProgress: (int count, int total) {},
  );
}

Future<void> requestUpload() async {
  await dio.post(
    "",
    data: {},
    onSendProgress: (int count, int total) {},
  );
}
