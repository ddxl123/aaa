part of httper;

/// 全局 [dio]
final Dio dio = Dio(
  BaseOptions(
    baseUrl: HttpPath.BASE_PATH_LOCAL, // 仅本地
    connectTimeout: 30000, // ms
    receiveTimeout: 30000, // ms
  ),
);
