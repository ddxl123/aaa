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

Future<Map<String, String>?> _getTokenHeaderMap() async {
  final token = (await driftDb.generalQueryDAO.queryClientSyncInfoOrNull())?.token;
  return token == null ? null : {"token": "Bearer $token"};
}

/// 当 [dtoDataList] 为 null 时，[dtoData] 的作用为请求数据体。
/// 当 [dtoDataList] 不为 null 时，[dtoData] 的作用将不是请求数据体，而是需给予一个任意数据的 [RQ] 类型对象，以便存储响应数据，
Future<RQ> request<RQ extends BaseObject, RP extends BaseObject>({
  required String path,
  required RQ dtoData,
  List<RQ>? dtoDataList,
  required RP Function(Map<String, dynamic> responseData) parseResponseVoData,
  ProgressCallback? onReceiveProgress,
}) async {
  dynamic responseData;
  try {
    final tokenMap = await _getTokenHeaderMap();
    late final Response result;
    if (path.startsWith("GET_")) {
      if (dtoDataList != null) {
        throw "GET 请求的请求参数不要用数组。";
      }
      result = await dio.get(
        path.substring(4, path.length),
        options: Options(
          headers: tokenMap,
          responseType: onReceiveProgress == null ? null : ResponseType.stream,
        ),
        queryParameters: dtoData.toJson(),
        onReceiveProgress: onReceiveProgress,
      );
    } else if (path.startsWith("POST_")) {
      result = await dio.post(
        path.substring(5, path.length),
        options: Options(
          headers: tokenMap,
          responseType: onReceiveProgress == null ? null : ResponseType.stream,
        ),
        data: dtoDataList != null ? dtoDataList.map((e) => e.toJson()).toList() : dtoData.toJson(),
        onReceiveProgress: onReceiveProgress,
      );
    }

    final dataWrapper = <String, dynamic>{};

    print(result.headers.toString());
    if (onReceiveProgress != null) {
      dataWrapper.addAll(jsonDecode(await utf8.decoder.bind((result.data as ResponseBody).stream).join()));
    } else {
      dataWrapper.addAll(result.data);
    }

    final parseCode = dataWrapper["code"];
    final parseMessage = dataWrapper["message"];
    final parseVo = dataWrapper["data"] == null ? null : parseResponseVoData(dataWrapper["data"]);
    final otherCodeResult = await otherCodeHandle(code: parseCode);
    if (otherCodeResult) {
      throw HttperException(showMessage: parseMessage, debugMessage: "拦截到 otherCode 异常，code: $parseCode");
    }
    return (dtoData as dynamic)
      ..code = parseCode
      ..successMessage = parseMessage
      ..httperException = null
      ..vo = parseVo;
  } catch (e, st) {
    if (e is DioError) {
      //TODO: 其他 DioErrorType 的处理。
      if (e.type == DioErrorType.sendTimeout || e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.receiveTimeout) {
        return (dtoData as dynamic)
          ..code = null
          ..successMessage = null
          ..httperException = HttperException(
            showMessage: '请求超时！',
            debugMessage: '$e\nrequestDtoData:${dtoData.toJson()}\nrequestDtoDataList:${dtoDataList?.map((e) => e.toJson())}\nresponseData: $responseData',
          )
          ..vo = null
          ..st = st;
      }
    }
    if (e is HttperException) {
      return (dtoData as dynamic)
        ..code = null
        ..successMessage = null
        ..httperException = e
        ..vo = null
        ..st = st;
    }
    return (dtoData as dynamic)
      ..code = null
      ..successMessage = null
      ..httperException = HttperException(
        showMessage: '请求异常！',
        debugMessage: '$e\nrequestDtoData:${dtoData.toJson()}\nrequestDtoDataList:${dtoDataList?.map((e) => e.toJson())}\nresponseData: $responseData',
      )
      ..vo = null
      ..st = st;
  }
}

/// 返回值如果为 true，则被拦截，否则未被拦截。
Future<bool> otherCodeHandle({required int code}) async {
  final result = await OtherResponseCode.handleCode<bool>(
    inputCode: code,
    code1000000: (String showMessage) async {
      return true;
    },
    code1000001: (String showMessage) async {
      return true;
    },
    code1000101: (String showMessage) async {
      return true;
    },
    code1000102: (String showMessage) async {
      return true;
    },
    code1000103: (String showMessage) async {
      return true;
    },
    code1000104: (String showMessage) async {
      return true;
    },
    code1000105: (String showMessage) async {
      return true;
    },
    code1000106: (String showMessage) async {
      return true;
    },
  );
  return result ?? false;
}

