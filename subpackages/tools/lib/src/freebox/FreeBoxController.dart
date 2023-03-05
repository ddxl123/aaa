part of freebox;

class FreeBoxController {
  FreeBoxController({
    this.isKeepCameraState = false,
  });

  /// 当前相机
  FreeBoxCamera freeBoxCamera = FreeBoxCamera(expectPosition: Offset.zero, expectScale: 1);

  void Function()? freeBoxSetState;

  AnimationController? animationController;

  /// 有关位置的动画片段。
  Animation<Offset>? _positionAnimation;

  /// 有关缩放的动画片段。
  Animation<double>? _scaleAnimation;

  /// 有关缩放的变换标记。
  double _lastTempScale = 1;

  /// 有关位置的缩放标记。
  Offset _lastTempTouchPosition = Offset.zero;

  /// 当 [FreeBox] 被 [dispose] 时，是否仍然保持 [FreeBoxCamera] 的状态。
  bool isKeepCameraState;

  void dispose() {
    if (!isKeepCameraState) {
      freeBoxCamera
        ..expectPosition = Offset.zero
        ..expectScale = 1;
    }
    freeBoxSetState = null;
    animationController?.dispose();
    animationController = null;
    _positionAnimation = null;
    _scaleAnimation = null;
    _lastTempScale = 1;
    _lastTempTouchPosition = Offset.zero;
  }

  void onScaleStart(ScaleStartDetails details) {
    animationController!.stop();

    /// 重置上一次 [临时缩放] 和 [临时触摸位置]
    _lastTempScale = 1;
    _lastTempTouchPosition = details.localFocalPoint;

    freeBoxSetState?.call();
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    /// 进行缩放
    final double deltaScale = details.scale - _lastTempScale;
    freeBoxCamera.expectScale *= 1 + deltaScale;

    /// 缩放后的位置偏移
    final Offset pivotDeltaOffset = (freeBoxCamera.getActualPosition() - details.localFocalPoint) * deltaScale;
    freeBoxCamera.expectPosition += pivotDeltaOffset;

    /// 非缩放的位置偏移
    final Offset deltaOffset = details.localFocalPoint - _lastTempTouchPosition;
    freeBoxCamera.expectPosition += deltaOffset;

    /// 变换上一次 [临时缩放] 和 [临时触摸位置]
    _lastTempScale = details.scale;
    _lastTempTouchPosition = details.localFocalPoint;

    freeBoxSetState?.call();
  }

  void onScaleEnd(ScaleEndDetails details) {
    _inertialSlide(details);
  }

  /// 惯性滑动
  void _inertialSlide(ScaleEndDetails details) {
    animationController!.duration = const Duration(milliseconds: 500);

    _positionAnimation = animationController!
        .drive(
          CurveTween(curve: Curves.easeOutCubic),
        )
        .drive(
          Tween<Offset>(
            begin: freeBoxCamera.expectPosition,
            end: freeBoxCamera.expectPosition + Offset(details.velocity.pixelsPerSecond.dx / 10, details.velocity.pixelsPerSecond.dy / 10),
          ),
        );

    animationController!.forward(from: 0.0);
    animationController!.addListener(_inertialSlideListener);
  }

  /// 惯性滑动监听
  void _inertialSlideListener() {
    freeBoxCamera.expectPosition = _positionAnimation!.value;

    /// 被 stop() 或 动画播放完成 时, removeListener()
    if (animationController!.isDismissed || animationController!.isCompleted) {
      animationController!.removeListener(_inertialSlideListener);
    }

    freeBoxSetState?.call();
  }

  /// 滑动至目标位置。
  void targetSlide({required FreeBoxCamera targetCamera, required bool rightNow}) {
    animationController!.stop();

    if (rightNow) {
      freeBoxCamera.expectPosition = targetCamera.expectPosition;
      freeBoxCamera.expectScale = targetCamera.expectScale;
      freeBoxSetState?.call();
      return;
    }

    animationController!.duration = const Duration(seconds: 1);
    _positionAnimation =
        animationController!.drive(CurveTween(curve: Curves.easeInOutBack)).drive(Tween<Offset>(begin: freeBoxCamera.expectPosition, end: targetCamera.expectPosition));
    _scaleAnimation = animationController!.drive(CurveTween(curve: Curves.easeInOutBack)).drive(Tween<double>(begin: freeBoxCamera.expectScale, end: targetCamera.expectScale));

    animationController!.forward(from: 0.4);
    animationController!.addListener(_targetSlideListener);
  }

  /// 滑动至目标位置监听
  void _targetSlideListener() {
    freeBoxCamera.expectPosition = _positionAnimation!.value;
    freeBoxCamera.expectScale = _scaleAnimation!.value;

    /// 被 stop() 或 动画播放完成 时, removeListener()
    if (animationController!.isDismissed || animationController!.isCompleted) {
      animationController!.removeListener(_targetSlideListener);
    }

    freeBoxSetState?.call();
  }

  /// 屏幕坐标转盒子坐标
  ///
  /// 减去 [freeBoxTopLeftOffset] 目的之一是为了不让 多位数 的结果存储，而只存储非偏移的数据，例如，只存 Offset(123,456)，而不存 Offset(10123,10456)。
  ///
  /// 注意，是基于 [screenPosition]\ [position]\[expectScale] 属性定位。
  Offset screenToBoxActual(Offset screenPosition) {
    return (screenPosition - freeBoxCamera.getActualPosition()) / freeBoxCamera.expectScale - freeBoxTopLeftOffset;
  }
}
