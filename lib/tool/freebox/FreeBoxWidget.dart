part of freebox;

class FreeBoxCamera {
  FreeBoxCamera({required this.expectPosition, required this.expectScale});

  /// 缩放值。
  double expectScale;

  /// 期望位置。
  Offset expectPosition;

  /// 获取实际位置。
  Offset getActualPosition() => expectPosition - freeBoxTopLeftOffset;
}

class FreeBoxStack extends StatefulWidget {
  const FreeBoxStack({required this.builder, Key? key}) : super(key: key);

  final List<Widget> Function(BuildContext context, void Function(void Function()) bSetState) builder;

  @override
  _FreeBoxStackState createState() => _FreeBoxStackState();
}

class _FreeBoxStackState extends State<FreeBoxStack> {
  @override
  Widget build(BuildContext context) => Stack(children: widget.builder(context, setState));
}

/// 元素在盒子中的定位
class FreeBoxPositioned extends StatelessWidget {
  const FreeBoxPositioned({required this.expectPosition, required this.child, Key? key}) : super(key: key);

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