class FilePathWrapper {
  FilePathWrapper({
    required this.fileUint8List,
    required this.oldCloudPath,
  }) {
    newCloudPath = oldCloudPath;
  }

  /// 需要上传或加载的文件
  Uint8List? fileUint8List;

  /// 存储在云端的路径
  ///
  /// 该路径不包含基础连接和 content。
  /// 例如，/userAvatars/1
  final String? oldCloudPath;

  /// 默认值是 [oldCloudPath]
  String? newCloudPath;

  bool get isOldNewSame => oldCloudPath == newCloudPath;

  /// 将 [cloudPath] 转换成完整连接
  ///
  /// 例如：将 /userAvatars/1 转换成 http://192.168.1.1:8080/userAvatars/1/content
  static String? toAvailablePath({required String? cloudPath}) {
    if (cloudPath == null) return null;
    return "${dio.options.baseUrl + cloudPath}/content";
  }
}

/// 文件请求方式
enum FileRequestMethod {
  /// 强制从云端获取，若获取失败，则报错
  ///
  /// 云端获取成功，自己根据 [FilePathWrapper.finalHandle] 操作要不要存储或覆盖掉本地
  download,

  /// 第一次上次或重新上传
  ///
  /// 若上传成功，自己根据 [FilePathWrapper.finalHandle] 操作要不要存储或覆盖掉本地
  upload,
}

enum CloudGetExceptionType {
  /// 没有异常
  none,

  /// 404
  dioStatus404,

  /// 非 404
  dioStatusOther,

  /// 其他
  other,
}

/// [isUpdateCache] 是否在成功时本地图片更新缓存。
Future<void> requestFile({
  required HttpFileEnum httpFileEnum,
  required FilePathWrapper filePathWrapper,
  required FileRequestMethod fileRequestMethod,
  required bool isUpdateCache,
  required Future<void> Function(FilePathWrapper filePathWrapper) onSuccess,
  required Future<void> Function(FilePathWrapper filePathWrapper, dynamic e, StackTrace st) onError,
}) async {
  try {
    final prefixPath = "/file/${httpFileEnum.text}";
    final tokenMap = await _getTokenHeaderMap();
    final halContentTypeMap = {"Content-Type": "application/hal+json"};
    final imageContentTypeMap = {"Content-Type": "image/*"};

    // 从云端获取图片
    Future<void> cloudGet() async {
      if (filePathWrapper.oldCloudPath == null) {
        throw "联网获取失败，请重新上传！";
      }
      final response = await dio.get(
        "${filePathWrapper.oldCloudPath!}/content",
        options: Options(responseType: ResponseType.bytes),
      );
      filePathWrapper.fileUint8List = response.data as Uint8List;
    }

    Future<void> cloudInsert() async {
      if (filePathWrapper.fileUint8List == null) {
        throw "未提供文件！";
      }
      final responseForEntity = await dio.post(
        prefixPath,
        options: Options(
          headers: (tokenMap ?? {})..addAll(halContentTypeMap),
        ),
        // 必要
        data: {},
      );
      // 得到实体 path
      final entityPath = "$prefixPath/${responseForEntity.headers.value("location")!.split("/").last}";

      await dio.post(
        "$entityPath/content",
        options: Options(
          headers: imageContentTypeMap..addAll(tokenMap!),
        ),
        data: filePathWrapper.fileUint8List!,
      );
      filePathWrapper.newCloudPath = entityPath;
    }

    Future<void> cloudUpdate() async {
      try {
        if (filePathWrapper.fileUint8List == null) {
          throw "未提供文件！";
        }
        await dio.put(
          "${filePathWrapper.oldCloudPath!}/content",
          options: Options(headers: tokenMap),
          data: filePathWrapper.fileUint8List,
        );
      } catch (e, st) {
        if (e is DioException) {
          if (e.response?.statusCode == 404) {
            await cloudInsert();
          }
        }
        rethrow;
      }
    }

    Future<void> updateCache() async {
      if (isUpdateCache) {
        await CachedNetworkImage.evictFromCache(FilePathWrapper.toAvailablePath(cloudPath: filePathWrapper.newCloudPath)!);
      }
    }

    if (fileRequestMethod == FileRequestMethod.download) {
      await cloudGet();
      await updateCache();
      await onSuccess(filePathWrapper);
      return;
    }

    if (fileRequestMethod == FileRequestMethod.upload) {
      if (filePathWrapper.oldCloudPath == null) {
        await cloudInsert();
        await updateCache();
        await onSuccess(filePathWrapper);
        return;
      } else {
        await cloudUpdate();
        await updateCache();
        await onSuccess(filePathWrapper);
        return;
      }
    }
    throw "未处理 ${fileRequestMethod.name}";
  } catch (e, st) {
    await onError(filePathWrapper, e, st);
  }
}

