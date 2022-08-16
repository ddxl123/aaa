library aber;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

typedef RefreshFunction = void Function();
typedef RemoveRefreshFunction = void Function(RefreshFunction);
typedef MarkRebuildFunction = void Function();

class Ab<V> {
  Ab(V initial) {
    value = initial;
  }

  /// 只获取值，不进行任何操作。
  ///
  /// 建议使用 [call] 方法，即 count()。
  ///
  /// 若想要当前对象被观察，则请调用 [call] 进行引用。
  @protected
  late V value;

  /// 存储每个引用该对象的 [AbBuilder] 的 [_AbBuilderState.refresh]。
  final Set<RefreshFunction> _refreshFunctions = {};

  /// 使用前使用 [initVerify] 进行初始化。
  Verify verify = Verify(vc: null, initIsOk: (vc) => false, failMessage: '未使用 initVerifyCheck 进行初始化！');

  /// 当 [AbBuilder] 被 dispose 时，会调用这个函数移除曾经添加过的 [_AbBuilderState.refresh]。
  void _removeRefreshFunction(RefreshFunction refresh) => _refreshFunctions.remove(refresh);

  /// 当 [AbBuilder] 需要被当前对象监听时调用。
  ///
  /// 当 [abw] 为 null 时，等价于 [value]。
  ///
  /// 绑定函数的目的：
  ///
  /// 1. 绑定 [_refreshFunctions] :
  ///   将每个引用该对象的 [AbBuilder] 内的 [_AbBuilderState.refresh],
  ///   添加到 [_refreshFunctions]中, 供 [_update] 使用。
  ///
  /// 2. 绑定 [AbController._removeRefreshFunctions] :
  ///   将当前对象 (每个被.nb 标记的对象) 的 [_removeRefreshFunction]，
  ///   添加到 [AbController._removeRefreshFunctions] 中, 供 [_AbBuilderState._removeRefreshs] 使用。
  ///
  ///
  /// 里面都是 Set 类型，所以不会重复被添加。
  V call([Abw? abw]) {
    if (abw == null) return value;
    _refreshFunctions.add(abw._refresh);
    abw._removeRefreshFunctions.add(_removeRefreshFunction);
    return value;
  }

  /// 将当前对象标记为将要被重建。
  V mark<C extends AbController>(C controller) {
    controller._marksRebuildFunction.add(_refresh);
    return value;
  }

  /// 重建引用了当前对象的 [get] 的 [AbBuilder]。
  void _refresh() {
    for (var _refreshFunction in _refreshFunctions) {
      _refreshFunction();
    }
  }

  void refreshForce() => _refresh();

  /// 一种快捷方法，无论值有没有被修改，都会进行重建。
  ///
  /// 建议在对 [List]/[Map]/[Set] 进行 add/remove/clear 等必然会重建的修改时使用。
  ///
  /// 注意：remove/clear 建议使用 [ListBrokenExt.removeForAb] 等。
  void refreshInevitable(V Function(V obj) diff) {
    value = diff(value);
    refreshForce();
  }

  /// 当 [value] 为 基本数据类型 时的快捷方案。
  ///
  /// 当 [isForce] 为 true，无论修改的值是否相等，都会强制重建。
  ///
  /// 只会尝试重建引用当前对象的 [AbBuilder]。
  ///
  /// 也可以看 [refreshComplex], 复杂的修改推荐使用 [modify] 或 [modifyComplex] 方案。
  void refreshEasy(V Function(V oldValue) diff, [bool isForce = false]) {
    if (V is num || V is String || V is bool) {
      if (kDebugMode) {
        print('Aber-Warning: Modifying values that are not basic data type, '
            'please use the refreshComplex or modify method.');
      }
    }
    final nv = diff(value);
    if (value != nv || isForce) {
      value = nv;
      _refresh();
    }
  }

  /// 当 [diff] 返回值为 true 时，才会尝试重建。
  ///
  /// 当 [isForce] 为 true，无论修改的值是否相等，都会强制重建。
  ///
  /// 只会尝试重建引用当前对象 [AbBuilder]。
  ///
  /// 也可以看 [refreshEasy], 复杂的修改推荐使用 [modify] 或 [modifyComplex] 方案。
  FutureOr<void> refreshComplex(FutureOr<bool> Function(V obj) diff) async {
    if (await diff(value)) {
      _refresh();
    }
  }

