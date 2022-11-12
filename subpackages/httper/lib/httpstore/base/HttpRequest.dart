
part of httper;
abstract class _RequestVO {
  List<KeyValue<Object?>> get keyValues;

  Map<String, dynamic> toJson() {
    final Map<String, Object?> json = <String, Object?>{};
    for (final KeyValue<Object?> item in keyValues) {
      json.addAll(<String, Object?>{item.key: item.value});
    }
    return json;
  }
}

abstract class RequestDataVO extends _RequestVO {}

abstract class RequestParamsVO extends _RequestVO {}

class KeyValue<V> {
  KeyValue(this.key, this.value);

  late String key;
  late V value;
}

class HttpRequest<REQVO extends RequestDataVO, REQPVO extends RequestParamsVO> {
  HttpRequest({
    required this.method,
    required this.path,
    required this.requestHeaders,
    required this.requestParamsVO,
    required this.requestDataVO,
  });

  /// 请求方法。GET/POST
  final String method;

  /// 请求 url。
  final String path;

  /// 请求头。
  Map<String, dynamic>? requestHeaders;

  /// 请求体 body VO 模型。
  final REQVO? requestDataVO;

  /// 请求体 params VO 模型。
  final REQPVO? requestParamsVO;
}
