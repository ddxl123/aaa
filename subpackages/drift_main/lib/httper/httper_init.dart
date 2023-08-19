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
  final token = (await db.generalQueryDAO.queryClientSyncInfoOrNull())?.token;
  return token == null ? null : {"token": "Bearer $token"};
}

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
    final tokenMap = await _getTokenHeaderMap();
    final result = await dio.post(
      path,
      options: Options(headers: tokenMap),
      data: dtoDataList != null ? dtoDataList.map((e) => e.toJson()).toList() : dtoData.toJson(),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    responseData = result.data;
    final parseCode = result.data["code"];
    final parseMessage = result.data["message"];
    final parseVo = result.data["data"] == null ? null : parseResponseVoData(result.data["data"]);
    final otherCodeResult = await otherCodeHandle(code: parseCode);
    if (otherCodeResult) {
      throw HttperException(showMessage: parseMessage, debugMessage: "拦截到 otherCode 异常，code: $parseCode");
    }
    return (dtoData as dynamic)
      ..code = parseCode
      ..httperException = HttperException(showMessage: parseMessage, debugMessage: '无异常')
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
    if (e is HttperException) {
      return (dtoData as dynamic)
        ..code = null
        ..httperException = e
        ..vo = null
        ..st = st;
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
  forceCloud,

  /// 第一次上传
  ///
  /// 若上传成功，自己根据 [FilePathWrapper.finalHandle] 操作要不要存储或覆盖掉本地
  firstUpload,

  /// 重新上传
  ///
  /// 若上传成功，自己根据 [FilePathWrapper.finalHandle] 操作要不要存储或覆盖掉本地
  ///
  /// 当不存在云端路径，则会进行插入
  coverInsertUpload,
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

    if (fileRequestMethod == FileRequestMethod.forceCloud) {
      await cloudGet();
      await updateCache();
      await onSuccess(filePathWrapper);
      return;
    }

    if (fileRequestMethod == FileRequestMethod.firstUpload) {
      await cloudInsert();
      await updateCache();
      await onSuccess(filePathWrapper);
      return;
    }
    if (fileRequestMethod == FileRequestMethod.coverInsertUpload) {
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
