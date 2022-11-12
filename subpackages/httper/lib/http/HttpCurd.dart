// ignore_for_file: avoid_classes_with_only_static_members

part of httper;

class HttpCurd {
  /// 【常规】请求的不可并发请求标志
  static final Map<String, bool> _sameNotConcurrentMap = <String, bool>{};

  /// 是否禁止所有请求。
  static bool _isBanAllRequest = false;

  ///
  ///
  ///
  /// general request
  ///
  /// [sameNotConcurrent] 不可并发标记。多个请求（可相同可不同），具有相同标记的请求不可并发。为 null 时代表不进行标记（即可并发）。
  ///
  /// [isBanAllOtherRequest] 若为 true，则其他请求全部禁止，只有当前请求继续直到当前请求结束。
  ///   - 若为 true，但同时存在其他请求，则当前请求也会失败。
  ///   - 若为 true，则 [sameNotConcurrent] 可为空。
  ///
  /// 向云端修改数据成功，而响应回本地修改 sqlite 数据失败 ———— 该问题会在 [SqliteCurd] 中进行处理。
  ///
  static Future<HS> sendRequest<HS extends HttpStore>({
    required HS Function() getHttpStore,
    required String? sameNotConcurrent,
    bool isBanAllOtherRequest = false,
  }) async {
    try {
      // 在捕获异常内进行生成，以便生成时出现异常能直接捕获。
      final HS httpStore = getHttpStore();
      await httpStore.requestCheck();

      if (_isBanAllRequest) {
        return httpStore.setCancel(description: '已禁止全部请求！', exception: null, stackTrace: null) as HS;
      }

      if (isBanAllOtherRequest) {
        // 若存在任意请求，则当前请求触发失败。
        if (_sameNotConcurrentMap.isNotEmpty) {
          return httpStore.setCancel(description: '要禁止其他全部请求时，已存在其他请求，需在没有任何请求的情况下才能触发！', exception: null, stackTrace: null) as HS;
        }
        _isBanAllRequest = true;
      }

      if (sameNotConcurrent != null) {
        /// 若相同请求被并发
        if (_sameNotConcurrentMap.containsKey(sameNotConcurrent)) {
          return httpStore.setCancel(description: '相同标记的请求被并发！', exception: null, stackTrace: null) as HS;
        }

        /// 当相同请求未并发时，对当前请求做阻断标记
        _sameNotConcurrentMap[sameNotConcurrent] = true;
      }

      // SbLogger(
      //   code: null,
      //   viewMessage: null,
      //   data: null,
      //   description: '${httpStore.httpRequest.path} ' + dio.options.baseUrl + httpStore.httpRequest.path,
      //   exception: null,
      //   stackTrace: null,
      // );

      // if (isDev) {
      //   await Future<void>.delayed(const Duration(seconds: 2));
      // }

      final Response<Map<String, dynamic>> response = await dio.request<Map<String, dynamic>>(
        httpStore.httpRequest.path,
        data: httpStore.httpRequest.requestDataVO?.toJson(),
        queryParameters: httpStore.httpRequest.requestParamsVO?.toJson(),
        options: Options(
          method: httpStore.httpRequest.path,
          headers: httpStore.httpRequest.requestHeaders,
        ),
      );

      _sameNotConcurrentMap.remove(sameNotConcurrent);
      _isBanAllRequest = false;
      return httpStore.setPass(response) as HS;
    } catch (e, st) {
      _sameNotConcurrentMap.remove(sameNotConcurrent);
      _isBanAllRequest = false;
      return HttpStore_Catch().setCancel(description: '请求出现异常！', exception: e, stackTrace: st) as HS;
    }
  }

  ///
  ///
  ///
  ///
  ///
// static Future<bool> sendRequestForRefreshToken() async {
//   bool isSuccess = false;
//
//   try {
//     final List<MToken> tokens = await ModelManager.queryRowsAsModels(connectTransaction: null, tableName: MToken().tableName);
//
//     final Map<String, String> headers = <String, String>{'Authorization': 'Bearer ' + (tokens.isEmpty ? '' : (tokens.first.get_token ?? ''))};
//
//     final HttpResult<CreateTokenVO> httpResult = await sendRequest(
//       method: 'GET',
//       httpPath: HttpPath_LONGIN_AND_REGISTER_BY_EMAIL_SEND_EMAIL(),
//       headers: headers,
//       data: null,
//       queryParameters: null,
//       sameNotConcurrent: null,
//       dataVO: CreateTokenVO(),
//       isBanAllOtherRequest: true,
//     );
//
//     await httpResult.handle(
//       doCancel: (HttpResult<CreateTokenVO> ht) async {
//         isSuccess = false;
//         SbLogger(
//           code: ht.getCode,
//           viewMessage: ht.getViewMessage ?? '发生异常，请重新登陆！',
//           data: null,
//           description: ht.getDescription,
//           exception: ht.getException,
//           stackTrace: ht.getStackTrace,
//         );
//       },
//       doContinue: (HttpResult<CreateTokenVO> ht) async {
//         if (httpResult.getCode == 1) {
//           // 云端 token 生成成功，存储至本地。
//           final MToken newToken = MToken.createModel(
//             id: null,
//             aiid: null,
//             uuid: null,
//             created_at: SbHelper().newTimestamp,
//             updated_at: SbHelper().newTimestamp,
//             // 无论 token 值是否有问题，都进行存储。
//             token: httpResult.getDataVO.emailToken,
//           );
//
//           await db.delete(MToken().tableName);
//           await db.insert(newToken.tableName, newToken.getRowJson);
//
//           SbLogger(
//             code: null,
//             viewMessage: ht.getViewMessage ?? '登陆成功！',
//             data: null,
//             description: ht.getDescription,
//             exception: ht.getException,
//             stackTrace: ht.getStackTrace,
//           );
//
//           isSuccess = true;
//           return true;
//         }
//         return false;
//       },
//     );
//   } catch (e, st) {
//     isSuccess = false;
//     SbLogger(
//       code: null,
//       viewMessage: '发生异常，请重新尝试！',
//       data: null,
//       description: '刷新令牌异常！',
//       exception: e,
//       stackTrace: st,
//     );
//   }
//   return isSuccess;
// }
}
