part of aber;

extension AbExt<V> on V {
  /// 若 value 初始值为 null时，则应该 Ab<?>(null) 这样进行初始化。
  Ab<V> get ab => Ab<V>(this);
}

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
  AbVerify? _verify;

  AbVerify get verify => _verify ?? AbVerify(abV: Ab(null), verifyCallBack: (v) => VerifyResult(isOk: false, message: '未进行 initVerify！'));

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
  ///   添加到 [_refreshFunctions]中, 供 [_refresh] 使用。
  ///
  /// 2. 绑定 [AbController._removeRefreshFunctions] :
  ///   将当前对象 (每个被.ab 标记的对象) 的 [_removeRefreshFunction]，
  ///   添加到 [AbController._removeRefreshFunctions] 中, 供 [_AbBuilderState._removeRefreshs] 使用。
  ///
  /// 里面都是 Set 类型，所以不会重复被添加，即无论连续 xx.call(abw) 的多少次，最终只会存在一个。
  V call([Abw? abw]) {
    if (abw == null) return value;
    _refreshFunctions.add(abw._refresh);
    abw._removeRefreshFunctions.add(_removeRefreshFunction);
    return value;
  }

  /// 重建所有利用 [call] 对当前对象进行引用的，并写入了 [AbBuilder] 相应的 [Abw] 的 [AbBuilder]。
  void _refresh() {
    for (var rf in _refreshFunctions) {
      rf();
    }
  }

  void refreshForce() => _refresh();

  /// 无论 [value] 自身有没有被替换，或者 [value] 这个对象的属性有没有被修改，都会尝试重建。
  ///
  /// 通常，在对 [List]/[Map]/[Set] 进行 add/remove/clear 等必然会重建的修改时使用。
  /// 注意：进行 remove/clear 等操作时，需使用对应的 [ListBrokenExt] 方法，否则需要自行手动进行 [broken]。
  /// 例如：
  /// ```dart
  ///   final list = [].ab;
  ///   list.refreshInevitable((obj)=>obj..clear_(controller));
  /// ```
  ///
  /// 当 [diff] 的返回值与 [value] 不是同一个对象时，[value] 将会被替换掉，并进行重建。
  FutureOr<void> refreshInevitable(FutureOr<V> Function(V obj) diff) async {
    value = await diff(value);
    refreshForce();
  }

  /// 只有 [value] 自身被替换掉时才会尝试重建，而与 [value] 这个对象的属性有没有被修改完全没有关系。
  ///
  /// 通常，在 [value] 为 基本数据类型 时使用。
  ///
  /// 当 [isForce] 为 true，无论修改的值是否相等，都会强制重建。
  FutureOr<void> refreshEasy(FutureOr<V> Function(V oldValue) diff, [bool isForce = false]) async {
    if (V is num || V is String || V is bool) {
      print('Aber-Warning: Modifying values that are not basic data type, '
          'please use the refreshComplex or modify method.');
    }
    final nv = await diff(value);
    if (value != nv || isForce) {
      value = nv;
      _refresh();
    }
  }

  /// 当 [diff] 返回值为 true 时，才会尝试重建。
  ///
  /// 当 [isForce] 为 true，无论修改的值是否相等，都会强制重建。
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
  /// 可以使用 [ListBrokenExt] 等避免手动调用。
  ///
  /// 否则可能会造成内存泄露，因为置空或替换后， [_removeRefreshFunction] 还残留在 [controller] 中。
  void broken<C extends AbController>(C controller) {
    controller._removeRefreshFunctions.remove(_removeRefreshFunction);
  }

  /// 当直接在 Ab 对象上使用 [initVerify] 无法引用其他成员时，可以使用 [AbController.initComplexVerifies]。
  void initVerify(FutureOr<VerifyResult?> Function(Ab<V> abV) verifyCallBack) {
    if (_verify != null) {
      _verify = AbVerify(abV: Ab(null), verifyCallBack: (v) => VerifyResult(isOk: false, message: '进行了多次 initVerify！'));
      return;
    }
    _verify = AbVerify<V>(abV: this, verifyCallBack: verifyCallBack);
  }
}