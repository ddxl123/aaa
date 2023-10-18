library aber;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';


part 'Ab.dart';

part 'AbBuilder.dart';

part 'AbController.dart';

part 'Abw.dart';

part 'AbwBuilder.dart';

part 'BrokenExt.dart';

part 'BuildExceptionWidget.dart';

part 'typedef.dart';

part 'AbException.dart';

class Aber {
  const Aber._();

  /// [_createKey] - [AbController]
  static final Map<String, AbController> _controllers = {};

  /// 当在 [AbBuilder] 中将 tag 设为 [single] 时，将创建独立的控制器。
  ///
  /// 可以将 [find] 的 tag 值设置为 [single] ，它将会查找到最后一个被设置为 [single] 的同类型控制器。
  /// 这与 [findLast] 的区别是，[findLast] 会获取同类型的全部控制器中的最后一个控制器，并不单单是被设置为 [single] 的同类型控制器。
  ///
  /// 当将 tag 设为 [single] 时，[key] 将会被设置为 controller 的 hashCode，
  /// 这意味着，当使用 [find] 来查找对应控制器时，必须将其 tag 值设置为对应 [AbController.hashCode] 才能被查找到，否则查找不到。
  ///
  /// 这并不会使 [key] 设置为 [single] 这个字符串，它只是用来作为触发字段。
  static const String single = 'SINGLE_TAG';

  /// 日志输出
  static void debug(String content) {
    // logger.i(content);
  }

  /// 当被 put 的 [AbBuilder] 被销毁时，会将其对应的 [AbController] 移除。（在 [AbBuilder] 的 dispose 中调用）
  static void _removeController<C extends AbController>(C controller) {
    _controllers.removeWhere(
      (key, value) {
        final bool yes = value == controller;
        if (yes) {
          debug('AberInfo: == remove ==》 key:$key hash_code:${value.hashCode}');
        }
        return yes;
      },
    );
  }

  /// 设置 key。
  ///
  /// 格式：'HomeControllerName.tagName', 中间加个 '.' 是为了防止下面情况，
  ///   - 2个控制器及其 tag 名称分别为 `HomeCont.roller` `Home.Controller`, 如果没有 '.' 的存在，它们将是同一个 key。
  static String _createKey<C extends AbController>({String? tag}) => '$C.${tag ?? ''}';

  static C _put<C extends AbController>(C controller, {String? tag}) {
    final String key = _createKey<C>(tag: tag);
    if (_controllers.containsKey(key)) throw 'Repeat to add: $key.';
    _controllers.addAll({key: controller});

    debug('AberInfo: == put ==》 key:$key hash_code:${controller.hashCode}');

    return controller;
  }

  /// 查找需要的 [AbController]。
  static C? findOrNull<C extends AbController>({String? tag, bool isDisableOutputForDebug = false}) {
    final String key = _createKey<C>(tag: tag);
    final c = _controllers[key];

    if (!isDisableOutputForDebug) {
      debug('AberInfo: == findOrNull ==》 key:$key hash_code:${c?.hashCode}');
    }

    return (c is C?) ? c : (throw 'Serious error! The type of controller found does not match! Need-${C.toString()},Found-${c.toString()}');
  }

  /// 查找需要的 [AbController]。
  ///
  /// 没找到会抛出异常。
  static C find<C extends AbController>({String? tag}) {
    final key = _createKey<C>(tag: tag);
    final c = findOrNull<C>(tag: tag, isDisableOutputForDebug: true) ?? (throw 'Not found: $key You need to create a controller with the constructor first.');

    debug('AberInfo: == find ==》 key:$key hash_code:${c.hashCode}');
    return c;
  }

  /// 查找所有 [C] 类型的控制器。
  static List<C> findAll<C extends AbController>({bool isDisableOutputForDebug = false}) {
    final all = _controllers.values.whereType<C>().toList();
    if (!isDisableOutputForDebug) {
      debug('AberInfo: == findAll ==》 type:${C.toString()} count:${all.length})');
    }
    return all;
  }

  /// 查找最近的一个 [C] 类型的控制器。
  ///
  /// 通常配合 [single] 使用。
  ///
  /// 没有找到会抛出异常。
  static C findLast<C extends AbController>() {
    final last = findAll<C>(isDisableOutputForDebug: true).last;
    debug('AberInfo: == findLast ==》 type:${C.toString()} last_hash_code:${last.hashCode}');
    return last;
  }

  /// 查找最近的一个 [C] 类型的控制器。
  ///
  /// 通常配合 [single] 使用。
  ///
  /// 没有找到会返回 null。
  static C? findOrNullLast<C extends AbController>() {
    final all = findAll<C>(isDisableOutputForDebug: true);
    final last = all.isEmpty ? null : all.last;
    debug('AberInfo: == findOrNullLast ==》 type:${C.toString()} hash_code:${last?.hashCode}');
    return last;
  }

  static Map<String, AbController> findAllAny() {
    return _controllers;
  }
}