  /// 在当前对象将要被释放前, 需要先执行 [broken]。
  ///
  /// 比如 [Ab] 对象被赋 null 值, 例如
  /// ```dart
  ///   Ab<int>? counts = 10.ab;
  ///   counts.broken(controller);
  ///   counts = null;
  /// ```
  ///
  /// 或是在 list/Map/Set 中被 remove/clear ，例如
  /// ```dart
  ///   List<Ab<int>> list = <Ab<int>>[Ab<int>(10)];
  ///   list.first.broken(controller);
  ///   list.remove(0);
  /// ```
  /// 可以使用 [ListBrokenExt.removeForAb] 等避免手动调用。
  ///
  /// 否则可能会造成内存泄露，因为 [_removeRefreshFunction] 还残留在 [controller] 中。
  void broken<C extends AbController>(C controller) {
    controller._removeRefreshFunctions.remove(_removeRefreshFunction);
  }

  void initVerify({required FutureOr<bool> Function(Ab<V> abV) initIsOk, required String failMessage}) {
    verify = Verify<Ab<V>>(vc: this, initIsOk: initIsOk, failMessage: failMessage);
  }
}

/// list[index] = Ab() 覆盖原有的 Ab 对象时，需要手动对旧对象调用 broken。
///
/// [List.removeWhere] 需要手动调用 [Ab.broken]。
///
/// 也可看 [AbListBrokenExt]。
extension ListBrokenExt on List<Ab> {
  void removeAt_<C extends AbController>(C controller, int index) {
    final element = this[index];
    element.broken(controller);
    removeAt(index);
  }

  bool remove_<C extends AbController>(C controller, Ab? element) {
    element?.broken(controller);
    return remove(element);
  }

  void removeLast_<C extends AbController>(C controller) {
    last.broken(controller);
    removeLast();
  }

  void removeRange_<C extends AbController>(C controller, int start, int end) {
    getRange(start, end).forEach((element) {
      element.broken(controller);
    });

    removeRange(start, end);
  }

  void clear_<C extends AbController>(C controller) {
    forEach((element) {
      element.broken(controller);
    });
    clear();
  }
}

/// 也可看 [ListBrokenExt]。
extension AbListBrokenExt on Ab<List<Ab>> {
  void removeAt_<C extends AbController>(C controller, int index) {
    final element = this()[index];
    element.broken(controller);
    this().removeAt(index);
  }

  bool remove_<C extends AbController>(C controller, Ab? element) {
    element?.broken(controller);
    return this().remove(element);
  }

  void removeLast_<C extends AbController>(C controller) {
    this().last.broken(controller);
    this().removeLast();
  }

  void removeRange_<C extends AbController>(C controller, int start, int end) {
    this().getRange(start, end).forEach((element) {
      element.broken(controller);
    });

    this().removeRange(start, end);
  }

  void clear_<C extends AbController>(C controller) {
    for (var element in this()) {
      element.broken(controller);
    }
    this().clear();
  }

  void clearAndSelf_<C extends AbController>(C controller) {
    clear_(controller);
    broken(controller);
  }
}

/// [Set.removeWhere] 需要手动调用 [Ab.broken]。
///
/// 也可以看 [AbSetBrokenExt]。
extension SetBrokenExt on Set<Ab> {
  bool remove_<C extends AbController>(C controller, Ab? element) {
    element?.broken(controller);
    return remove(element);
  }

  void removeAll_<C extends AbController>(C controller, Iterable<Ab> elements) {
    for (var element in elements) {
      element.broken(controller);
    }
    removeAll(elements);
  }

  void clear_<C extends AbController>(C controller) {
    removeAll_(controller, this);
  }
}

/// 也可以看 [SetBrokenExt]。
extension AbSetBrokenExt on Ab<Set<Ab>> {
  bool remove_<C extends AbController>(C controller, Ab? element) {
    element?.broken(controller);
    return this().remove(element);
  }

  void removeAll_<C extends AbController>(C controller, Iterable<Ab> elements) {
    for (var element in elements) {
      element.broken(controller);
    }
    this().removeAll(elements);
  }

  void clear_<C extends AbController>(C controller) {
    removeAll_(controller, this());
  }

  void clearAndSelf_<C extends AbController>(C controller) {
    clear_(controller);
    broken(controller);
  }
}

