import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoSingle {
  static Future<AndroidDeviceInfo> android() async {
    return await DeviceInfoPlugin().androidInfo;
  }
}

class PackageInfoSingle {
  static Future<PackageInfo> info() async {
    return await PackageInfo.fromPlatform();
  }
}
