part of aber;

mixin AbBroken {
  void broken(AbController c);
}

extension AbExt<V> on V {
  /// 若 value 初始值为 null时，则应该 Ab<?>(null) 这样进行初始化。
  Ab<V> get ab => Ab<V>(this);
}

extension AbBool on Ab<bool> {
  bool isAbTrue([Abw? abw]) => this(abw) == true;

  bool isAbFalse([Abw? abw]) => this(abw) == false;
}

class Ab<V> {
  /// 当 [V] 的默认值为 null 时，
  /// 应使用 final count = Ab<int?>(null) 方式来初始化，
  /// 而不能使用 final count = null.ab 方式。
  /// 因为 null.ab 可能无法识别到 XX? 到底是什么类型。
  Ab(V initial) {
    value = initial;
  }

  /// 对 [value] 进行延迟初始化。
  Ab.late();

  /// 只获取值，不进行任何操作。
  ///
  /// 建议使用 [call] 方法，即 count()。
  ///
  /// 若想要当前对象被观察，则请调用 [call] 进行引用。
  @protected
  late V value;

  /// 存储每个引用该对象的 [AbBuilder] 的 [_AbBuilderState.refresh]。
  final Set<RefreshFunction> _refreshFunctions = {};

  /// 当使用 [Ab.late] 进行对象的创建时，需要使用 [lateAssign] 对其进行第一次分配，
  /// 分配后会自动 refresh。
  ///
  /// 等价于直接 [value] = [v]。
  void lateAssign(V v) {
    value = v;
  }

  /// 对 [V] 为可空类型时的判断的快捷方法。
  ///
  /// [V] 为可空类型时，也可以使用 [call] == null 进行判断。
  ///
  /// 若 [V] 为不可空类型，则始终返回 true。
  bool isAbEmpty([Abw? abw]) => call(abw) == null ? true : false;

  bool isAbNotEmpty([Abw? abw]) => !isAbEmpty(abw);

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
    _refreshFunctions.add(abw.refresh);
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
  void refreshInevitable(V Function(V obj) diff) {
    try {
      value = diff(value);
      refreshForce();
    } catch (e) {
      if (e.toString().contains("LateInitializationError")) {
        throw "使用 Ab.late() 进行创建 Ab 对象时，需要使用 lateAssign 进行初始化赋值！";
      }
      rethrow;
    }
  }

  /// 只有 [value] 自身被替换掉时才会尝试重建，而与 [value] 这个对象的属性有没有被修改完全没有关系。
  ///
  /// 通常，在 [value] 为 基本数据类型 时使用。
  ///
  /// 当 [isForce] 为 true，无论修改的值是否相等，都会强制重建。
  void refreshEasy(V Function(V oldValue) diff, [bool isForce = false]) {
    if (V is Map || V is Iterable) {
      debugPrint('Aber-Warning: Modifying values that are not basic data type, '
          'please use the refreshComplex or refreshInevitable method.');
    }
    try {
      final nv = diff(value);
      if (value != nv || isForce) {
        value = nv;
        _refresh();
      }
    } catch (e) {
      if (e.toString().contains("LateInitializationError")) {
        throw "使用 Ab.late() 进行创建 Ab 对象时，需要使用 lateAssign 进行初始化赋值！";
      }
      rethrow;
    }
  }

  /// 当 [diff] 返回值为 true 时，才会尝试重建。
  ///
  /// 当 [isForce] 为 true，无论修改的值是否相等，都会强制重建。
  void refreshComplex(bool Function(V obj) diff) {
    try {
      if (diff(value)) {
        _refresh();
      }
    } catch (e) {
      if (e.toString().contains("LateInitializationError")) {
        throw "使用 Ab.late() 进行创建 Ab 对象时，需要使用 lateAssign 进行初始化赋值！";
      }
      rethrow;
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
    if (value is AbBroken) {
      // TODO: 检查是否真的被 broken。
      (value as AbBroken).broken(controller);
    }
    controller._removeRefreshFunctions.remove(_removeRefreshFunction);
  }
}
