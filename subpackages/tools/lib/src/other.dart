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

class Tuple2<T1, T2> {
  final T1 t1;
  final T2 t2;

  Tuple2({required this.t1, required this.t2});

  @override
  String toString() => '($t1, $t2)';
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
String? time2TextTime({required int longSeconds}) {
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  final d = Duration(seconds: longSeconds);
  days = d.inDays;
  hours = days == 0 ? d.inHours : d.inHours % 24;
  minutes = hours == 0 ? d.inMinutes : d.inMinutes % 60;
  seconds = minutes == 0 ? d.inSeconds : d.inSeconds % 60;
  final result = '${days == 0 ? '' : '$days天'}${hours == 0 ? '' : '$hours时'}${minutes == 0 ? '' : '$minutes分'}${seconds == 0 ? '' : '$seconds秒'}';
  return result == '' ? null : result;
}

class ExceptionContent {
  final Object error;
  final StackTrace stackTrace;

  ExceptionContent({required this.error, required this.stackTrace});

  @override
  String toString() => '($hashCode=====>>>>>start:\nExceptionContent:\nerror:\n$error\nstackTrace:\n$stackTrace\n:end<<<<<=====$hashCode)\n';
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
    if (newValue == '') throw '添加的元素不能为空字符！';
    if (!trim().contains(RegExp(r'^(\[)(.*)(\])$'))) throw '不能对非数组的字符串添加元素！${this}';
    if (trim() == '[]') return '${split(']').first}$newValue]';
    return '${split(']').first},$newValue]';
  }

  /// 将 '[1,2,3]' 解析成 [1,2,3]。
  List<int> toIntArray() {
    if (!trim().contains(RegExp(r'^(\[)(.*)(\])$'))) throw '不能对非数组的字符串进行 List<int> 转换！${this}';
    if (trim() == '[]') return [];
    return replaceAll(RegExp(r'(\[)|(\])'), '').split(',').map((e) => int.parse(e)).toList();
  }

  /// 将 '[1.1,2.2,3.3]' 解析成 [1.1,2.2,3.3]。
  List<double> toDoubleArray() {
    if (!trim().contains(RegExp(r'^(\[)(.*)(\])$'))) throw '不能对非数组的字符串进行 List<double> 转换！${this}';
    if (trim() == '[]') return [];
    return replaceAll(RegExp(r'(\[)|(\])'), '').split(',').map((e) => double.parse(e)).toList();
  }
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
  String toJson() {
    return json.encode(this);
  }
}
