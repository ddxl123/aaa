import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'LoadAreaController.dart';
import 'SheetRoute.dart';

/// 滚动、触摸方向枚举
enum Direction { idle, up, down }

class Mark {
  int value = 0;
}

/// [D] 是 [SheetPageController.bodyData] 的数据类型。
class SheetPageController<D> extends ChangeNotifier {
  ///

  // =============================================================================

  /// 当前 [SheetRoute]。
  late final SheetRoute<D> sbSheetRoute;

  /// [SbSheetRouteWidget] 中的 context。
  late final BuildContext sheetWidgetContext;

  /// 整个 [SbSheetRouteWidget] 中的 setState。
  late final Function sheetRouteWidgetSetState;

  /// [SheetRoute.headerSliver] 中的 setState。
  late final Function headerSetState;

  /// [SheetRoute.bodySliver] 中的 setState。
  late final Function bodySetState;

  /// [SheetRoute.loadArea] 中的 setState。
  late final Function loadAreaSetState;

  /// pop 方式。
  /// 例如：
  /// ```dart
  /// Navigator.of(sheetWidgetContext).removeRoute(sbSheetRoute);
  /// ```
  /// [removeRoute] 后,会调用 [SheetRoute.dispose]。
  ///
  /// 不能使用 [pop] ,因为当 [SheetRoute] 已被打开时，再打开新的 [SheetRoute] 时， [pop] 的话会把新打开的 [SheetRoute] 给 [pop] 了,而并不会把旧 [SheetRoute] 关闭。
  late final Function popMethod;

  // =============================================================================

  late final Animation<double> animation;

  late final AnimationController animationController;

  // =============================================================================

  /// 内部滑动控制器
  final ScrollController scrollController = ScrollController();

  /// 加载区控制器
  final LoadAreaController loadAreaController = LoadAreaController();

  // =============================================================================

  /// 内部滑动的数据数组
  final List<D> bodyData = <D>[];

  /// 异步标记
  final Mark mark = Mark();

  // =============================================================================

  /// 控制器正放或倒放的总持续时间。
  final Duration controllerDuration = const Duration(milliseconds: 300);

  /// 控制器正放或倒放的动画曲线。
  final Curve controllerCurve = Curves.linear;

  /// 最大高度：屏幕高度-下拉栏高度。
  final double maxHeight = MediaQueryData.fromWindow(window).size.height - MediaQueryData.fromWindow(window).padding.top;

  /// 初始化高度比。范围：0 ~ 1，映射于 0 ~ [maxHeight]。
  final double initHeightRatio = 2 / 3;

  /// 反弹距离比。
  final double reboundRatio = 3 / 4;

  /// [SbSheetRouteWidget] 的圆角半径。
  final double circular = 10.0;

  // =============================================================================

  /// 整个 [SbSheetRouteWidget] 的不透明度。范围：0.0 ~ 1.0 (0.0为全透明，1.0为不透明)。
  double sheetOpacity = 1.0;

  /// 触摸方向。
  Direction touchDirection = Direction.idle;

  /// 内部滚动方向。
  Direction scrollDirection = Direction.idle;

  /// 是否将被移除，防止 [removeRouteWithAnimation] 被同时触发多次
  bool _isRemoving = false;

  /// 是否正处于获取数据状态，防止 [dataLoad] 被同时触发多次
  bool _isDataLoading = false;

  // =============================================================================
  // =============================================================================
  // =============================================================================
  // =============================================================================
  // =============================================================================

  /// 是否能通过 [触摸事件] 来刷新 [SbSheetRouteWidget] 高度。
  bool get canUpdateHeightByTouch => !(_isRemoving || animationController.isAnimating);

  void onPointerDown(PointerDownEvent event) {
    if (!canUpdateHeightByTouch) {
      return;
    }
  }

  void onPointerMove(PointerMoveEvent event) {
    if (!canUpdateHeightByTouch) {
      return;
    }

    // 监听触摸方向，给 [onPointerUp] 使用。
    // 如果 [touchDirection>0.0] 则正在向上滚动,如果 [touchDirection<0.0] 则正在向下滚动。
    touchDirection = event.delta.dy > 0.0 ? Direction.down : (event.delta.dy < 0.0 ? Direction.up : Direction.idle);

    // 1、未满屏时，内部不滑动，外部滑动。
    if (animation.value < maxHeight) {
      animationController.value -= event.delta.dy / maxHeight;
      scrollController.jumpTo(0);
    }

    // 2、满屏时，内部滑动，外部不滑动。
    else if (animation.value >= maxHeight) {
      // 当 [offset <= 0.0] 时，可向下 [touch_move] ，回到 [步骤1] 。
      if (scrollController.offset <= 0.0) {
        animationController.value -= event.delta.dy / maxHeight;
      }
    }

    // 已经在 [addListener] 中 [setState] 了。
  }

