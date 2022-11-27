part of aber;

/// list[index] = Ab() 覆盖原有的 Ab 对象时，需要手动对旧对象调用 broken。
///
/// [List.removeWhere] 需要手动调用 [Ab.broken]。
///
/// 也可看 [AbListBrokenExt]。
extension ListBrokenExt on List<Ab> {
  void removeAtBroken<C extends AbController>(C controller, int index) {
    final element = this[index];
    element.broken(controller);
    removeAt(index);
  }

  bool removeBroken<C extends AbController>(C controller, Ab? element) {
    element?.broken(controller);
    return remove(element);
  }

  void removeLastBroken<C extends AbController>(C controller) {
    last.broken(controller);
    removeLast();
  }

  void removeRangeBroken<C extends AbController>(C controller, int start, int end) {
    getRange(start, end).forEach((element) {
      element.broken(controller);
    });

    removeRange(start, end);
  }

  void clearBroken<C extends AbController>(C controller) {
    forEach((element) {
      element.broken(controller);
    });
    clear();
  }
}

/// 也可看 [ListBrokenExt]。
extension AbListBrokenExt on Ab<List<Ab>> {
  void removeAtBroken<C extends AbController>(C controller, int index) {
    final element = this()[index];
    element.broken(controller);
    this().removeAt(index);
  }

  bool removeBroken<C extends AbController>(C controller, Ab? element) {
    element?.broken(controller);
    return this().remove(element);
  }

  void removeLastBroken<C extends AbController>(C controller) {
    this().last.broken(controller);
    this().removeLast();
  }

  void removeRangeBroken<C extends AbController>(C controller, int start, int end) {
    this().getRange(start, end).forEach((element) {
      element.broken(controller);
    });

    this().removeRange(start, end);
  }

  void clearBroken<C extends AbController>(C controller) {
    for (var element in this()) {
      element.broken(controller);
    }
    this().clear();
  }

  void clearAndSelfBroken<C extends AbController>(C controller) {
    clearBroken(controller);
    broken(controller);
  }
}

/// [Set.removeWhere] 需要手动调用 [Ab.broken]。
///
/// 也可以看 [AbSetBrokenExt]。
extension SetBrokenExt on Set<Ab> {
  bool removeBroken<C extends AbController>(C controller, Ab? element) {
    element?.broken(controller);
    return remove(element);
  }

  void removeAllBroken<C extends AbController>(C controller, Iterable<Ab> elements) {
    for (var element in elements) {
      element.broken(controller);
    }
    removeAll(elements);
  }

  void clearBroken<C extends AbController>(C controller) {
    removeAllBroken(controller, this);
  }
}

/// 也可以看 [SetBrokenExt]。
extension AbSetBrokenExt on Ab<Set<Ab>> {
  bool removeBroken<C extends AbController>(C controller, Ab? element) {
    element?.broken(controller);
    return this().remove(element);
  }

  void removeAllBroken<C extends AbController>(C controller, Iterable<Ab> elements) {
    for (var element in elements) {
      element.broken(controller);
    }
    this().removeAll(elements);
  }

  void clearBroken<C extends AbController>(C controller) {
    removeAllBroken(controller, this());
  }

  void clearAndSelfBroken<C extends AbController>(C controller) {
    clearBroken(controller);
    broken(controller);
  }
}

/// map[key] = Ab() 覆盖原有的 Ab 对象时，需要手动对旧对象调用 broken。
///
/// [Map.removeWhere] 需要手动调用 [Ab.broken]。
///
/// 也可看 [AbMapBrokenExt]。
extension MapBrokenExt on Map {
  bool removeBroken<C extends AbController>(C controller, Object? key) {
    final value = this[key];
    if (key is Ab) key.broken(controller);
    if (value is Ab) value.broken(controller);
    return remove(key);
  }

  void clearBroken<C extends AbController>(C controller) {
    forEach((key, value) {
      if (key is Ab) key.broken(controller);
      if (value is Ab) value.broken(controller);
    });
    clear();
  }
}

/// 也可看 [MapBrokenExt]。
extension AbMapBrokenExt on Ab<Map> {
  bool removeBroken<C extends AbController>(C controller, Object? key) {
    final value = this()[key];
    if (key is Ab) key.broken(controller);
    if (value is Ab) value.broken(controller);
    return this().remove(key);
  }

  void clearBroken<C extends AbController>(C controller) {
    this().forEach((key, value) {
      if (key is Ab) key.broken(controller);
      if (value is Ab) value.broken(controller);
    });
    this().clear();
  }

  void clearAndSelfBroken<C extends AbController>(C controller) {
    clearBroken(controller);
    broken(controller);
  }
}
