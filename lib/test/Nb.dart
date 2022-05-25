import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef RefreshFunction = void Function();
typedef RemoveRefreshFunction = void Function(RefreshFunction);

class Nbw<C extends NbController> {
  Nbw(this._refresh, this._removeRefreshFunctions);

  final RefreshFunction _refresh;
  final Set<RemoveRefreshFunction> _removeRefreshFunctions;
}

class Nb<V> {
  Nb(V initial) {
    _value = initial;
  }

  late V _value;

  /// 存储每个引用该对象的 [NbWidget] 的 [_NbWidgetState.refresh]。
  final Set<RefreshFunction> _refreshFunctions = {};

  /// 当 [NbWidget] 被 dispose 时，会调用这个函数移除曾经添加过的 [_NbWidgetState.refresh]。
  void _removeRefreshFunction(RefreshFunction refresh) => _refreshFunctions.remove(refresh);

  /// 获取 [_value] 并绑定函数。
  ///
  /// 绑定函数的目的：
  ///
  /// 1. 绑定 [_refreshFunctions] :
  ///   将每个引用该对象的 [NbWidget] 内的 [_NbWidgetState.refresh],
  ///   添加到 [_refreshFunctions]中, 供 [update] 使用。
  ///
  /// 2. 绑定 [NbController._removeRefreshFunctions] :
  ///   将当前对象 (每个被.nb 标记的对象) 的 [_removeRefreshFunction]，
  ///   添加到 [NbController._removeRefreshFunctions] 中, 供 [_NbWidgetState.removeRefreshs] 使用。
  ///
  ///
  /// 里面都是 Set 类型，所以不会重复被添加。
  V call<C extends NbController>(Nbw nbw) {
    _refreshFunctions.add(nbw._refresh);
    nbw._removeRefreshFunctions.add(_removeRefreshFunction);
    return _value;
  }

  /// 不推荐使用 [getValue]，推荐使用 [call] 更加简洁！
  V getValue<C extends NbController>(Nbw nbWrapper) => call(nbWrapper);

  /// 修改 [_value] 值，并重建所有引用该对象的 [NbWidget]。
  void update(V newValue) {
    _value = newValue;
    for (var _refreshFunction in _refreshFunctions) {
      _refreshFunction();
    }
  }

  /// [update] 的一种快捷方法。
  ///
  /// oldValue++ 或 oldValue-- 是无法生效的, 应该使用 oldValue+1 或 oldValue-1。
  void updateTo(V Function(V oldValue) valueTo) => update(valueTo(_value));
}

extension NbExt<NB> on NB {
  Nb<NB> get nb => Nb<NB>(this);
}

abstract class NbController {
  /// 存储当前 Controller 对象中所有被 .nb 标记的对象所对应的 [Nb._removeRefreshFunction]。
  ///
  /// 在每个 .nb 属性第一次被引用时，才会把它添加到这里（并不是在初始化时被添加）。
  final Set<RemoveRefreshFunction> _removeRefreshFunctions = {};

  /// [NbWidget] 内部的 initState，只会在 put 时所在的 [NbWidget] 中调用，且只会调用一次。
  void onInit() {}

  /// [NbWidget] 内部的 dispose，只会在 put 时所在的 [NbWidget] 中调用，且只会调用一次。
  void dispose() {}
}

/// 正确用法：
/// ```dart
/// class XXX extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return NbWidget(controller: Controller(),...);
///     // or return NbWidget<Controller>(...); // If Controller is exist.
///   }
/// }
/// ```
///
/// 如果是下面三种方法来 put controller， 则会抛出重复 put 的异常。
/// ```dart
/// class XXX extends StatelessWidget {
///   final Controller controller = Nber.put(Controller());
///
///   @override
///   Widget build(BuildContext context) {
///     return NbWidget(controller: controller,...);
///     // or return NbWidget(controller: Nber.put(Controller()),...);
///     // or return NbWidget(controller: Nber.find<Controller>(),...);
///   }
/// }
///     ...
/// ```
class NbWidget<C extends NbController> extends StatefulWidget {
  const NbWidget({Key? key, required this.controller, required this.builder}) : super(key: key);
  final C? controller;
  final Widget Function(C controller, Nbw<C> nbw) builder;

  @override
  State<NbWidget<C>> createState() => _NbWidgetState<C>();
}

class _NbWidgetState<C extends NbController> extends State<NbWidget<C>> {
  C? _controller;

  /// 当前 Widget 所接收的 controller 是否为 put 产生的。
  bool _isPutter = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller == null
        ? Nber.find<C>()
        : () {
            Nber.put(widget.controller!);
            _isPutter = true;
            // 如果被 find 成功，这会再次调用 onInit，因此只能放在这里调用。
            widget.controller?.onInit();
          }();
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    GetBuilder;
    return widget.builder(_controller!, Nbw(refresh, _controller!._removeRefreshFunctions));
  }

  @override
  void dispose() {
    removeRefreshs();

    if (_isPutter) {
      _controller!.dispose();
      _controller = null;
    }

    //TODO: 销毁controller
    super.dispose();
  }

  /// 当前 Widget 被移除时，需要同时将所添加过的 [refresh] 函数对象移除掉。
  void removeRefreshs() {
    for (var element in _controller!._removeRefreshFunctions) {
      element(refresh);
    }
  }
}

class Nber {
  static final Map<String, NbController> controllers = {};

  static C put<C extends NbController>(C controller, {String? tag}) {
    final String key = C.toString() + (tag ?? '');
    if (controllers.containsKey(key)) throw 'Repeat to add: controller-${C.toString()}, tag-$tag.';
    controllers.addIf(!controllers.containsKey(key), key, controller);
    return controller;
  }

  static C find<C extends NbController>({String? tag}) {
    final String key = C.toString() + (tag ?? '');
    if (!controllers.containsKey(key)) throw 'Not found: controller-${C.toString()}, tag-$tag. You need to Nber.put() first.';
    return controllers[key] as C;
  }
}
