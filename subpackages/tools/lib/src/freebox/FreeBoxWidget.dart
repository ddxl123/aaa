part of freebox;

class FreeBoxCamera {
  FreeBoxCamera({required this.expectPosition, required this.expectScale});

  /// 期望位置。
  Offset expectPosition;

  /// 期望缩放值。
  double expectScale;

  /// 获取实际位置。
  Offset getActualPosition() => expectPosition - freeBoxTopLeftOffset;

  void changeFrom(FreeBoxCamera freeBoxCamera) {
    expectPosition = freeBoxCamera.expectPosition;
    expectScale = freeBoxCamera.expectScale;
  }
}

/// 移动缩放层所使用的 [Stack]。
class FreeBoxMoveScaleLayerStack extends StatelessWidget {
  const FreeBoxMoveScaleLayerStack({required this.children, Key? key}) : super(key: key);
  final List<FreeBoxMoveScaleLayerPositioned> children;

  @override
  Widget build(BuildContext context) => Stack(children: children);
}

/// 元素在盒子中的定位
class FreeBoxMoveScaleLayerPositioned extends StatelessWidget {
  const FreeBoxMoveScaleLayerPositioned({required this.expectPosition, required this.child, Key? key}) : super(key: key);

  final Offset expectPosition;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: expectPosition.dy + freeBoxTopLeftOffset.dy,
      left: expectPosition.dx + freeBoxTopLeftOffset.dy,
      child: child,
    );
  }
}

/// [left]、[top]、[right]、[bottom] 必须至少有一个不为空，否则会把 [FreeBoxMoveScaleLayerStack] 给遮掩住。
class FreeBoxFixedLayerPositioned extends StatelessWidget {
  const FreeBoxFixedLayerPositioned({
    required this.child,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (left == null && top == null && right == null && bottom == null) ? 0 : left,
      top: top,
      right: right,
      bottom: bottom,
      width: width,
      height: height,
      child: child,
    );
  }
}