  void onPointerUp(PointerUpEvent event) {
    if (!canUpdateHeightByTouch) {
      return;
    }
    // (-∞ , reboundRatio) 范围。
    // initHeightRatio * reboundRatio 表示再 initHeightRatio 的基础上的 reboundRatio。
    if (animationController.value < initHeightRatio * reboundRatio) {
      if (touchDirection == Direction.up) {
        animationController.animateTo(initHeightRatio, duration: const Duration(milliseconds: 300), curve: Curves.easeInOutCirc);
      } else {
        removeRouteWithAnimation();
      }
    }

    // [_reboundRatio , _initHeightRatio) 范围：
    if (animationController.value >= initHeightRatio * reboundRatio && animationController.value < initHeightRatio) {
      animationController.animateTo(initHeightRatio, duration: const Duration(milliseconds: 100), curve: Curves.easeInOutCirc);
    }

    // (_initHeightRatio , 1) 范围：
    if (animationController.value > initHeightRatio && animationController.value != 1) {
      if (touchDirection == Direction.up) {
        animationController.animateTo(1, duration: const Duration(milliseconds: 100), curve: Curves.easeInOutCirc);
      } else {
        animationController.animateTo(initHeightRatio, duration: const Duration(milliseconds: 100), curve: Curves.easeInOutCirc);
      }
    }

    // 已经在 [addListener] 中 [setState] 了。
  }

  // =============================================================================

  void animationControllerAddListener() {
    // 上一次 animationController.value。范围：0 ~ 1。
    double lastAnimationControllerValue = 0.0;

    animationController.addListener(() {
      //
      // 当前滚动方向。
      if (animationController.value > lastAnimationControllerValue) {
        touchDirection = Direction.up;
      } else if (animationController.value < lastAnimationControllerValue) {
        touchDirection = Direction.down;
      } else {
        touchDirection = Direction.idle;
      }
      lastAnimationControllerValue = animationController.value;

      //
      // 低于 initHeightRatio 时，往下滑动透明度变化
      if (animationController.value <= initHeightRatio) {
        sheetOpacity = animationController.value * (1 / initHeightRatio);
      }

      //
      // 处在 [LoadingArea] 且向上滚动时，会触发 loading 操作
      if (animation.value >= scrollController.position.maxScrollExtent && touchDirection == Direction.up) {
        dataLoad();
      }

      sheetRouteWidgetSetState();
    });
  }

  void scrollControllerAddListener() {
    scrollController.addListener(() {
      //
      // 当前滚动方向。非手势滑动方向。
      if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        scrollDirection = Direction.down;
      } else if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        scrollDirection = Direction.up;
      } else {
        scrollDirection = Direction.idle;
      }

      //
      // 处在 [LoadingArea] 且向上滚动时，会触发 loading 操作
      if (maxHeight + scrollController.position.pixels >= scrollController.position.maxScrollExtent && scrollDirection == Direction.up) {
        dataLoad();
      }
    });
  }

  /// 异步加载数据
  Future<void> dataLoad() async {
    if (_isDataLoading) {
      return;
    }
    _isDataLoading = true;

    // 处于正在加载中
    loadAreaController.loadAreaStatus = LoadAreaStatus.loading;
    loadAreaSetState();

    bool isSuccess = false;
    try {
      // TODO: 需要去掉。
      await Future<void>.delayed(const Duration(seconds: 1));
      await sbSheetRoute.bodyDataFuture(bodyData, mark);
      isSuccess = true;
    } catch (e, st) {
      sbSheetRoute.bodyDataException(e, st);
      isSuccess = false;
    }

    if (isSuccess) {
      loadAreaController.loadAreaStatus = LoadAreaStatus.noMore;
      bodySetState();
      loadAreaSetState();
    } else {
      loadAreaController.loadAreaStatus = LoadAreaStatus.failure;
      loadAreaSetState();
    }

    _isDataLoading = false;
  }

  /// 移除当前 route, 同时附带 animation
  void removeRouteWithAnimation() {
    if (!_isRemoving) {
      _isRemoving = true;

      animationController.animateTo(0).whenCompleteOrCancel(() {
        popMethod();
        Navigator.removeRoute(sheetWidgetContext, sbSheetRoute);
      });
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  ///
}
