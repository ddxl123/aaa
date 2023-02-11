import 'dart:isolate';

import 'package:flutter/services.dart';

///
/// // 必须是静态函数或顶级函数。
/// void aaa(IsolateWrapper isolateWrapper) {
///   Isolater.registerBackgroundIsolate(
///      isolateWrapper,
///      (SendPort sendPort, Object? msg) async {
///       // 使用 sendPort 向 root 发送消息。
///     },
///   );
/// }
///
/// void main() {
///   // 可在任意地方调用。
///   Isolater.spawn(
///      aaa,
///      (SendPort sendPort, Object? msg) async {
///       // 调用 spawn 时，会初始化调用一次 onReceive
///       // 之后可以使用 sendPort 向 aaa 发送消息。
///       print("init call");
///     },
///   );
class IsolateWrapper {
  IsolateWrapper({
    required this.rootIsolateToken,
    required this.rootSendPort,
  });

  final RootIsolateToken rootIsolateToken;
  final SendPort rootSendPort;
}

class Isolater {
  Isolater._();

  final rootReceivePort = ReceivePort();
  late final SendPort backgroundSendPort;

  static void spawn(
    void Function(IsolateWrapper isolateWrapper) entry,
    void Function(SendPort sendPort, Object? msg) onReceive,
  ) {
    final ins = Isolater._();
    Isolate.spawn(
      entry,
      IsolateWrapper(rootIsolateToken: RootIsolateToken.instance!, rootSendPort: ins.rootReceivePort.sendPort),
    );
    ins.rootReceivePort.listen(
      (message) {
        if (message is SendPort) {
          ins.backgroundSendPort = message;
          onReceive(ins.backgroundSendPort, null);
        } else {
          onReceive(ins.backgroundSendPort, message);
        }
      },
    );
  }

  static void registerBackgroundIsolate(
    IsolateWrapper isolateWrapper,
    void Function(SendPort sendPort, Object? msg) onReceive,
  ) {
    // 将后台isolate注册为root isolate
    BackgroundIsolateBinaryMessenger.ensureInitialized(isolateWrapper.rootIsolateToken);
    final backgroundReceivePort = ReceivePort();
    isolateWrapper.rootSendPort.send(backgroundReceivePort.sendPort);
    backgroundReceivePort.listen(
      (message) {
        onReceive(isolateWrapper.rootSendPort, message);
      },
    );
  }
}