/// map[key] = Ab() 覆盖原有的 Ab 对象时，需要手动对旧对象调用 broken。
///
/// [Map.removeWhere] 需要手动调用 [Ab.broken]。
///
/// 也可看 [AbMapBrokenExt]。
extension MapBrokenExt on Map {
  bool remove_<C extends AbController>(C controller, Object? key) {
    final value = this[key];
    if (key is Ab) key.broken(controller);
    if (value is Ab) value.broken(controller);
    return remove(key);
  }

  void clear_<C extends AbController>(C controller) {
    forEach((key, value) {
      if (key is Ab) key.broken(controller);
      if (value is Ab) value.broken(controller);
    });
    clear();
  }
}

/// 也可看 [MapBrokenExt]。
extension AbMapBrokenExt on Ab<Map> {
  bool remove_<C extends AbController>(C controller, Object? key) {
    final value = this()[key];
    if (key is Ab) key.broken(controller);
    if (value is Ab) value.broken(controller);
    return this().remove(key);
  }

  void clear_<C extends AbController>(C controller) {
    this().forEach((key, value) {
      if (key is Ab) key.broken(controller);
      if (value is Ab) value.broken(controller);
    });
    this().clear();
  }

  void clearAndSelf_<C extends AbController>(C controller) {
    clear_(controller);
    broken(controller);
  }
}

extension AbExt<V> on V {
  Ab<V> get ab => Ab<V>(this);
}

abstract class AbController {
  /// 存储当前 Controller 对象中所有被 .ab 标记的对象所对应的 [Ab._removeRefreshFunction]。
  ///
  /// 在每个 .ab 属性第一次被引用时，才会把它添加到这里（并不是在初始化时被添加）。
  final Set<RemoveRefreshFunction> _removeRefreshFunctions = {};

  final Set<MarkRebuildFunction> _marksRebuildFunction = {};

  late final BuildContext context;

  late final void Function() thisRefresh;

  bool get isEnableLoading => false;

  /// [AbBuilder] 内部的 initState，只会在 [Aber._put] 时所在的 [AbBuilder] 中调用，且只会调用一次。
  void onInit() {}

  /// [AbBuilder] 内部的 dispose，只会在 [Aber._put] 时所在的 [AbBuilder] 中调用，且只会调用一次。
  void dispose() {}

  /// 需要 [isEnableLoading] 为 true。
  Future<void> loadingFuture() async {}

  /// 需要 [isEnableLoading] 为 true。
  Widget loadingWidget() => const Text('无加载组件');
}

/// 将 [AbController]/[AbBuilder]/[Ab] 连接起来的重要类。
///
/// 引用的 [Ab] 被标记为 refresh 时, 所传入的 [Abw] 是哪个 [AbBuilder.builder] 产生的，就会使哪个 widget 被重建.
///
/// 例如:
/// ```dart
/// ...
/// return AbBuilder(
///   controller: Controller1(), // 第一次创建控制器
///   builder: (controller1, abw_1) {
///
///        return AbBuilder<Controller1>( // 因为已经创建过需要的控制器了，因此只需查找。
///          builder: (controller_1, abw_2) {
///
///               // 因为 count 所引用的是 abw_2, 因此当 count 被更新时，
///               // 将会自动重建 abw_2 所在的 AbBuilder, 而 abw_1 所在的 AbBuilder 不会被重建。
///               return Text(controller_1.count.get(abw_2).toString());
///        });
///
/// });
/// ...
/// ```
class Abw<C extends AbController> {
  Abw(this._refresh, this._removeRefreshFunctions);

  final RefreshFunction _refresh;
  final Set<RemoveRefreshFunction> _removeRefreshFunctions;
}

