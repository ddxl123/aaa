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
