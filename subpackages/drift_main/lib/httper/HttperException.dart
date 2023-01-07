part of httper;

class HttperException {
  HttperException({
    required this.showMessage,
    required this.debugMessage,
  });

  String showMessage;
  String debugMessage;

  @override
  String toString() {
    return "show:$showMessage  debug:$debugMessage";
  }
}

class ShouldNotExecuteHereHttperException extends HttperException {
  ShouldNotExecuteHereHttperException()
      : super(
          showMessage: "请求异常！",
          debugMessage: "不应该执行到这里！",
        );
}