Future<void> requestSingleRowInsert({
  required bool isLoginRequired,
  required SingleRowInsertDto singleRowInsertDto,
  required Future<void> Function(String showMessage, SingleRowInsertVo vo) onSuccess,
  Future<void> Function(int? code, HttperException httperException, StackTrace st)? onError,
}) async {
  final result = await request(
    path: isLoginRequired ? HttpPath.POST__LOGIN_REQUIRED_SINGLE_ROW_INSERT : HttpPath.POST__NO_LOGIN_REQUIRED_SINGLE_ROW_INSERT,
    dtoData: singleRowInsertDto,
    parseResponseVoData: SingleRowInsertVo.fromJson,
  );
  await result.handleCode(
    code100101: (String showMessage, SingleRowInsertVo vo) async {
      await onSuccess(showMessage, vo);
    },
    otherException: (int? code, HttperException httperException, StackTrace st) async {
      if (onError == null) throw httperException;
      await onError(code, httperException, st);
    },
  );
}

Future<void> requestSingleRowModify({
  required bool isLoginRequired,
  required SingleRowModifyDto singleRowModifyDto,
  required Future<void> Function(String showMessage, SingleRowModifyVo vo) onSuccess,
  Future<void> Function(int? code, HttperException httperException, StackTrace st)? onError,
}) async {
  final result = await request(
    path: isLoginRequired ? HttpPath.POST__LOGIN_REQUIRED_SINGLE_ROW_MODIFY : HttpPath.POST__NO_LOGIN_REQUIRED_SINGLE_ROW_MODIFY,
    dtoData: singleRowModifyDto,
    parseResponseVoData: SingleRowModifyVo.fromJson,
  );
  await result.handleCode(
    code110101: (String showMessage, SingleRowModifyVo vo) async {
      await onSuccess(showMessage, vo);
    },
    otherException: (int? code, HttperException httperException, StackTrace st) async {
      if (onError == null) throw httperException;
      await onError(code, httperException, st);
    },
  );
}

Future<void> requestSingleRowQuery({
  required bool isLoginRequired,
  required SingleRowQueryDto singleRowQueryDto,
  required Future<void> Function(String showMessage, SingleRowQueryVo vo) onSuccess,
  Future<void> Function(int? code, HttperException httperException, StackTrace st)? onError,
}) async {
  final result = await request(
    path: isLoginRequired ? HttpPath.POST__LOGIN_REQUIRED_SINGLE_ROW_QUERY : HttpPath.POST__NO_LOGIN_REQUIRED_SINGLE_ROW_QUERY,
    dtoData: singleRowQueryDto,
    parseResponseVoData: SingleRowQueryVo.fromJson,
  );
  await result.handleCode(
    code90101: (String showMessage, SingleRowQueryVo vo) async {
      await onSuccess(showMessage, vo);
    },
    otherException: (int? code, HttperException httperException, StackTrace st) async {
      if (onError == null) throw httperException;
      await onError(code, httperException, st);
    },
  );
}

Future<void> requestSingleRowDelete({
  required bool isLoginRequired,
  required SingleRowDeleteDto singleRowDeleteDto,
  required Future<void> Function(String showMessage) onSuccess,
  Future<void> Function(int? code, HttperException httperException, StackTrace st)? onError,
}) async {
  final result = await request(
    path: isLoginRequired ? HttpPath.POST__LOGIN_REQUIRED_SINGLE_ROW_DELETE : HttpPath.POST__NO_LOGIN_REQUIRED_SINGLE_ROW_DELETE,
    dtoData: singleRowDeleteDto,
    parseResponseVoData: SingleRowDeleteVo.fromJson,
  );
  await result.handleCode(
    code120101: (String showMessage) async {
      await onSuccess(showMessage);
    },
    otherException: (int? code, HttperException httperException, StackTrace st) async {
      if (onError == null) throw httperException;
      await onError(code, httperException, st);
    },
  );
}
