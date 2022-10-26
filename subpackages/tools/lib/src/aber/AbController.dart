part of aber;

abstract class AbController {
  AbController() {
    initComplexVerifies();
  }

  /// 存储当前 Controller 对象中所有被 .ab 标记的对象所对应的 [Ab._removeRefreshFunction]。
  ///
  /// 在每个 .ab 属性第一次被引用时，才会把它添加到这里（并不是在初始化时被添加）。
  final Set<RemoveRefreshFunction> _removeRefreshFunctions = {};

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
  Widget loadingWidget() => const Text('未配置 loading Widget！');

  /// 需要 [isEnableLoading] 为 true。
  void loadingError(Object e, StackTrace st) {
    logger.i('出现 loadingError 未实现！$runtimeType');
  }

  /// 复杂验证的初始化函数。
  ///
  /// 当直接在 Ab 对象上使用 [Ab.initVerify] 无法引用其他成员时，可以在 [initComplexVerifies] 函数内进行 [Ab.initVerify]。
  ///
  /// 同时在 [initComplexVerifies] 内使用 [Ab.initVerify] ，在 Ab 对象上的使用 [Ab.initVerify]，前者将变得无效，因此只能选择一个地方使用。
  ///
  /// 由 [AbController] 的构造函数调用。
  void initComplexVerifies() {}
}
