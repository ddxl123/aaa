import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

String get uuidV4 => _uuid.v4();

CustomLogger logger = CustomLogger();

enum LogLevel {
  normal,
  error,
}

class CustomLogger {
  final logger = Logger(printer: PrettyPrinter(methodCount: 1, errorMethodCount: 50));

  /// [show] - toast 内容。
  ///
  /// [print] - 控制台打印内容。
  void _out({
    dynamic show,
    dynamic print,
    // required String? record,
    LogLevel level = LogLevel.normal,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (show != null) SmartDialog.showToast(show.toString());
    if (print != null || error != null) {
      final outStackTrace = RegExp(r"(#2[\s\S]*(?=(\n#3)))|(#2[\s\S]*(?=(\n)))").stringMatch(StackTrace.current.toString());
      if (level == LogLevel.normal) {
        logger.d('show - $show\nprint - $print\nfromStackStrace:\n$outStackTrace', error, stackTrace);
      } else if (level == LogLevel.error) {
        logger.e('show - $show\nprint - $print\nfromStackStrace:\n$outStackTrace', error, stackTrace);
      } else {
        logger.e('未处理 logger.level: $level');
      }
    }
  }

  void outNormal({
    dynamic show,
    dynamic print,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _out(show: show, print: print, error: error, stackTrace: stackTrace, level: LogLevel.normal);
  }

  void outError({
    dynamic show,
    dynamic print,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _out(show: show, print: print, error: error, stackTrace: stackTrace, level: LogLevel.error);
  }
}

extension QuickLog<T> on T {
  T quickPrint({
    dynamic error,
    StackTrace? stackTrace,
  }) {
    logger.outNormal(print: this, error: error, stackTrace: stackTrace);
    return this;
  }
}

/// ===
/// TODO: 在函数未调用玩前，函数不能再被调用，除非函数调用完成。
/// 创建一个全局 map
/// ===

/// 如果 [body] 函数抛出了异常，则可以通过 [rollback] 函数进行回滚。
///
/// 注意：异常仍然会向上层 rethrow。
///
/// 如果捕获到了 [body] 函数的异常，则会先执行 [rollback] 函数后进行 rethrow，并传递给 [Catcher] 进行处理。
/// 也就是说，就算 [body] 函数发生了异常，也会执行 [rollback] 函数。
///
/// 返回值只接收 [body] 的返回值。
FutureOr<T> catchRollback<T>({
  required FutureOr<T> Function() body,
  required FutureOr<String?> Function() rollback,
}) async {
  try {
    return await body();
  } catch (e) {
    String? tag = await rollback();
    rethrow;
  }
}

extension TccExt on String {
  /// 把 UserInfos 转成 userInfos。
  String get toCamelCase => this[0].toLowerCase() + substring(1, length);
}

/// [target]减[start] 的时间差，返回单位秒。
int timeDifference({required DateTime target, required DateTime start}) {
  return target.difference(start).inSeconds;
}

/// x秒 转换成 x天x时x分x秒。
///
/// 例如，601秒 转化成 1时0分1秒。
String time2TextTime({required int longSeconds}) {
  // 如果参数小于0，抛出异常
  if (longSeconds < 0) {
    throw ArgumentError('longSeconds must be non-negative');
  }
  // 计算年、月、天、小时、分钟和秒数
  // 假设一个月有30天，也就是2592000秒
  // 假设一年有365天，也就是31536000秒
  int years = longSeconds ~/ 31536000; // 整除运算符
  int months = (longSeconds % 31536000) ~/ 2592000; // 取余运算符
  int days = (longSeconds % 2592000) ~/ 86400; // 取余运算符，一天有86400秒
  int hours = (longSeconds % 86400) ~/ 3600; // 取余运算符，一小时有3600秒
  int minutes = (longSeconds % 3600) ~/ 60;
  int seconds = longSeconds % 60;
  // 根据条件拼接字符串
  String result = '';
  if (years > 0) {
    result += '${years}年'; // 字符串插值
    result += months > 0 ? '${months}月' : '';
    return result;
  }
  if (months > 0) {
    result += '${months}月';
    result += days > 0 ? '${days}天' : '';
    return result;
  }
  if (days > 0) {
    result += '${days}天';
    result += hours > 0 ? '${hours}时' : '';
    return result;
  }
  if (hours > 0) {
    result += '${hours}时';
    result += minutes > 0 ? '${minutes}分' : '';
    return result;
  }
  if (minutes > 0) {
    result += '${minutes}分';
    result += seconds > 0 ? '${seconds}秒' : '';
    return result;
  }
  if (seconds > 0) {
    result += '${seconds}秒';
    return result;
  }

  return '0秒';
}

/// 若 [bs] 全为 true，则返回 true。
bool boolAllTrue(List<bool> bs) {
  return !bs.contains(false);
}

/// 若 [bs] 全为 false，则返回 false。
bool boolAllFalse(List<bool> bs) {
  return !bs.contains(true);
}

/// 若 [bs] 存在 true，则返回 true。
bool boolExistTrue(List<bool> bs) {
  return bs.contains(true);
}

/// 若 [bs] 存在 false，则返回 false。
bool boolExistFalse(List<bool> bs) {
  return bs.contains(false);
}

extension ArrayStringInsert on String {
  /// 添加 [newValue] 到 '[1,2,3]' 中。
  String arrayAdd<T>(T newValue) {
    return jsonEncode((jsonDecode(this) as List<dynamic>)..add(newValue));
  }
}

List<T> strToList<T>(String str) {
  return (jsonDecode(str) as List<dynamic>).cast<T>();
}

VisualDensity get kMinVisualDensity => const VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity);

extension StringToJson on String {
  /// 基本类型数组字符串转换成数组对象。
  List<E> jsonToArray<E>() {
    if (this.trim() == "") {
      return [];
    }
    return json.decode(this) as List<E>;
  }
}

extension ArrayToJson on List {
  // TODO:
  String toJson() {
    return json.encode(this);
  }
}

extension ContainReturn<A, B> on Map<A, B> {
  B? containReturn(A a) {
    return containsKey(a) ? this[a] : null;
  }
}

extension EnumExt on Enum {
  /// 只要 [list] 中存在一个与 [this] 相同的，则返回 ture。
  bool isOrTrue<E>(List<E> list) {
    return list.any((element) => element == this);
  }
}
