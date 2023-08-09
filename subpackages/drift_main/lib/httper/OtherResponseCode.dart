
part of httper;
class OtherResponseCode {
    /// 返回是否被拦截处理。
    static Future<T?> handleCode<T>({
        required int inputCode,
        required Future<T> Function(String showMessage) code1000000,
        required Future<T> Function(String showMessage) code1000001,
        required Future<T> Function(String showMessage) code1000101,
        required Future<T> Function(String showMessage) code1000102,
        required Future<T> Function(String showMessage) code1000103,
        required Future<T> Function(String showMessage) code1000104,
        required Future<T> Function(String showMessage) code1000105,
        required Future<T> Function(String showMessage) code1000106,
    }) async {
        if (inputCode == 1000000) {
            return await code1000000("服务器出现未知异常！1000000");
        }
        if (inputCode == 1000001) {
            return await code1000001("服务器出现未知异常！1000001");
        }
        if (inputCode == 1000101) {
            return await code1000101("用户登录异常！");
        }
        if (inputCode == 1000102) {
            return await code1000102("用户登录已过期！");
        }
        if (inputCode == 1000103) {
            return await code1000103("用户在其他设备被登录！");
        }
        if (inputCode == 1000104) {
            return await code1000104("该用户已被强制下线！");
        }
        if (inputCode == 1000105) {
            return await code1000105("用户未登录！");
        }
        if (inputCode == 1000106) {
            return await code1000106("文本长度太长！");
        }
        return null;
    }
}
