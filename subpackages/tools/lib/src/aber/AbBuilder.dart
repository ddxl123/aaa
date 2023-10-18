part of aber;

/// 创建一个 AbController 控制器：
/// ```dart
/// class Controller extends AbController {
///   final Ab<int> count = 0.ab;
/// }
/// ```
///
/// 使用一个控制器：
/// ```dart
/// class XXX extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return AbBuilder<Controller>(
///         putController: Controller(),
///         // 可以使用 tag，给 Controller 实例添加一个 tag。
///         tag: tag,
///         builder: (Controller controller, Abw<Controller> abw){
///             return Text(controller.count(abw).toString);
///           }
///       );
///   }
/// }
///
/// /// 在任意地方获取到控制器。
/// void findController() {
///   Aber.find<Controller>(tag: tag);
///   Aber.findOrNull<Controller>(tag: tag);
/// }
///
/// ```
///
/// 如果控制器已被创建过，则直接这样做：
/// ```dart
/// class XXX extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return AbBuilder<Controller>(
///         // 可以使用 tag，这将查找到被对应 tag 标记的 Controller 实例。
///         tag: tag,
///         builder: (Controller controller, Abw<Controller> abw){
///             return Text(controller.count(abw).toString);
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
///     return AbBuilder<OneController>(
///         putController: OneController(),
///         builder: (OneController one, Abw<OneController> oneAbw){
///             return AbBuilder<TwoController>(
///               putController: TwoController(),
///               builder: (TwoController two, Abw<TwoController> twoAbw){
///                   return Column(
///                       children: [
///                           Text(one.count(oneAbw).toString),
///                           Text(two.count(twoAbw).toString),
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
/// [putController] 禁止使用 [Aber.find] 来传递, 只能用构造函数进行创建，会仅使用 [tag] 来查找，
/// 错误写法:
/// ```dart
/// putController: Aber.find<Controller>()
/// ```
///
/// 主要目的是为了保证当前 widget 与当前 controller 的生命周期相对应（比如 initState/dispose）：
///   - 如果在父 [AbBuilder] 中创建了 [putController]，子 [AbBuilder] find 了这个父 [putController],
///   - 那么子 [AbBuilder] 被销毁时，不会将这个父 [putController] 销毁，
///   - 只有在父 [AbBuilder] 被销毁时，才会将这个父 [putController] 销毁。
///   - 也就是说，controller 在 AWidget 中被创建，只有当该 AWidget 被销毁时，它才会被自动销毁。
///
///
/// See also:
///
///   * 将 [tag] 标记为 [Aber.single]，来创建独立的控制器。
class AbBuilder<C extends AbController> extends StatefulWidget {
  const AbBuilder({
    Key? key,
    this.putController,
    this.tag,
    required this.builder,
  }) : super(key: key);

  final C? putController;
  final String? tag;
  final Widget Function(C controller, Abw abw) builder;

  @override
  State<AbBuilder<C>> createState() => _AbBuilderState<C>();
}

class _AbBuilderState<C extends AbController> extends State<AbBuilder<C>> {
  C? _controller;

  late final Abw _abw;

  /// 当前 Widget 所接收的 controller 是否为 put 产生的。
  bool _isPutter = false;

  late final Future<void> _loadingFuture;

  @override
  void initState() {
    super.initState();
    if (widget.tag == Aber.single) {
      if (widget.putController == null) {
        _controller = Aber.findLast<C>();
      } else {
        _controller = null;
      }
    } else {
      _controller = Aber.findOrNull<C>(tag: widget.tag);
    }

    if (_controller == null) {
      if (widget.putController == null) throw 'The ${'$C.${widget.tag ?? ''}'} object not found.';

      _controller = Aber._put<C>(
        widget.putController!,
        tag: widget.tag == Aber.single ? widget.putController!.hashCode.toString() : widget.tag,
      );
      _isPutter = true;
      _controller!.context = context; // 必须放在 onInit 前面
      _controller!.state = this;
      _controller!.thisRefresh = () {
        if (mounted) setState(() {});
      };
      _controller!.onInit(); // 如果被 find 成功，会导致再次调用 onInit，因此只能放在这里，让它只会调用一次。
      _loadingFuture = _controller!.loadingFuture();
    }

    _abw = Abw(refresh, _controller!._removeRefreshFunctions);
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_controller!.abException != null) {
      return _controller!.exceptionWidget(_controller!.abException!);
    }
    return _controller!.isEnableLoading && _isPutter
        ? FutureBuilder(
            future: _loadingFuture,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return _controller!.exceptionWidget(AbException(error: snapshot.error!, stackTrace: snapshot.stackTrace!));
              }
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

  Widget _builderWidget() {
    try {
      return widget.builder(_controller!, _abw);
    } catch (e, st) {
      return _controller!.buildInternalExceptionWidget(AbException(error: e, stackTrace: st));
    }
  }

  @override
  void dispose() {
    _removeRefresh();

    if (_isPutter) {
      _controller!.onDispose();
      Aber._removeController<C>(_controller!);
      _controller = null;
    }

    super.dispose();
  }

  /// 当前 Widget 被移除时，需要同时将所添加过的 [refresh] 函数对象移除掉。
  void _removeRefresh() {
    for (var element in _controller!._removeRefreshFunctions) {
      element(refresh);
    }
  }
}
