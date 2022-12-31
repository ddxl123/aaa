
part of httper;
class OtherResponseCode {
    /// 返回是否被拦截处理。
    static Future<T?> handleCode<T>({
        required int inputCode,
        required Future<T> Function(String message) code10000,
        required Future<T> Function(String message) code10001,
        required Future<T> Function(String message) code10011,
        required Future<T> Function(String message) code10012,
        required Future<T> Function(String message) code10013,
        required Future<T> Function(String message) code10014,
        required Future<T> Function(String message) code10015,
    }) async {
        if (inputCode == 10000) {
            return await code10000("服务器出现未知异常！10000");
        }
        if (inputCode == 10001) {
            return await code10001("服务器出现未知异常！10001");
        }
        if (inputCode == 10011) {
            return await code10011("用户登录异常！");
        }
        if (inputCode == 10012) {
            return await code10012("用户登录已过期！");
        }
        if (inputCode == 10013) {
            return await code10013("用户在其他设备被登录！");
        }
        if (inputCode == 10014) {
            return await code10014("该用户已被强制下线！");
        }
        if (inputCode == 10015) {
            return await code10015("用户未登录！");
        }
        return null;
    }
}