///
/// ```dart
/// class Controller extends AbController {
///   final Ab<int> count = 0.ab;
/// }
/// ```
///
/// 创建控制器并使用
/// ```dart
/// class XXX extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return AbBuilder<Controller>(
///         controller: Controller(),
///         tag: tag,
///         builder: (Controller controller, Abw<Controller> abw){
///             return Text(controller.count.get(abw).toString);
///           }
///       );
///   }
/// }
/// ```
///
/// 如果控制器已被创建过，则直接这样做：
/// ```dart
/// class XXX extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return AbBuilder<Controller>(
///         builder: (Controller controller, Abw<Controller> abw){
///             return Text(controller.count.get(abw).toString);
///           }
///       );
///   }
/// }
/// ```
///
/// 如果要使用多个 controller，则可以使用嵌套的方式:
/// ```dart
/// class XXX extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return AbBuilder(
///         controller OneController(),
///         builder: (OneController one, Abw<OneController> oneAbw){
///             return AbBuilder(
///               controller TwoController(),
///               builder: (TwoController two, Abw<TwoController> twoAbw){
///                   return Column(
///                       children: [
///                           Text(one.count.get(oneAbw).toString),
///                           Text(two.count.get(twoAbw).toString),
///                         ]
///                     );
///                 }
///             );
///           }
///       );
///   }
/// }
/// ```
///
/// [putController] 禁止使用 [Aber.find], 只能用构造函数进行创建，例如： controller: Aber.find<Controller>(tag: 'tag')
///
/// 主要目的是为了保证当前 widget 与当前 controller 的生命周期相对应（比如 initState/dispose）：
///   - 如果在父 [AbBuilder] 中创建了 [putController]，子 [AbBuilder] find 了这个父 [putController],
///   - 那么子 [AbBuilder] 被销毁时，不会将这个父 [putController] 销毁，
///   - 只有在父 [AbBuilder] 被销毁时，才会将这个父 [putController] 销毁。
///   - 也就是说，controller 在 AWidget 中被创建，只有当该 AWidget 被销毁时，它才会被自动销毁。
///
class AbBuilder<C extends AbController> extends StatefulWidget {
  const AbBuilder({
    Key? key,
    this.putController,
    this.tag,
    required this.builder,
  }) : super(key: key);

  final C? putController;
  final String? tag;
  final Widget Function(C controller, Abw<C> abw) builder;

  @override
  State<AbBuilder<C>> createState() => _AbBuilderState<C>();
}

class _AbBuilderState<C extends AbController> extends State<AbBuilder<C>> {
  C? _controller;

  late final Abw<C> _abw;

  /// 当前 Widget 所接收的 controller 是否为 put 产生的。
  bool _isPutter = false;

  late final Future<void> _loadingFuture;

  @override
  void initState() {
    super.initState();
    if (widget.tag == Aber.hashCodeTag) {
      if (widget.putController == null) {
        _controller = Aber.findLast<C>();
      } else {
        _controller = null;
      }
    } else {
      _controller = Aber.findOrNull<C>(tag: widget.tag);
    }

    if (_controller == null) {
      if (widget.putController == null) throw 'The ${C.toString() + '.' + (widget.tag ?? '')} object not found.';

      _controller = Aber._put<C>(
        widget.putController!,
        tag: widget.tag == Aber.hashCodeTag ? widget.putController!.hashCode.toString() : widget.tag,
      );
      _isPutter = true;
      _controller!.context = context; // 必须放在 onInit 前面
      _controller!.thisRefresh = () {
        if (mounted) setState(() {});
      };
      _controller!.onInit(); // 如果被 find 成功，会导致再次调用 onInit，因此只能放在这里，让它只会调用一次。
    }

    _abw = Abw<C>(refresh, _controller!._removeRefreshFunctions);
    _loadingFuture = _controller!.loadingFuture();
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _controller!.isEnableLoading && _isPutter
        ? FutureBuilder(
            future: _loadingFuture,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _controller!.loadingWidget();
              } else if (snapshot.connectionState == ConnectionState.done) {
                return _builderWidget();
              } else {
                return const Text('快照异常');
              }
            },
          )
        : _builderWidget();
  }

  Widget _builderWidget() => widget.builder(_controller!, _abw);

  @override
  void dispose() {
    _removeRefreshs();

    if (_isPutter) {
      _controller!.dispose();
      Aber._removeController<C>(_controller!);
      _controller = null;
    }

    super.dispose();
  }

  /// 当前 Widget 被移除时，需要同时将所添加过的 [refresh] 函数对象移除掉。
  void _removeRefreshs() {
    for (var element in _controller!._removeRefreshFunctions) {
      element(refresh);
    }
  }
}

class Aber {
  const Aber._();

  /// [_createKey] - [AbController]
  static final Map<String, AbController> _controllers = {};

