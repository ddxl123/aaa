import 'package:flutter/material.dart';

import 'StatefulInitBuilder.dart';
import 'LoadAreaWidget.dart';
import 'SheetRoute.dart';
import 'SheetRouteController.dart';

class SheetRouteInnerWidget<T> extends StatefulWidget {
  const SheetRouteInnerWidget(this.sbSheetPage, {Key? key}) : super(key: key);

  final SheetRoute<T> sbSheetPage;

  @override
  _SheetRouteInnerWidgetState<T> createState() => _SheetRouteInnerWidgetState<T>();
}

class _SheetRouteInnerWidgetState<T> extends State<SheetRouteInnerWidget<T>> with SingleTickerProviderStateMixin {
  ///

  late final SheetPageController<T> sheetPageController;

  @override
  void initState() {
    super.initState();

    sheetPageController = widget.sbSheetPage.sheetPageController;

    sheetPageController.sbSheetRoute = widget.sbSheetPage;

    sheetPageController.sheetWidgetContext = context;

    sheetPageController.sheetRouteWidgetSetState = () {
      if (mounted) {
        setState(() {});
      }
    };

    sheetPageController.loadAreaController.loadingWidget = widget.sbSheetPage.loadingWidget;
    sheetPageController.loadAreaController.noMoreWidget = widget.sbSheetPage.noMoreWidget;
    sheetPageController.loadAreaController.failureWidget = widget.sbSheetPage.failureWidget;

    sheetPageController.popMethod = widget.sbSheetPage.popMethod;

    // 创建动画控制器。
    sheetPageController.animationController = AnimationController(duration: sheetPageController.controllerDuration, vsync: this);

    // 创建 [曲线特性] ，并附着于动画控制器上。
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: widget.sbSheetPage.sheetPageController.animationController,
      curve: sheetPageController.controllerCurve,
    );

    // 创建 [实际数值被限制在 0.0 ~ maxHeight 之间] 的特性，并附着在 [曲线特性上]。
    final Animation<double> tweenAnimation = Tween<double>(
      begin: 0.0,
      end: widget.sbSheetPage.sheetPageController.maxHeight,
    ).animate(curvedAnimation);

    // 获取整条附着链的 [动画片段]，该 [动画片段] 由 [动画控制器] 进行控制。
    sheetPageController.animation = tweenAnimation;

    WidgetsBinding.instance.addPostFrameCallback(
      (Duration timeStamp) {
        // 利用 [动画控制器] 执行初始化上升。
        sheetPageController.animationController.animateTo(sheetPageController.initHeightRatio);

        // 添加监听。
        sheetPageController.animationControllerAddListener();
        sheetPageController.scrollControllerAddListener();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      height: sheetPageController.animation.value,
      width: MediaQuery.of(context).size.width,
      child: Listener(
        onPointerDown: sheetPageController.onPointerDown,
        onPointerMove: sheetPageController.onPointerMove,
        onPointerUp: sheetPageController.onPointerUp,

        //
        child: Material(
          // 使得圆角处透明显示。
          type: MaterialType.transparency,
          child: Opacity(
            // 整体透明度。
            opacity: sheetPageController.sheetOpacity,
            child: ClipRRect(
              // 圆角。
              borderRadius: BorderRadius.circular(sheetPageController.circular),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                controller: sheetPageController.scrollController,
                slivers: <Widget>[
                  headerStateful(),
                  bodyStateful(),
                  loadArea(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// [headerSliver] 位置的 widget
  Widget headerStateful() {
    return StatefulInitBuilder(
      onInit: (StatefulInitBuilderState state) {
        sheetPageController.headerSetState = state.refresh;
      },
      builder: (State state) {
        return widget.sbSheetPage.headerSliver();
      },
    );
  }

  /// [bodySliver] 位置的 widget
  Widget bodyStateful() {
    return StatefulInitBuilder(
      onInit: (StatefulInitBuilderState state) {
        sheetPageController.bodySetState = state.refresh;
      },
      builder: (State state) {
        return widget.sbSheetPage.bodySliver();
      },
    );
  }

  /// [loadArea] 位置的 widget
  Widget loadArea() {
    return StatefulInitBuilder(
      onInit: (StatefulInitBuilderState state) {
        sheetPageController.loadAreaSetState = state.refresh;
      },
      builder: (State state) {
        return LoadAreaWidget<T>(sheetPageController.loadAreaController);
      },
    );
  }
}
