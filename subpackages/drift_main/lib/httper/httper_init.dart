part of httper;

/// 全局 [dio]
final Dio dio = Dio(
  BaseOptions(
    baseUrl: HttpPath.BASE_PATH_LOCAL, // 仅本地
    connectTimeout: 30000, // ms
    receiveTimeout: 30000, // ms
  ),
);

Future<RQ> request<RQ extends BaseObject, RP extends BaseObject>({
  required String path,
  required RQ data,
  required RP Function(dynamic responseData) parseResponseData,
}) async {
  try {
    final result = await dio.post(path, data: data.toJson());
    final parseCode = int.parse(result.data["code"]);
    final parseMessage = result.data["message"].toString();
    final parseVo = result.data["data"] == null ? null : parseResponseData(result.data["data"]);
    final otherCodeResult = await otherCodeHandle(code: parseCode);
    if (otherCodeResult != null) {
      throw otherCodeResult;
    }
    return (data as dynamic)
      ..code = parseCode
      ..message = parseMessage
      ..vo = parseVo;
  } catch (e) {
    return (data as dynamic)
      ..code = null
      ..message = "$e"
      ..vo = null;
  }
}

/// 返回值如果为 null，则未被拦截，否则被拦截。
Future<String?> otherCodeHandle({required int code}) async {
  return await OtherResponseCode.handleCode<String?>(
    inputCode: code,
    code10000: (String message) async {
      return message;
    },
    code10001: (String message) async {
      return message;
    },
    code10011: (String message) async {
      return message;
    },
    code10012: (String message) async {
      return message;
    },
    code10013: (String message) async {
      return message;
    },
    code10014: (String message) async {
      return message;
    },
    code10015: (String message) async {
      return message;
    },
  );
}
