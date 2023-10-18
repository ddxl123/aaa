part of aber;

/// [Aber]、[AbBuilder]
abstract class AbController {
  /// 存储当前 Controller 对象中所有被 .ab 标记的对象所对应的 [Ab._removeRefreshFunction]。
  ///
  /// 在每个 .ab 属性第一次被引用时，才会把它添加到这里（并不是在初始化时被添加）。
  final Set<RemoveRefreshFunction> _removeRefreshFunctions = {};

  late final BuildContext context;

  late final State state;

  /// 刷新整个被当前 controller 修饰的 widget。
  late final void Function() thisRefresh;

  AbException? abException;

  /// 如果启用，会有加载过渡。
  bool get isEnableLoading => false;

  void changeToExceptionWidget({required AbException abException}) {
    this.abException = abException;
    thisRefresh();
  }

  /// [AbBuilder] 内部的 initState，只会在 [Aber._put] 时所在的 [AbBuilder] 中调用，且只会调用一次。
  @mustCallSuper
  void onInit() {
    BackButtonInterceptor.add(_backListener, context: context);
  }

  /// [AbBuilder] 内部的 dispose，只会在 [Aber._put] 时所在的 [AbBuilder] 中调用，且只会调用一次。
  void onDispose() {
    BackButtonInterceptor.remove(_backListener);
    _removeRefreshFunctions.clear();
  }

  Future<void> abBack() async {
    await BackButtonInterceptor.popRoute();
  }

  /// 返回 true，则不触发 pop。
  /// 返回 false，则触发 pop。
  ///
  /// 对物理返回键、[abBack] 有效，对 [Navigator.pop] 无效，因此使用 [abBack] 代替 [Navigator.pop]。
  Future<bool> _backListener(bool stopDefaultButtonEvent, RouteInfo routeInfo) async {
    // 如果一个对话框(或任何其他路由)是打开的。
    var hasRoute = false;
    if (context.mounted) {
      hasRoute = routeInfo.ifRouteChanged(context);
    }
    return await backListener(hasRoute);
  }

  Future<bool> backListener(bool hasRoute) async => false;

  /// 需要 [isEnableLoading] 为 true 时才会被触发。
  Future<void> loadingFuture() async {}

  /// 需要 [isEnableLoading] 为 true 时才会被触发。
  Widget loadingWidget() => const Text('未配置 loading Widget！');

  /// 需要 [isEnableLoading] 为 true 时才可能会被触发。
  ///
  /// 会提供 [error] 和 [stackTrace]
  Widget exceptionWidget(AbException exceptionContent) => BuildExceptionWidget(
        title: '加载出现异常！',
        exceptionContent: exceptionContent,
        logCallback: (title, ec) {
          logger.outError(show: title, print: title, error: ec.error, stackTrace: ec.stackTrace);
        },
      );

  Widget buildInternalExceptionWidget(AbException exceptionContent) => BuildExceptionWidget(
        title: '内部构建异常！',
        exceptionContent: exceptionContent,
        logCallback: (title, ec) {
          logger.outError(show: title, print: title, error: ec.error, stackTrace: ec.stackTrace);
        },
      );
}
