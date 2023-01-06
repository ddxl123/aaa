import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tools/tools.dart';

class _Info {
  _Info({required this.device});

  /// 给用户展示的设备名称，每次应用初始化(获取设备信息时)写入一次，不能进行二次修改。
  /// 例如应用多开，设备名称相同。
  final String device;

  /// 应用初始化(获取设备信息时)写入一次，产生的唯一识别码，不能进行二次修改。
  /// 例如应用多开，所使用的 sqlite 数据库不同，因此该 uuid 也不同。
  final String uuid = uuidV4;

  @override
  String toString() => "$device${DeviceInfoSingle.separator}$uuid";
}

class DeviceInfoSingle {
  static const separator = ";;";

  static Future<Map<String, dynamic>> allData() async {
    return (await DeviceInfoPlugin().deviceInfo).toMap();
  }

  static Future<String> info() async {
    if (Platform.isAndroid) {
      final p = await DeviceInfoPlugin().androidInfo;
      return _Info(device: p.brand).toString();
    }
    if (Platform.isIOS) {
      final p = await DeviceInfoPlugin().iosInfo;
      return _Info(device: p.systemName ?? "IOS").toString();
    }
    if (Platform.isWindows) {
      final p = await DeviceInfoPlugin().windowsInfo;
      return _Info(device: p.productName).toString();
    }
    if (Platform.isMacOS) {
      final p = await DeviceInfoPlugin().macOsInfo;
      return _Info(device: p.computerName).toString();
    }
    if (Platform.isLinux) {
      final p = await DeviceInfoPlugin().linuxInfo;
      return _Info(device: p.name).toString();
    }
    if (kIsWeb) {
      final p = await DeviceInfoPlugin().webBrowserInfo;
      return _Info(device: p.browserName == BrowserName.unknown ? (p.appName ?? "未知浏览器") : p.browserName.name).toString();
    }
    return _Info(device: Platform.operatingSystem).toString();
  }

  static String getDevice({required String deviceInfo}) => deviceInfo.split(separator).first;
}

class PackageInfoSingle {
  static Future<PackageInfo> info() async {
    return await PackageInfo.fromPlatform();
  }
}
