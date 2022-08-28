part of aber;

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
    if (widget.tag == Aber.nearest) {
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
        tag: widget.tag == Aber.nearest ? widget.putController!.hashCode.toString() : widget.tag,
      );
      _isPutter = true;
      _controller!.context = context; // 必须放在 onInit 前面
      _controller!.thisRefresh = () {
        if (mounted) setState(() {});
      };
      _controller!.onInit(); // 如果被 find 成功，会导致再次调用 onInit，因此只能放在这里，让它只会调用一次。
    }

    _abw = Abw(refresh, _controller!._removeRefreshFunctions);
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
              if (snapshot.hasError) {
                _controller!.loadingError(snapshot.error!, snapshot.stackTrace!);
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