  /// 当将 tag 设为 [hashCodeTag] 时，[key] 将会被设置为 controller 的 hashCode。
  ///
  /// 当使用 [find] 来查找对应控制器时，可以将其 tag 值设置为对应 [AbController.hashCode]。
  ///
  /// 也可以将 [find] 的 tag 值设置为 [hashCodeTag] 来查找最近一个相同类型的控制器。
  ///
  /// 这并不会使 [key] 设置为 [hashCodeTag] 这个字符串，它只是用来作为触发字段。
  static const String hashCodeTag = 'HASH_CODE_TAG';

  /// 当被 put 的 [AbBuilder] 被销毁时，会将其对应的 [AbController] 移除。（在 [AbBuilder] 的 dispose 中调用）
  static void _removeController<C extends AbController>(C controller) {
    _controllers.removeWhere(
      (key, value) {
        final bool yes = value == controller;
        if (yes) {
          Helper.logger.i('===== 》 AberInfo:  remove $key  |  $value (${value.hashCode})');
        }
        return yes;
      },
    );
  }

  /// 设置 key。
  ///
  /// 格式：'HomeControllerName.tagName', 中间加个 '.' 是为了防止下面情况，
  ///   - 2个控制器及其 tag 名称分别为 `HomeCont.roller` `Home.Controller`, 如果没有 '.' 的存在，它们将是同一个 key。
  static String _createKey<C extends AbController>({String? tag}) => C.toString() + '.' + (tag ?? '');

  static C _put<C extends AbController>(C controller, {String? tag}) {
    final String key = _createKey<C>(tag: tag);
    if (_controllers.containsKey(key)) throw 'Repeat to add: $key.';
    _controllers.addAll({key: controller});

    Helper.logger.i('===== 》 AberInfo:  put $key  |  $controller (${controller.hashCode})');

    return controller;
  }

  /// 查找需要的 [AbController]。
  static C? findOrNull<C extends AbController>({String? tag}) {
    final String key = _createKey<C>(tag: tag);
    final c = _controllers[key];
    return (c is C?) ? c : (throw 'Serious error! The type of controller found does not match! Need-${C.toString()},Found-${c.toString()}');
  }

  /// 查找需要的 [AbController]。
  ///
  /// 没找到会抛出异常。
  static C find<C extends AbController>({String? tag}) =>
      findOrNull<C>(tag: tag) ?? (throw 'Not found: ${_createKey<C>(tag: tag)}. You need to create a controller with the constructor first.');

  /// 查找所有 [C] 类型的控制器。
  static List<C> findAll<C extends AbController>() => _controllers.values.whereType<C>().toList();

  /// 查找最近的一个 [C] 类型的控制器。
  ///
  /// 通常配合 [hashCodeTag] 使用。
  ///
  /// 没有找到会抛出异常。
  static C findLast<C extends AbController>() => findAll<C>().last;

  /// 查找最近的一个 [C] 类型的控制器。
  ///
  /// 通常配合 [hashCodeTag] 使用。
  ///
  /// 没有找到会返回 null。
  static C? findOrNullLast<C extends AbController>() {
    final all = findAll<C>();
    return all.isEmpty ? null : all.last;
  }
}

class AbStatefulBuilder extends StatefulWidget {
  const AbStatefulBuilder({
    Key? key,
    this.initExtra,
    this.onInit,
    this.onReady,
    required this.builder,
    this.onDispose,
  }) : super(key: key);

  final Map<String, Object?>? initExtra;

  final void Function(Map<String, Object?> extra, BuildContext context, void Function() refresh)? onInit;
  final void Function(Map<String, Object?> extra, BuildContext context, void Function() refresh)? onReady;
  final Widget Function(Map<String, Object?> extra, BuildContext context, void Function() refresh) builder;
  final void Function(Map<String, Object?> extra, BuildContext context, void Function() refresh)? onDispose;

  @override
  State<AbStatefulBuilder> createState() => _AbStatefulBuilderState();
}

class _AbStatefulBuilderState extends State<AbStatefulBuilder> {
  final Map<String, Object?> extra = {};

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    extra.addAll(widget.initExtra ?? {});
    widget.onInit?.call(extra, context, refresh);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onReady?.call(extra, context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(extra, context, refresh);
  }

  @override
  void dispose() {
    widget.onDispose?.call(extra, context, refresh);
    super.dispose();
  }
}
