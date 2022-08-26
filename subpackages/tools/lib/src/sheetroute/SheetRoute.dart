import 'package:flutter/material.dart';

import 'SheetRouteController.dart';
import 'SheetRouteInnerWidget.dart';

/// [D]：[bodyData] 的元素类型
abstract class SheetRoute<D> extends OverlayRoute<Object?> {
  ///

  final SheetPageController<D> sheetPageController = SheetPageController<D>();

  /// 内部滑动的数据数组。每次触发加载区都会触发该异步，并自动 setState。
  ///
  /// [bodyData]：可改变该数组元素（不能改变地址），比如增删改。
  ///
  /// [mark]：对数据源进行标记，以便加载更多时获取到的是 [mark] 为起点之后的数据。
  Future<void> bodyDataFuture(List<D> bodyData, Mark mark);

  void bodyDataException(Object? exception, StackTrace? stackTrace);

  /// [headerSliver]：返回值必须是一个 sliver
  Widget headerSliver();

  /// [bodySliver]：返回值必须是一个 sliver
  Widget bodySliver();

  /// 加载区 Widget。
  Widget loadingWidget();

  Widget noMoreWidget();

  Widget failureWidget();

  /// [pop] 方式。
  void popMethod();

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return <OverlayEntry>[
      OverlayEntry(
        // TODO: 特别关注 [maintainState]！
        maintainState: true,
        builder: (_) {
          return Stack(
            children: <Widget>[
              _backgroundHit(),
              SheetRouteInnerWidget<D>(this),
            ],
          );
        },
      )
    ];
  }

  /// 背景可穿透点击。
  Widget _backgroundHit() {
    return Positioned(
      top: 0,
      child: Container(
        color: null,
        height: double.maxFinite,
        width: double.maxFinite,
      ),
    );
  }

  /// 返回监听:
  /// 当调用 [Navigator.pop] 时，会调用 [didPop] ,该函数中会调用 [NavigatorState] 的 [finalizeRoute] 函数来释放资源(如等待动画完成)。然后再调用route的 [dispose] 函数。
  /// 当调用 [Navigator.removeRoute] 时,会立即调用route的 [dispose] 。
  /// 当前路线是：被 [Navigator.pop] 后不进行任何操作，而是调用了 [removePageWithAnimation] 中的 [Navigator.removeRoute] 。
  /// 若在 [_removeAnimation] 中调用 [Navigator.pop] 则会循环的调用 [removePageWithAnimation] ,当然 [removePageWithAnimation] 中有仅执行一次的判断。
  @override
  // ignore: must_call_super
  bool didPop(Object? result) {
    sheetPageController.removeRouteWithAnimation();
    return false;
  }

  @override
  void dispose() {
    sheetPageController.dispose();
    super.dispose();
  }
}
